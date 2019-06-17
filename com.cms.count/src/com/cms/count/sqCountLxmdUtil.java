/**
 * 
 */
package com.cms.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.count.vo.CmsSqLxmd;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author maxiaoqiang
 * @version 1.00.00
 * 
 */

@Bizlet("")
public class sqCountLxmdUtil {
	@Bizlet("按照来信目的统计来信")
	public static List<CmsSqLxmd> sqCountByLxmd(String startTime,String endTime){
		
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select * from ( select cl.*,nvl( m.totle, 0 ) as totle from cms_lxmd cl left join ( select count( * ) as totle, md_id from cms_sq group by md_id ) m on cl.id = m.md_id ) t order by t.totle desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsSqLxmd> list = new ArrayList<CmsSqLxmd>();
			while (rs.next()) {
				CmsSqLxmd sqLxmd = new CmsSqLxmd();
				sqLxmd.setMdName(rs.getString("MD_NAME"));
				int count = sqCountByMdId(rs.getString("ID"),startTime,endTime);
				int repliedCount = sqRepliedCountByMdId(rs.getString("ID"),startTime,endTime);
				int noReCount = count - repliedCount;
				sqLxmd.setCount(count);
				sqLxmd.setNoReCount(noReCount);
				sqLxmd.setRepliedCount(repliedCount);
				
				list.add(sqLxmd);
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
	//通过来信目的查询来信数量
	public static int sqCountByMdId(String mdId,String startTime,String endTime){
		int count = 0;
		String sql = "select count(*) as totle from cms_sq where md_Id = "+ mdId +" and CREATE_TIME >= '"+startTime+"' and CREATE_TIME<='"+endTime+"'";
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
	//通过来信目的查询已回复来信数量
	public static int sqRepliedCountByMdId(String mdId,String startTime,String endTime){
		int count = 0;
		String sql = "select count(*) as totle from cms_sq where md_id = "+ mdId +" and IS_REPLY = 1 and CREATE_TIME >= '"+startTime+"' and CREATE_TIME<='"+endTime+"'";
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
