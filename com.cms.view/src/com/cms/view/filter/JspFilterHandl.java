/**
 * 
 */
package com.cms.view.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-18 15:24:35
 *
 */
@Bizlet("")
public class JspFilterHandl {
	private static String[] filter_str = {"%df", "%5c", "%27", "%20", "%22", "%27", "%28", "%29", "%3E", "%3e", "%3C", "%3c", "\\", "union", "--", "1=1", "and ", "concat", "acustart", "application", "script", "location", "limit ", "alert", "iframe", "set-cookie", "or ", "drop table", "asc\\(", "mid\\(", "char\\(", "net user", "exists", "alter",
        "+acu+", "onmouseover", "header", "exec ", "insert ", "select ", "select+1", "delete ", "trancate", "update ", "updatexml", "extractvalue", "href=", "data:text", "declare", "master", "execute", "xp_cmdshell", "netlocalgroup", "count\\(", "restore", "floor", "ExtractValue", "UpdateXml",
        "injected", "ACUstart", "ACUend", "():;", "acu:Expre", "window.location.href", "document", "parameter: ", "<OBJECT", "javascript", "confirm", "<script>", "</script>", "..", "cat ", "click", "function", "prompt(", "<", ">", "'", "‘", "’", "�", "ndhlmt:expre", "ssion", "ndhlmt"};

	//李苏培加
    public static boolean isTureKey(String content, String[] filterStr) {
        String contentold = content;
        boolean result = false;//不包含
        try {
            String str[] = filterStr;
            for (int i = 0; i < str.length; i++) {
                String s = str[i];
                if (s != null && !"".equals(s)) {
                    s = s.toString();
                    try {
                        content = contentold.replaceAll("%20", " ").replaceAll("&lt;", "<").replaceAll("&gt;", ">").toLowerCase();
                        content = (content + contentold).replaceAll("<select", "");
                    } catch (Exception e1) {
                        content = contentold.replaceAll("%20", " ").replaceAll("&lt;", "<").replaceAll("&gt;", ">").toLowerCase();
                        content = (content + contentold).replaceAll("<select", "");
                    }
                    result = content.toLowerCase().contains(s);
                    if (result) {
                        break;
                    }
                }
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return true;//包含
        }
    }
    public static boolean isTure(HttpServletRequest request) { //是否包含过滤关键字
        try {
            String queryString = ((HttpServletRequest) request).getQueryString();
            if (queryString == null) {
                queryString = "";
            }
            if (queryString.indexOf("collURL") == -1) {
                for (Enumeration e = request.getParameterNames(); e.hasMoreElements(); ) {
                    Object o = e.nextElement();
                    String arr = (String) o;
                    String value = request.getParameter(arr);
                    if (isTureKey(value, filter_str)) {
                        return true;  //包含要过滤的关键字
                    }
                }
                if ((queryString != null) && (!("".equals(queryString)))) {
                    if (isTureKey(queryString, filter_str)) {
                        return true;  //包含要过滤的关键字
                    }
                }
            }
            return false;//不包含要过滤的关键字
        } catch (Exception e) {
            e.printStackTrace();
            return true;//包含要过滤的关键字
        }
    }

    

    private static String getRequestPayload(ServletRequest req) {
        StringBuilder sb = new StringBuilder();
        try {
            BufferedReader reader = req.getReader();
            char[] buff = new char[1024];
            int len;
            while ((len = reader.read(buff)) != -1) {
                sb.append(buff, 0, len);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }
}
