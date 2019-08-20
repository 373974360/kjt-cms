/**
 * 
 */
package com.cms.siteconfig.collection;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.cms.content.DateUtils;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-08-20 10:33:12
 * 
 */
@Bizlet("")
public class ResolveHtml {
	/**
	 * @param listPageStr
	 *            整个页面的 html
	 * @param domain
	 * @param containerSelector
	 *            容器的 selector
	 * @param linkSelector
	 *            列表中链接的 selector
	 * @param parentUrl
	 * @return
	 */
	public static LinkedHashSet<String> ResolveHtmlForLink(String listPageStr, String domain, String containerSelector, String linkSelector, String parentUrl) {
		LinkedHashSet waitResolveInfoSet = new LinkedHashSet();
		containerSelector = containerSelector.trim();
		linkSelector = linkSelector.trim();
		Document doc = Jsoup.parse(listPageStr);
		Elements list = doc.select(containerSelector);
		Elements links = list.select(linkSelector);
		for (Element link : links) {
			String linkHref = link.attr("href");
			if (StringUtils.isNotBlank(linkHref)) {
				String waitLink = DownHtmlUtil.formatLink(parentUrl, linkHref,
						domain);
				if (StringUtils.isNotBlank(waitLink)) {
					waitResolveInfoSet.add(waitLink);
				}
			}
		}
		return waitResolveInfoSet;
	}

