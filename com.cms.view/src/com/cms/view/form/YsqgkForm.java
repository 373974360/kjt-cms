/**
 * 
 */
package com.cms.view.form;

import javax.servlet.http.HttpSession;

import com.cms.view.velocity.DateUtil;
import com.cms.view.velocity.RandomStrg;
import com.eos.data.datacontext.IMapContextFactory;
import com.eos.data.datacontext.ISessionMap;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-10 10:57:20
 *
 */
@Bizlet("")
public class YsqgkForm {
	private static String defalut_randon_str = "A-Z0-9";//默认随机码显示范围
	


	@Bizlet("")
	public static String getSearchCode(){
		return "YSQGK" + DateUtil.getCurrentDateTime("yyyyMMdd") + RandomStrg.getRandomStr(defalut_randon_str, "6");
	}

	@Bizlet("")
	public static String getSearchPwd(){
		return RandomStrg.getRandomStr(defalut_randon_str,"6");
	}

	@Bizlet("")
	public static boolean chackAuthCode(String authCode){
		boolean b = false;
		String valiCode = getSessionAuthCode();
		if(authCode.equals(valiCode)){
			b = true;
		}
		return b;
	}
	
	
	public static String getSessionAuthCode(){
		IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper.getMapContextFactory();
		ISessionMap sessionMap = contextFactory.getSessionMap();
		Object sessionRoot = sessionMap.getRootObject();
		HttpSession session = (HttpSession)sessionRoot;
		return session.getAttribute("valiCode").toString();
	}
	
}
