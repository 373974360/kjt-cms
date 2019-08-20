/**
 * 
 */
package com.cms.view.velocity;

import java.io.BufferedReader;
import java.io.File;
import java.io.Reader;
import java.sql.Clob;
import java.text.ParseException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cms.siteconfig.TempletUtils;
import com.eos.data.datacontext.IMapContextFactory;
import com.eos.data.datacontext.IRequestMap;
import com.eos.data.datacontext.ISessionMap;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-22 11:31:45
 *
 */
@Bizlet("")
public class FormatUtil {
	/**
     * 从request中获取参数，并拼成url形式的字符串 xxx=aa&bbb=11
     * @param String  字符串
     * @return boolean true正确的，false有问题的
     * */
	public static String getParameterStrInRequest(HttpServletRequest request) {
    	String parms = "";
    	Enumeration enumOne = request.getParameterNames();
    	while(enumOne.hasMoreElements()){ 
          		String p_name=(String)enumOne.nextElement();
       			parms += "&"+p_name+"="+request.getParameter(p_name);
        	}
    	if(parms != null && parms.length() > 0)
    		parms = parms.substring(1);
    	return parms;
    }
    
    /**
     * 判断是否是数字
     * @param String  字符串
     * @return boolean 
     * */
    public static boolean isNumeric(String str){
    	if(str != null && !"".equals(str) && !str.startsWith("0")){
    		for(int i=str.length();--i>=0;){
    			int chr=str.charAt(i);
    			if(chr<48||chr>57)
    				return false;
    		}
    		return true;
    	}else
    		return false;
    }
    
    /**
     * 对字串进行处理，防止空字串产生错误
     * @param String 
     * @return String 格式化后的字串
     * */
    public static String formatNullString(String str) {
        if (str == null || str.trim().equals("")) {
            str = "";
        }
        return str;
    }
    
    /**
     * 截取字符串
     * @param String int 字串
     * @param int length 显示长度
     * @param String paddingStr 补充替换的字符串
     * @return String
     * */
    public static String cutString(String str,int length,String paddingStr){
    	if(str != null && str.length() > 0){
    		String new_str = "";
    		char[] c = str.toCharArray();
            int len = 0;
            for (int i = 0; i < c.length; i++) {            	
            	if(len >= length*2-1){
            		return new_str + paddingStr;
            	}
                len++;
                if (!isLetter(c[i])) {                	
                    len++;
                }  
                new_str += c[i];
            }
            return new_str;
    	}else
    		return "";
    }

    /**
     * 判断是否是中文
     * @param char c
     * @return boolean
     * */
    public static boolean isLetter(char c) {
        int k = 0x80;
        return c / k == 0 ? true : false;
    }
    /**
     * 格式化日期时间字串为指定的格式字串
     * @param String 时间字串
     * @param String 时间字串的日期格式，如yyyy-MM-dd
     * @return String　格式化后的字串，格式如：2003-12-02 12:12:10
     * */
    public static String formatDate(String dateStr, String pattern) throws
        ParseException {  
    	if(dateStr == null || "".equals(dateStr))
    		return "";
    	else
    		return DateUtil.formatToString(dateStr,pattern);
    }
    
    public static String clobToStr(Clob clob){
		String content = "";
		try {
			if(clob!=null){
				Reader is = clob.getCharacterStream();
				BufferedReader buff = new BufferedReader(is);// 得到流
				String line = buff.readLine();
				StringBuffer sb = new StringBuffer();
				while (line != null) {// 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
					sb.append(line);
					line = buff.readLine();
				}
				content = sb.toString();
			}
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return content;
	}
    
    /**

     * 格式化路径，分隔符用系统分隔符，结尾不带分隔符

     *

     * @param pathStr 被格式化的路径

     * @return 格式化后的路径

     * */

    public static String formatPath(String pathStr) {
    	   	
    	pathStr = pathStr.replace('/', File.separatorChar);    		
	    pathStr = pathStr.replace('\\', File.separatorChar);
    	
        if (pathStr.endsWith(File.separator)) {

            pathStr = pathStr.substring(0, pathStr.length() - 1);

            pathStr = formatPath(pathStr);

        }
        return pathStr;

    }
    @Bizlet("")
    public static String getIpAddr(){
		IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper.getMapContextFactory();
		IRequestMap requestMap = contextFactory.getRequestMap();
		Object requestRoot = requestMap.getRootObject();
		HttpServletRequest request = (HttpServletRequest)requestRoot;
		String ip = request.getHeader("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
	}
    
    
    public static String filterHtmlTag(String content){
        String result= HtmlRegexpUtil.filterHtml(content);
        result = HtmlRegexpUtil.filterSpace(result);
        return result.replaceAll("　","").replaceAll("&nbsp;"," ").replaceAll(" ","");
    }
}
