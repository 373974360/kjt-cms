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
import java.util.List;

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
				infoUser.setUserName(rs.getString("empname"));
				int count = infoCountByUserId(rs.getString("empid"),startTime,endTime);
				int publishCount = infoPublishCountByUserId(rs.getString("empid"),startTime,endTime);
				infoUser.setCount(count);
				infoUser.setPublisCount(publishCount);
				String proportion = numberFormat.format((float)publishCount/(float)count*100)+"%";
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
	

	public static int infoPublishCountByUserId(String inputUser,String startTime,String endTime){
		int count = 0;
		String sql = "select  count(*) as totle from cms_info where input_user = "+inputUser+" and info_status = 3 and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"'";
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
	
	public static int infoCountByUserId(String inputUser,String startTime,String endTime){
		int count = 0;
		String sql = "select  count(*) as totle from cms_info where input_user = "+inputUser+" and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"'";
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
