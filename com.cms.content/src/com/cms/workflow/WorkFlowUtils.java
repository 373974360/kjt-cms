/**
 * 
 */
package com.cms.workflow;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.system.annotation.Bizlet;


/**
 * @author chaoweima
 * @date 2019-05-30 09:52:33
 *
 */
@Bizlet("工作流相关逻辑")
public class WorkFlowUtils {
	
	@Bizlet("获取流程步骤总数")
	public static int getWfStepNum(String wfId,String stepSort) {
		int num = 0;
		String sql = "select step_num from cms_workflow where id = "+wfId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("step_num");
			}
			if(num == Integer.parseInt(stepSort)){
				return 0;
			}else{
				return 1;
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	@Bizlet("获取流程步骤总数")
	public static int getWfStepNum(String wfId) {
		int num = 0;
		String sql = "select step_num from cms_workflow where id = "+wfId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("step_num");
			}
			return num;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	@Bizlet("获取流程步骤总数")
	public static int getNextStepNum(String stepSort) {
		return Integer.parseInt(stepSort)+1;
	}

	@Bizlet("判断当前用户是否有终审权限")
	public static int getMaxStepNumByUserId(String userId,String wfId){
		int num = 0;
		String sql = "SELECT max(step_sort) as step_sort FROM cms_workflow_step WHERE step_role IN ( SELECT role_id FROM cap_partyauth WHERE party_id = "+userId+" ) and work_id="+wfId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("step_sort");
			}
			if(num == getWorkFlowStepNum(wfId)){
				return 1;
			}else{
				return 0;
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	public static int getWorkFlowStepNum(String wfId){
		int num = 0;
		String sql = "select step_num from cms_workflow where id = "+wfId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("step_num");
			}
			return num;
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
