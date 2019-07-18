package com.cms.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import com.cms.count.vo.CmsSqOrg;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author maxiaoqiang
 * @version 1.00.00
 * 
 */

@Bizlet("")
public class sqCountOrgUtil {

	@Bizlet("按照部门统计来信")
	public static List<CmsSqOrg> sqCountByOrg(String startTime,String endTime){
		
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select * from (select u.*,NVL(i.totle,0) as totle from org_organization u left join (SELECT count( * ) AS totle,	SUB_ORG_ID FROM	CMS_SQ GROUP BY	SUB_ORG_ID) i ON u.orgid = i.SUB_ORG_ID where u.parentorgid = "+163+") t order by t.totle desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsSqOrg> list = new ArrayList<CmsSqOrg>();
			//创建一个数值格式化对象   
			NumberFormat numberFormat = NumberFormat.getInstance();   
			//设置精确到小数点后2位   
			numberFormat.setMaximumFractionDigits(2);
			while (rs.next()) {
				CmsSqOrg sqOrg = new CmsSqOrg();
				sqOrg.setOrgName(rs.getString("ORGNAME"));
				int count = sqCountByOrgId(rs.getString("orgid"),startTime,endTime);
				int repliedCount = repliedSqCountByOrgId(rs.getString("orgid"),startTime,endTime);
				sqOrg.setCount(count);
				sqOrg.setReplied(repliedCount);
				sqOrg.setInHand(count-repliedCount);
				if (repliedCount == 0) {
					sqOrg.setProportion("0%");
				}else{
					String proportion = numberFormat.format((float)repliedCount/(float)count*100)+"%";
					sqOrg.setProportion(proportion);
				}					
				list.add(sqOrg);
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
	//通过部门查询来信数量
	public static int sqCountByOrgId(String orgId,String startTime,String endTime){
		int count = 0;
		String sql = "select  count(*) as totle from CMS_SQ where SUB_ORG_ID  = "+orgId+" and CREATE_TIME >= '"+startTime+"' and CREATE_TIME<='"+endTime+"'";
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
	//通过部门查询已受理信件数量
	public static int repliedSqCountByOrgId(String orgId,String startTime,String endTime){
		int count = 0;
		String sql = "select  count(*) as totle from CMS_SQ where SUB_ORG_ID = "+orgId+" and IS_REPLY = 1 and CREATE_TIME >= '"+startTime+"' and CREATE_TIME<='"+endTime+"'";
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