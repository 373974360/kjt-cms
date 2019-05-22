/**
 * 
 */
package com.cms.siteview.velocity;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

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
    @SuppressWarnings("unchecked")
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
}
