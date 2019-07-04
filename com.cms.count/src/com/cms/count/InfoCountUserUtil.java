/**
 * 
 */
package com.cms.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cms.count.vo.CmsInfoUser;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-14 16:01:56
 *
 */
@Bizlet("")
public class InfoCountUserUtil {
	@Bizlet("按照栏目统计信息")
	public static List<CmsInfoUser> infoCountByUser(String catId,String startTime,String endTime){
		if(StringUtil.isBlank(catId)){
			catId="all";
		}
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select * from (select u.*,NVL(i.totle,0) as totle from org_employee u left join (select count(*) as totle,input_user from cms_info group by input_user) i on u.empid=i.input_user) t order by t.totle desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		Map<String, String> countMap = infoCountByUserId(catId,startTime,endTime);
		Map<String, String> publishCountMap = infoPublishCountByUserId(catId,startTime,endTime);
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsInfoUser> list = new ArrayList<CmsInfoUser>();
			//创建一个数值格式化对象   
			NumberFormat numberFormat = NumberFormat.getInstance();   
			//设置精确到小数点后2位   
			numberFormat.setMaximumFractionDigits(2);
			while (rs.next()) {
				CmsInfoUser infoUser = new CmsInfoUser();
				infoUser.setEmpId(rs.getInt("empid"));
				infoUser.setUserName(rs.getString("empname"));
				int count = 0;
				int publishCount = 0;
				if(countMap.containsKey(rs.getString("empid"))){
					count = Integer.parseInt(countMap.get(rs.getString("empid")));
				}
				if(publishCountMap.containsKey(rs.getString("empid"))){
					publishCount = Integer.parseInt(publishCountMap.get(rs.getString("empid")));
				}
				infoUser.setCount(count);
				infoUser.setPublisCount(publishCount);
				String proportion = "";
				if(count==0&&publishCount==0){
					proportion = "-";
				}else{
					proportion = numberFormat.format((float)publishCount/(float)count*100)+"%";
				}
				infoUser.setProportion(proportion);
				list.add(infoUser);
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
	

	public static  Map<String, String> infoPublishCountByUserId(String catId,String startTime,String endTime){
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select input_user,count(*) as totle from cms_info where cat_id in ("+catId+") and info_status = 3 and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by input_user";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("input_user"),  rs.getString("totle"));
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
	
	public static Map<String, String> infoCountByUserId(String catId,String startTime,String endTime){
		Map<String, String> map = new HashMap<String, String>();
		String sql = "select input_user,count(*) as totle from cms_info where cat_id in ("+catId+") and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"' group by input_user";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put(rs.getString("input_user"),  rs.getString("totle"));
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
