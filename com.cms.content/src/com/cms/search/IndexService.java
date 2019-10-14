/**
 * 
 */
package com.cms.search;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.lang.StringUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;

import com.cms.view.velocity.FormatUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author chaoweima
 * @date 2019-06-03 18:07:42
 *
 */
@Bizlet("")
public class IndexService {
	/**
     * 往索引文件中追加site_id的全部索引
     * @param infos Hashtable  输入信息   如信息site_id {site_id:ABCDEFG}
     * @return boolean
     */
	public static boolean appendALlDocument(String siteId) {
		int s_count = 50;
		IndexWriter indexWriter = null;
		try{
			 int count = getInfoCount(siteId);//信息总数
			 int page=count/s_count+1;
			 //System.out.println( mapSite + "appendALlDocument info count===" + count);
			 
			 //索引字段
			 Field idField = new Field("id", "",Field.Store.YES, Field.Index.NOT_ANALYZED);
			 Field categoryIdField = new Field("catId", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field titleField = new Field("infoTitle", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field model_idField = new Field("modelId", "",Field.Store.YES, Field.Index.NOT_ANALYZED);
			 Field typeField = new Field("infoType", "",Field.Store.YES, Field.Index.NOT_ANALYZED);
			 Field urlField = new Field("contentUrl", "",Field.Store.YES, Field.Index.NOT_ANALYZED);
			 Field publish_timeField = new Field("publishTime", "",Field.Store.YES, Field.Index.NOT_ANALYZED);
			 Field contentField = new Field("infoContent", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkNoField = new Field("gkNo", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field siteIdField = new Field("siteId", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkDeptField = new Field("gkDept", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkCwrqField = new Field("gkCwrq", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkFwrqField = new Field("gkFwrq", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkWjyxxField = new Field("gkWjyxx", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field isPicField = new Field("isPic", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field thumbUrlField = new Field("thumbUrl", "",Field.Store.YES, Field.Index.ANALYZED);
			 
			 
			 //得到indexWriter
			 indexWriter = IndexLuceneManager.getIndexModifier(false);
					
			 //循环信息列表
			 for(int k=0;k<page;k++){
	    		  int start_num = s_count*k;
	    		  int page_size = s_count;
	    		 
	    		  DataObject[] infoList = getInfoList(siteId,start_num,page_size);
	    		  
	    		  for(DataObject infoObj : infoList){
	    			  //Document对象不要重用，Field对象可以重用 以加快速度
	    			  Document doc = new Document();
	    			 
	    			  typeField.setValue(infoObj.getString("infoType")==null?"":infoObj.getString("infoType"));
	    			  doc.add(typeField);
	    			  
	    			  idField.setValue(infoObj.getString("id"));
	    			  doc.add(idField);
	    			  
	    			  titleField.setValue(infoObj.getString("infoTitle"));
	    			  doc.add(titleField);
	    			  
	    			  urlField.setValue(infoObj.getString("contentUrl"));
	    			  doc.add(urlField);
	    			  
	    			  categoryIdField.setValue(infoObj.getString("catId"));
	    			  doc.add(categoryIdField);
	    			  
	    			  publish_timeField.setValue(infoObj.getString("releasedDtime"));
	    			  doc.add(publish_timeField);
	    			  
	    			  gkNoField.setValue(infoObj.getString("gkNo")==null?"":infoObj.getString("gkNo"));
	    			  doc.add(gkNoField);

	    			  siteIdField.setValue(infoObj.getString("siteId"));
	    			  doc.add(siteIdField);
	    			  
	    			  String modelId = infoObj.getString("modelId");
	    			  model_idField.setValue(modelId);
	    			  doc.add(model_idField);

	    			  
	    			  String thumbUrl = infoObj.getString("thumbUrl");
	    			  if(StringUtils.isNotBlank(thumbUrl)){
	    				  isPicField.setValue("true");
	    				  thumbUrlField.setValue(thumbUrl);
	    			  }else{
	    				  isPicField.setValue("false");
	    				  thumbUrlField.setValue("");
	    			  }
	    			  doc.add(isPicField);
	    			  doc.add(thumbUrlField);
	    			  
	    			  gkDeptField.setValue(infoObj.getString("gkDept")==null?"":infoObj.getString("gkDept"));
	    			  doc.add(gkDeptField);
	    			  
	    			  gkCwrqField.setValue(infoObj.getString("gkCwrq")==null?"":infoObj.getString("gkCwrq"));
	    			  doc.add(gkCwrqField);
	    			  
	    			  gkFwrqField.setValue(infoObj.getString("gkFwrq")==null?"":infoObj.getString("gkFwrq"));
	    			  doc.add(gkFwrqField);
	    			  
	    			  gkWjyxxField.setValue(infoObj.getString("gkWjyxx")==null?"":infoObj.getString("gkWjyxx"));
	    			  doc.add(gkWjyxxField);
	    			  
	    			  String content = "";
	    			  if(modelId.equals("article")||modelId.equals("pic")||modelId.equals("video")||modelId.equals("doc")){
	    				  content = getInfoContent(infoObj.getString("id"));
	    			  }
	    			  contentField.setValue(content);
	    			  doc.add(contentField);
	    			  //添加一条条info的索引
	    			  IndexLuceneManager.AddDocument(indexWriter,doc);
	    		  }
			 }
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally{
			//关闭indexWriter
			IndexLuceneManager.closeIndexWriter(indexWriter);
		}    
		return true;
	}
	
	/**
	 * 往索引文件中追加一条记录
	 * 
	 * @param infos
	 *            Hashtable 输入信息,如信息id {id:110}
	 * @return boolean
	 */
	public static boolean appendSingleDocumentAppIdInfo(String infoId) {
		// 得到indexWriter
		IndexWriter indexWriter = null;
		try {
			// 得到indexWriter
			indexWriter = IndexLuceneManager.getIndexModifier(false);
			DataObject infoObj = getInfo(infoId);

			Field idField = new Field("id", "", Field.Store.YES, Field.Index.NOT_ANALYZED);
			Field categoryIdField = new Field("catId", "", Field.Store.YES, Field.Index.ANALYZED);
			Field titleField = new Field("infoTitle", "", Field.Store.YES, Field.Index.ANALYZED);
			Field model_idField = new Field("modelId", "", Field.Store.YES, Field.Index.NOT_ANALYZED);
			Field typeField = new Field("infoType", "", Field.Store.YES, Field.Index.NOT_ANALYZED);
			Field urlField = new Field("contentUrl", "", Field.Store.YES, Field.Index.NOT_ANALYZED);
			Field publish_timeField = new Field("publishTime", "", Field.Store.YES, Field.Index.NOT_ANALYZED);
			Field contentField = new Field("infoContent", "", Field.Store.YES, Field.Index.ANALYZED);
			Field gkNoField = new Field("gkNo", "", Field.Store.YES, Field.Index.ANALYZED);
			Field siteIdField = new Field("siteId", "", Field.Store.YES, Field.Index.ANALYZED);
			 Field gkDeptField = new Field("gkDept", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkCwrqField = new Field("gkCwrq", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkFwrqField = new Field("gkFwrq", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field gkWjyxxField = new Field("gkWjyxx", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field isPicField = new Field("isPic", "",Field.Store.YES, Field.Index.ANALYZED);
			 Field thumbUrlField = new Field("thumbUrl", "",Field.Store.YES, Field.Index.ANALYZED);

			// Document对象不要重用，Field对象可以重用 以加快速度
			Document doc = new Document();
			typeField.setValue(infoObj.getString("infoType") == null ? "" : infoObj.getString("infoType"));
			doc.add(typeField);

			idField.setValue(infoObj.getString("id"));
			doc.add(idField);

			titleField.setValue(infoObj.getString("infoTitle"));
			doc.add(titleField);

			urlField.setValue(infoObj.getString("contentUrl"));
			doc.add(urlField);

			categoryIdField.setValue(infoObj.getString("catId"));
			doc.add(categoryIdField);

			publish_timeField.setValue(infoObj.getString("releasedDtime"));
			doc.add(publish_timeField);

			gkNoField.setValue(infoObj.getString("gkNo") == null ? "" : infoObj.getString("gkNo"));
			doc.add(gkNoField);

			siteIdField.setValue(infoObj.getString("siteId"));
			doc.add(siteIdField);

			String modelId = infoObj.getString("modelId");
			model_idField.setValue(modelId);
			doc.add(model_idField);
			  
			  String thumbUrl = infoObj.getString("thumbUrl");
			  if(StringUtils.isNotBlank(thumbUrl)){
				  isPicField.setValue("true");
				  thumbUrlField.setValue(thumbUrl);
			  }else{
				  isPicField.setValue("false");
				  thumbUrlField.setValue("");
			  }
			  doc.add(isPicField);
			  doc.add(thumbUrlField);
			
			 gkDeptField.setValue(infoObj.getString("gkDept")==null?"":infoObj.getString("gkDept"));
			  doc.add(gkDeptField);
			  
			  gkCwrqField.setValue(infoObj.getString("gkCwrq")==null?"":infoObj.getString("gkCwrq"));
			  doc.add(gkCwrqField);
			  
			  gkFwrqField.setValue(infoObj.getString("gkFwrq")==null?"":infoObj.getString("gkFwrq"));
			  doc.add(gkFwrqField);
			  
			  gkWjyxxField.setValue(infoObj.getString("gkWjyxx")==null?"":infoObj.getString("gkWjyxx"));
			  doc.add(gkWjyxxField);

			String content = "";
			if (modelId.equals("article") || modelId.equals("pic") || modelId.equals("video") || modelId.equals("doc")) {
				content = getInfoContent(infoObj.getString("id"));
			}
			contentField.setValue(content);
			doc.add(contentField);
			// 添加一条条info的索引
			IndexLuceneManager.AddDocument(indexWriter, doc);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			// 关闭indexWriter
			IndexLuceneManager.closeIndexWriter(indexWriter);
		}
		return true;
	}
	
	/**
     * 删除索引文件中的一条记录
     * @param infos Hashtable  输入信息,如信息id {id:110}
     * @return boolean
     */
	public static boolean deleteSingleDocument(String infoId) {
		// 得到indexWriter
		IndexWriter indexWriter = null;
		try {
			indexWriter = IndexLuceneManager.getIndexModifier(false);
			Term term = new Term("id", infoId);
			IndexLuceneManager.DeleteDocument(indexWriter, term);

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			// 关闭indexWriter
			IndexLuceneManager.closeIndexWriter(indexWriter);
		}
		return true;
	}
	
	public static int getInfoCount(String catId){
		int count = 0;
		String sql = "select count(i.id) as totle from cms_info i,cms_info_category c where i.cat_id=c.id and site_id='"+catId+"' and c.is_view = 1 and info_status = 3";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				count = rs.getInt("totle");
			}
			return count;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static DataObject[] getInfoList(String siteId,int startNum,int pageSize){
		int counts = 0;
		int it = 0;
		String sql = "select * from (select row_.*, rownum rownum_ from (select i.* from cms_info i,cms_info_category c where i.cat_id=c.id and i.site_id='"+siteId+"' and c.is_view = 1 and i.info_status=3";
		sql += " order by i.id desc) row_ where rownum <="+pageSize+"+"+startNum+") where rownum_ >="+startNum+" + 1";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			it = 0;
			if (null != rs) {
				rs.last();
				counts = rs.getRow();
				rs.beforeFirst();
			}
			DataObject[] dobj = new DataObject[counts];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("modelId", rs.getString("model_id"));
				dtr.setString("infoType", rs.getString("info_type"));
				dtr.setString("contentUrl", rs.getString("content_url"));
				String time = rs.getString("released_dtime");
				time = time == null ? "" : time.replaceAll("-","").replaceAll(" ", "").replaceAll(":","");
				dtr.setString("releasedDtime", time);
				dtr.setString("gkNo", rs.getString("gk_no"));
				dtr.setString("siteId", rs.getString("site_id"));
				dtr.setString("thumbUrl", rs.getString("thumb_url"));
				dobj[it] = dtr;
				it++;
			}
			return dobj;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static DataObject getInfo(String infoId){
		String sql = "select * from cms_info where id = "+infoId+" and info_status = 3";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("modelId", rs.getString("model_id"));
				dtr.setString("infoType", rs.getString("info_type"));
				dtr.setString("contentUrl", rs.getString("content_url"));
				String time = rs.getString("released_dtime");
				time = time == null ? "" : time.replaceAll("-","").replaceAll(" ", "").replaceAll(":","");
				dtr.setString("releasedDtime", time);
				dtr.setString("gkNo", rs.getString("gk_no"));
				dtr.setString("siteId", rs.getString("site_id"));
				dtr.setString("thumbUrl", rs.getString("thumb_url"));
				dobj[0] = dtr;
			}
			return dobj[0];
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	
	public static String getInfoContent(String infoId){
		String result = "";
		String sql = "select info_content from cms_info_content where info_id = "+infoId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				result = FormatUtil.clobToStr(rs.getClob("info_content"));
			}
			if(StringUtils.isNotBlank(result)){
				result = filterHtml(result);
			}
			return result;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	

    /**
     *
     * 基本功能：过滤所有以"<"开头以">"结尾的标签
     * <p>
     *
     * @param String
     * @return String
     */
    public static String filterHtml(String str) {
        if(str==null||(str=str.trim()).length()==0){
            return "";
        }
        Pattern pattern = Pattern.compile("<[^>]+>");
        Matcher matcher = pattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        boolean result1 = matcher.find();
        while (result1) {
            matcher.appendReplacement(sb, "");
            result1 = matcher.find();
        }
        matcher.appendTail(sb);
        return sb.toString();
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
