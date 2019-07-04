/**
 * 
 */
package com.cms.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cms.count.vo.CmsInfoOrg;
import com.cms.view.velocity.DateUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-14 16:01:56
 *
 */
@Bizlet("")
public class InfoCountOrgUtil {
	@Bizlet("按照栏目统计信息")
	public static List<CmsInfoOrg> infoCountByOrg(String orgPid,String catId,String startTime,String endTime){
		if(StringUtil.isBlank(catId)){
			catId="all";
		}
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select * from (select u.*,NVL(i.totle,0) as totle from org_organization u left join (select count(*) as totle,org_id from cms_info group by org_id) i on u.orgid=i.org_id where u.parentorgid = "+orgPid+") t order by t.totle desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		Map<String, String> countMap = infoCountByOrgId(catId,startTime,endTime);
		Map<String, String> publishCountMap = infoPublishCountByOrgId(catId,startTime,endTime);
		Map<String, String> upMonthCountMap = infoUpMonthCountByOrgId(catId);
		Map<String, String> yearCountMap = infoYearCountByOrgId(catId,endTime);
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsInfoOrg> list = new ArrayList<CmsInfoOrg>();
			//创建一个数值格式化对象   
			NumberFormat numberFormat = NumberFormat.getInstance();   
			//设置精确到小数点后2位   
			numberFormat.setMaximumFractionDigits(2);
			while (rs.next()) {
				CmsInfoOrg infoOrg = new CmsInfoOrg();
				infoOrg.setOrgId(rs.getInt("orgid"));
				infoOrg.setOrgName(rs.getString("orgname"));
				int count = 0;
				int publishCount = 0;
				int upMonthCount = 0;
				int yearCount = 0;
				if(countMap.containsKey(rs.getString("orgid"))){
					count = Integer.parseInt(countMap.get(rs.getString("orgid")));
				}
				if(publishCountMap.containsKey(rs.getString("orgid"))){
					publishCount = Integer.parseInt(publishCountMap.get(rs.getString("orgid")));
				}
				if(upMonthCountMap.containsKey(rs.getString("orgid"))){
					upMonthCount = Integer.parseInt(upMonthCountMap.get(rs.getString("orgid")));
				}
				if(yearCountMap.containsKey(rs.getString("orgid"))){
					yearCount = Integer.parseInt(yearCountMap.get(rs.getString("orgid")));
				}
				infoOrg.setCount(count);
				infoOrg.setPublisCount(publishCount);
				infoOrg.setUpMonthCount(upMonthCount);
				infoOrg.setYearCount(yearCount);
				String proportion = "";
				if(count==0&&publishCount==0){
					proportion = "-";
				}else{
					proportion = numberFormat.format((float)publishCount/(float)count*100)+"%";
				}
				infoOrg.setProportion(proportion);
				list.add(infoOrg);
			}
			return list;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	

	public static Map<String, String> infoPublishCountByOrgId(String catId,String startTime,String endTime){
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select org_id,count(*) as totle from cms_info where cat_id in ("+catId+") and info_status = 3 and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by org_id";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("org_id"),  rs.getString("totle"));
			}
			return map;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static Map<String, String> infoCountByOrgId(String catId,String startTime,String endTime){
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select org_id,count(*) as totle from cms_info where cat_id in ("+catId+") and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by org_id";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("org_id"),  rs.getString("totle"));
			}
			return map;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static Map<String, String> infoUpMonthCountByOrgId(String catId){
		Map<String, String> dateMap = getFirstday_Lastday_Month(new Date());
		String startTime = dateMap.get("first")+" 00:00:00";
		String endTime = dateMap.get("last")+" 23:59:59";
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select org_id,count(*) as totle from cms_info where cat_id in ("+catId+") and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by org_id";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("org_id"),  rs.getString("totle"));
			}
			return map;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static Map<String, String> infoYearCountByOrgId(String catId,String endTime){
		String year = DateUtil.getCurrentDateTime("yyyy");
		String startTime = year+"-01-01 00:00:00";
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select org_id,count(*) as totle from cms_info where cat_id in ("+catId+") and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by org_id";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("org_id"),  rs.getString("totle"));
			}
			return map;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	
	/**
     * 某一个月第一天和最后一天
     * @param date
     * @return
     */
    private static Map<String, String> getFirstday_Lastday_Month(Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, -1);
        Date theDate = calendar.getTime();
        
        //上个月第一天
        GregorianCalendar gcLast = (GregorianCalendar) Calendar.getInstance();
        gcLast.setTime(theDate);
        gcLast.set(Calendar.DAY_OF_MONTH, 1);
        String day_first = df.format(gcLast.getTime());
        StringBuffer str = new StringBuffer().append(day_first).append(" 00:00:00");
        day_first = str.toString();
 
        //上个月最后一天
        calendar.add(Calendar.MONTH, 1);    //加一个月
        calendar.set(Calendar.DATE, 1);        //设置为该月第一天
        calendar.add(Calendar.DATE, -1);    //再减一天即为上个月最后一天
        String day_last = df.format(calendar.getTime());
        StringBuffer endStr = new StringBuffer().append(day_last).append(" 23:59:59");
        day_last = endStr.toString();
 
        Map<String, String> map = new HashMap<String, String>();
        map.put("first", day_first);
        map.put("last", day_last);
        return map;
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
