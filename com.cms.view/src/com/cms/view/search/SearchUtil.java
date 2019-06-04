/**
 * 
 */
package com.cms.view.search;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.servlet.http.HttpServletRequest;

import com.cms.view.data.CategoryUtil;
import com.cms.view.velocity.DateUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-04 11:04:45
 * 
 */
@Bizlet("")
public class SearchUtil {

	// 把xml字符串转化为map类型
	public static Map initPraToMap(String str) {
		try {
			Map map = new HashMap();
			Node node = XmlManager.createNode(str);
			NodeList nodeList = XmlManager.queryNodeList(node, "//param");
			for (int i = 0; i < nodeList.getLength(); i++) {
				Node node2 = nodeList.item(i);
				String key = XmlManager.queryNodeValue(node2, "./key");
				String value = XmlManager.queryNodeValue(node2, "./value");
				map.put(key, value);
			}
			return map;
		} catch (Exception e) {
			// TODO: handle exception
			return new HashMap();
		}
	}

	public static String deleteCodeByContent(String stringInfo) {
		StringBuffer sb = new StringBuffer();
		String temp1 = "";
		String temp2 = "";
		if (stringInfo.length() < 10) {
			temp1 = stringInfo;
		} else {
			temp1 = stringInfo.substring(0, 10);
			temp2 = stringInfo.substring(10, stringInfo.length());
		}
		Pattern p = Pattern.compile("[.。,，\"“\\?？!！:：'‘《》（(）);；、`~@#￥%……&*$]");// 增加对应的标点
		Matcher m = p.matcher(temp1);
		String first = m.replaceAll("");
		sb.append(first);
		sb.append(temp2);
		return sb.toString();
	}

	// 组合request传递过来的参数
	public static String getXmlParam(HttpServletRequest request) {
		StringBuffer sb = new StringBuffer("");
		try {
			sb.append("<cicro>");
			// 是否启用同音词功能
			String ty = (String) request.getParameter("ty");
			if (ty == null || ("").equals(ty)) {
				ty = "off";
			}
			String q = (String) request.getParameter("q");
			if (q != null && !q.equals("")) {
				if (ty.equals("on")) {
					q = getTongyinciByString(q);
				}
				sb.append("<param><key>q</key><value><![CDATA[" + q + "]]></value></param>");
			}
			String p = (String) request.getParameter("p");
			if (p == null || p.equals("")) {
				p = "1";
			}
			sb.append("<param><key>p</key><value><![CDATA[" + p + "]]></value></param>");
			String pz = (String) request.getParameter("pz");
			if (pz != null && !pz.equals("")) {
				sb.append("<param><key>pz</key><value><![CDATA[" + pz + "]]></value></param>");
			}
			String length = (String) request.getParameter("length");
			if (length != null && !length.equals("")) {
				sb.append("<param><key>length</key><value><![CDATA[" + length + "]]></value></param>");
			}
			String site_id = (String) request.getParameter("siteId") == null ? "" : (String) request.getParameter("siteId");
			if (site_id.equals("")) {
				site_id = (String) request.getAttribute("siteId") == null ? "" : (String) request.getAttribute("siteId");
			}
			if (site_id.equals("")) {
				URL url = new URL(request.getRequestURL().toString());
				String domain = url.getHost();
				DataObject siteObj = CategoryUtil.getSiteByDomain(domain);
				site_id = siteObj.getString("enName");
				sb.append("<param><key>siteId</key><value><![CDATA[" + site_id + "]]></value></param>");
			} else {
				sb.append("<param><key>siteId</key><value><![CDATA[" + site_id + "]]></value></param>");
			}
			String catId = (String) request.getParameter("catId");
			if (catId != null && !catId.equals("")) {
				sb.append("<param><key>catId</key><value><![CDATA[" + catId + "]]></value></param>");
			}
	        String scope = (String)request.getParameter("scope");
	        if(scope!=null && !scope.equals("")){  
	        	sb.append("<param><key>scope</key><value><![CDATA["+scope+"]]></value></param>");
	        }
			String ts = (String) request.getParameter("ts");
			
			if (ts != null && !ts.equals("")) {
				sb.append("<param><key>ts</key><value><![CDATA[" + Encode.iso_8859_1ToUtf8(ts) + "]]></value></param>");
			}
			String te = (String) request.getParameter("te");
			if (te != null && !ts.equals("")) {
				sb.append("<param><key>te</key><value><![CDATA[" + Encode.iso_8859_1ToUtf8(te) + "]]></value></param>");
			}
			sb.append("</cicro>");
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public static String nullToString(String s) {
		if (s == null) {
			s = "";
		}
		return s.trim();
	}

	// 转码
	public static String codeString(String q) {
		String code = "utf8";
		if (q != null && !q.equals("")) {
			if (code.equals("utf8")) {
				q = Encode.iso_8859_1ToUtf8(q);
			} else if (code.equals("gbk")) {
				q = Encode.iso_8859_1ToGbk(q);
			} else if (code.equals("system")) {
				q = Encode.iso_8859_1ToSystem(q);
			}
		} else {
			q = "";
		}
		return q;
	}

	// 通过搜索关键字来得到关键字的同音词
	public static String getTongyinciByString(String keys) {
		StringBuffer sb = new StringBuffer("");
		try {
			if (keys.trim().equals("")) {
				return "";
			}
			String split = " ";
			String[] str = keys.split(split);
			for (String s : str) {
				sb.append(" " + InitCiku.getTongyinci(s));
			}

			return keys + sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return keys;
		}
	}
	// 时间格式化
	public static String formatTimeYYYYMMDDHHMMSS(String time) {
		try {
			if (time.length() >= 14) {
				String YYYY = time.substring(0, 4);
				String MM = time.substring(4, 6);
				String DD = time.substring(6, 8);
				String HH = time.substring(8, 10);
				String M = time.substring(10, 12);
				String SS = time.substring(12, 14);

				return YYYY + "-" + MM + "-" + DD + " " + HH + ":" + M + ":"
						+ SS;
			} else {
				return formatTimeYYYYMMDD(time);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	// 时间格式化
	public static String formatTimeYYYYMMDD(String time) {
		try {
			if (time.length() >= 8) {
				String YYYY = time.substring(0, 4);
				String MM = time.substring(4, 6);
				String DD = time.substring(6, 8);

				return YYYY + "-" + MM + "-" + DD;
			} else {
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
}