	public static void getArticleInfoHtml(DataObject obj, LinkedHashSet<String> waitgetArtInfoSet) {
		if ((waitgetArtInfoSet != null) && (waitgetArtInfoSet.size() > 0)) {
			for (int i = waitgetArtInfoSet.size(); i > 0; i--) {
				String url = (String) waitgetArtInfoSet.iterator().next();
				if(queryCollInfoByUrl(url)==0){
					String contentHtml = DownHtmlUtil.downLoadHtml(url, obj.getString("pageCharset"));
					waitgetArtInfoSet.remove(url);
					if (StringUtils.isNotBlank(contentHtml)) {
						DataObject dataObj = getArticleInfo(obj, contentHtml, url);
						DataObject infoObj = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
						DatabaseExt.getPrimaryKey(infoObj);
						String infoId = infoObj.getString("id");
						infoObj.setString("siteId", "21");
						infoObj.setString("catId", obj.getString("catId"));
						infoObj.setString("infoTitle",dataObj.getString("title"));
						infoObj.setString("author",dataObj.getString("author"));
						infoObj.setString("source",dataObj.getString("source"));
						infoObj.setString("editor","数据采集");
						infoObj.setString("weight", "60");
						infoObj.setString("hits", "0");
						infoObj.setString("isTop", "2");
						infoObj.setString("isTuijian", "2");
						infoObj.setString("releasedDtime", StringUtils.isNotBlank(dataObj.getString("dtime"))?dataObj.getString("dtime"):DateUtils.getCurrTime());
						infoObj.setString("inputUser", "1");
						infoObj.setString("inputDtime", DateUtils.getCurrTime());
						infoObj.setString("gkNo",dataObj.getString("docno"));
						infoObj.setString("keywords",dataObj.getString("keywords"));
						infoObj.setString("sourceUrl",url);
						if(obj.getString("isStatus").equals("1")){
							infoObj.setString("infoStatus","3");
						}else{
							infoObj.setString("infoStatus","1");
						}
						if(obj.getString("modelType").equals("1")){
							infoObj.setString("modelId","article");
							DataObject infoContentObj = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoContent");
							infoContentObj.setString("infoId",infoId);
							infoContentObj.setString("infoContent",dataObj.getString("content"));
							DatabaseExt.getPrimaryKey(infoContentObj);
							DatabaseUtil.insertEntity("default", infoObj);
							DatabaseUtil.insertEntity("default", infoContentObj);
						}else{
							infoObj.setString("modelId","link");
							infoObj.setString("contentUrl",url);
							DatabaseUtil.insertEntity("default", infoObj);
						}
						System.out.println("地址："+url+"；采集成功");
					}
					try {
						Thread.sleep(1000L);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}else{
					System.out.println("地址："+url+"；已采集");
				}
			}
		}
	}

	public static DataObject getArticleInfo(DataObject obj, String contentHtmlStr, String url) {
		DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
		if (contentHtmlStr.length() > 0) {
			Document parse = Jsoup.parse(contentHtmlStr);
			String artTitle = "";
			if ((StringUtils.isNotBlank(obj.getString("titleTagsStart"))) && (StringUtils.isNotBlank(obj.getString("titleTagsEnd")))) {
				Element select = parse.select(obj.getString("titleTagsStart")).first();
				if (select != null) {
					artTitle = select.text();
					dtr.setString("title", artTitle);
				}
			}
			String artContent = "";
			if ((StringUtils.isNotBlank(obj.getString("contentTagsStart"))) && (StringUtils.isNotBlank(obj.getString("contentTagsEnd")))) {
				Element select = parse.select(obj.getString("contentTagsStart")).first();
				if (select != null) {
					artContent = select.html();
					if (StringUtils.isNotBlank(artContent)) {
						artContent = artContent.trim();
						if (obj.getString("collImages").equals("1")) { //是否抓取图片
							Elements imgList = select.select("img");
							if (imgList.size() > 0) {
								Iterator<Element> iterator = imgList.iterator();
								while (iterator.hasNext()) {
									Element img = iterator.next();
									String imgLink = img.attr("src");
	                                if (imgLink.startsWith("http://10.") || imgLink.startsWith("http://192.168")) {
	                                    continue;
	                                }
	                                String imageFullUrl = getAbsUrl(url, imgLink);
	                                try {
	                                    URL imageURL = new URL(imageFullUrl);
	                                    String relativeRootUrlPath = imageURL.getPath();
	                                    if (DownHtmlUtil.writePicToLocal(imageFullUrl, relativeRootUrlPath)) {
	                                        String replacement = "/collArtPic" + relativeRootUrlPath;
	                                        artContent = artContent.replaceAll(imgLink, replacement);
	                                    }
	                                } catch (MalformedURLException e) {
	                                    e.printStackTrace();
	                                }
								}
							}
						}
						dtr.setString("content", artContent);
					}
				}
			}
			String artAuthor = "";
			if ((StringUtils.isNotBlank(obj.getString("authorTagsStart"))) && (StringUtils.isNotBlank(obj.getString("authorTagsEnd")))) {
				Element select = parse.select(obj.getString("authorTagsStart")).first();
				if (select != null) {
					artAuthor = select.text();
					dtr.setString("author", artAuthor);
				}
			}
			String artDocNo = "";
			if ((StringUtils.isNotBlank(obj.getString("docnoTagsStart"))) && (StringUtils.isNotBlank(obj.getString("docnoTagsEnd")))) {
				Element select = parse.select(obj.getString("docnoTagsStart")).first();
				if (select != null) {
					artDocNo = select.text();
					dtr.setString("docno", artDocNo);
				}
			}
			String artDtime = "";
			if ((StringUtils.isNotBlank(obj.getString("dtimeTagsStart"))) && (StringUtils.isNotBlank(obj.getString("dtimeTagsEnd")))) {
				Element select = parse.select(obj.getString("dtimeTagsStart")).first();
				if (select != null) {
					artDtime = select.text();
					dtr.setString("dtime", artDtime);
				}
			}
			String artSource = "";
			if ((StringUtils.isNotBlank(obj.getString("sourceTagsStart"))) && (StringUtils.isNotBlank(obj.getString("sourceTagsEnd")))) {
				Element select = parse.select(obj.getString("sourceTagsStart")).first();
				if (select != null) {
					artSource = select.text();
					dtr.setString("source", artSource);
				}
			}
			String artKeywords = "";
			if ((StringUtils.isNotBlank(obj.getString("keywordsTagsStart"))) && (StringUtils.isNotBlank(obj.getString("keywordsTagsEnd")))) {
				Element select = parse.select(obj.getString("keywordsTagsStart")).first();
				if (select != null) {
					artKeywords = select.text();
					dtr.setString("keywords", artKeywords);
				}
			}
		}
		return dtr;
	}

	public static String filterTitleKeyWord(String title) {
		String[] s = { "|", "_", "-" };
		for (int i = 0; i < s.length; i++) {
			if (title.contains(s[i])) {
				title = title.substring(0, title.indexOf(s[i]));
			}
		}
		return title;
	}
	public static String getAbsUrl(String absolutePath, String relativePath) {
        try {
            URL absoluteUrl = new URL(absolutePath);
            URL parseUrl = new URL(absoluteUrl, relativePath);
            String s = parseUrl.toString();
            List<String> urlPart = new ArrayList<String>();
            String rootUrl = s.substring(0, s.indexOf("/", s.indexOf("//")));
            urlPart.add(rootUrl);
            for (String part : s.substring(s.indexOf("/", s.indexOf("//") + 1)).split("/")) {
                try {
                    urlPart.add(URLEncoder.encode(part, "utf-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            String resultUrl = StringUtils.join(urlPart, "/");
            return resultUrl;
        } catch (MalformedURLException e) {
            return "";
        }
    }
	
	
	public static int queryCollInfoByUrl(String url) {
		int counts = 0;
		String sql = "select count(*) as totle from cms_info where source_url = '"+url+"'";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				counts = rs.getInt("TOTLE");
			}
			return counts;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}

	private static void close(Connection conn) {
		if (conn == null)
			return;
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static void close(Statement stmt) {
		if (stmt == null)
			return;
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static void close(ResultSet rs) {
		if (rs == null)
			return;
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
