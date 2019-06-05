/**
 * 
 */
package com.cms.view.velocity;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.sql.Timestamp;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-23 11:12:14
 *
 */
@Bizlet("")
public class DateUtil {
    private static final String DATE_PATTERN = "yyyy-MM-dd";
    private static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static String getCurrentDateTime() {
        return getCurrentDateTime(DATETIME_PATTERN);
    }

    /**
     * 获取当前系统同期。
     * @return 当前系统日期
     * @author zhenggz 2003-11-09
     */
    public static String getCurrentDate() {
        return getCurrentDateTime(DATE_PATTERN);
    }
    /**
     * 获取当前系统时间.
     * @param strPattern 时间模板
     * @return 当前系统时间
     */
    public static String getCurrentDateTime(String pattern) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(cal.getTime());
    }
    
    /**
	 * 得到某个数值之前的日期
	 * 
	 * @param String
	 *            yyyy-MM-dd HH:mm:ss　or yyyy-MM-dd
	 * @param int
	 *            整数
	 * @return String yyyy-MM-dd
	 */
	public static String getDateBefore(String datetimes,int day){   
		   Calendar now =Calendar.getInstance(); 
		   try{
			   now.setTime(getDate(datetimes, DATE_PATTERN));   
		   }catch (ParseException e) {
				System.out.println("时间格式 [ " + datetimes + " ]  无法被解析");				
				return null;
		   }
		   now.set(Calendar.DATE,now.get(Calendar.DATE)-day);   
		   return getString(now.getTime(),"yyyy-MM-dd");   
	}
	 /**
     * 格式化日期时间字串为指定的格式字串
     * @param String 时间字串
     * @param String 时间字串的日期格式，如yyyy-MM-dd
     * @return String　格式化后的字串，格式如：2003-12-02 12:12:10
     * */
    public static String formatToString(String dateStr, String pattern) throws
        ParseException {    
        dateStr = format(dateStr);
        Date date = null;
        if (checkDateString(dateStr)) {
            date = getDate(dateStr, DATE_PATTERN);
            return getString(date, pattern);
        }
        else if (checkDateTimeString(dateStr)) {
            date = getDate(dateStr);
            return getString(date, pattern);
        }
        else {
            throw new ParseException("日期格式不正确", 1);
        }
    }
    
    /**
     * 规范化时间字串
     * @param String 时间字串
     * @return String　格式化后的字串，格式如：2003-12-02 12:12:10 
     * */
    public static String format(String dateStr) {
        Pattern pattern = Pattern.compile("\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}.*");
        Matcher matcher = pattern.matcher(dateStr);
        if (matcher.matches()) {
            dateStr = dateStr.substring(0, 19);
        } else {
            pattern = Pattern.compile(
                "\\d{4}-\\d{2}-\\d{2}.*");
            matcher = pattern.matcher(dateStr);
            if (matcher.matches()) {
                dateStr = dateStr.substring(0, 10);
            }
        }
        return dateStr;
    }
    /**
     * 检查日期字串的格式
     * @param String 时间字串 YYYY-MM-DD
     * @return boolean　true or false
     * */    
    public static boolean checkDateString(String dateStr) {
        Pattern pattern = Pattern.compile("\\d{2,4}-\\d{1,2}-\\d{1,2}");
        Matcher matcher = pattern.matcher(dateStr);
        return matcher.matches();
    }
    /**
     * 把字串转化成为Date对象，时间字串格式需要设定
     *
     * @param dateString 被转化的时间字串
     * @param pattern 时间字串的日期格式，如yyyy-MM-dd
     * @throws ParseException
     * */
    public static Date getDate(String dateStr, String pattern) throws
        ParseException {
        Date date = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        date = dateFormat.parse(dateStr);
        return date;
    }
    /**
     * 按照指定格式取得时间字串
     * @param date Date对象 
     * @param pattern 时间字串的日期格式，如yyyy-MM-dd
     * @return 日期时间字串，格式如：2003-12-02 13:10:00
     * */
    public static String getString(Date date, String pattern) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        return dateFormat.format(date);
    }

    /**
     * 检查日期时间字串的格式
     * @param String 时间字串 YYYY-MM-DD hh:mm:ss
     * @return boolean　true or false
     * */
    public static boolean checkDateTimeString(String dateTimeStr) {
        Pattern pattern = Pattern.compile("\\d{2,4}-\\d{1,2}-\\d{1,2}\\s\\d{1,2}:\\d{1,2}:\\d{1,2}");
        Matcher matcher = pattern.matcher(dateTimeStr);
        return matcher.matches();
    }
    /**
     * 把字串转化成为Date对象，时间字串格式为2000-01-01 00:00:00
     *
     * @param dateString 被转化的时间字串，以 yyyy-MM-dd HH:mm:ss 的格式
     * @throws ParseException
     * */
    public static Date getDate(String dateStr) throws
        ParseException {
        return getDate(dateStr, DATETIME_PATTERN);
    }
    
    /**
	 * 得到指定时间之后的时间
	 * @param String time
	 * @param int num
	 * @return String yyyy-MM-dd hh:mm:ss
	 */
	public static String getDateTimeAfter(String times,int num)
	{
		if(times == null || "".equals(times))
			times = getCurrentDateTime();
		
		long tl = dateToTimestamp(times)+num * 1000;
		return timestampToDate(tl,"yyyy-MM-dd HH:mm:ss");
	}
	/**
	 * 将某个时间的Datetime转换成Timestamp
	 * 
	 * @param dateFormat
	 *            yyyy-MM-dd HH:mm:ss
	 * @return long
	 */
	public static long dateToTimestamp(String dateFormat) {
		long timestamp = -1;
		try {
			DateFormat df = new SimpleDateFormat(DATETIME_PATTERN);
			Date date = df.parse(dateFormat);
			timestamp = date.getTime();
		} catch (Exception e) {
			System.out.println("时间格式 [ " + dateFormat + " ] 无法被解析");
		}
		return timestamp;
	}
	/**
	 * 将某个时间的Timestamp转换成Datetime
	 * 
	 * @param long
	 *            时间数值
	 * @param String
	 *            时间格式　yyyy-MM-dd hh:mm:ss           
	 * @return String yyyy-MM-dd hh:mm:ss
	 */
	public static String timestampToDate(long timestamp, String format) {
		Date date = new Timestamp(timestamp);
		DateFormat df = new SimpleDateFormat(format);
		return df.format(date);
	}
}
