/**
 * 
 */
package com.cms.content;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-15 17:41:21
 *
 */
@Bizlet("日期格式化")
public class DateUtils {
	
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat yearDf = new SimpleDateFormat("yyyy");

	/**
	 * @param date
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("日期格式化")
	public static String dateFormat(String date) {
		if(!StringUtil.isBlank(date)){
			return date.replace("T", " ");
		}else{
			return null;
		}
	}
	
	/**
	 * @param date
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("日期格式化")
	public static String dateFormat2(String date) {
		if(!StringUtil.isBlank(date)){
			return date.replace("T", " ").substring(0,10);
		}else{
			return null;
		}
	}
	

	@Bizlet("日期格式化")
	public static String getCurrTime() {
		return df.format(new Date());
	}
	@Bizlet("日期格式化")
	public static String getYear() {
		return yearDf.format(new Date());
	}

}
