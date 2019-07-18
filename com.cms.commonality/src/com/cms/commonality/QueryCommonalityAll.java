/**
 * 
 */
package com.cms.commonality;

import static com.eos.system.annotation.ParamType.CONSTANT;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.annotation.BizletParam;

import commonj.sdo.DataObject;

/**
 * <pre>
 * Title: 程序的中文名称
 * Description: 程序功能的描述
 * </pre>
 * @author Administrator
 * @version 1.00.00
 * 
 */

public class QueryCommonalityAll {
	/**
	 * 
	 * @param userId
	 * @return
	 */
	@Bizlet("返回用户读取数据的权限")
	public static String getSqUserData(String userId){
		String sqData = "0";
		String sql = "select * from cms_user_data where user_id="+userId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				sqData = rs.getString("sq_data");
			}
			return sqData;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	/**
	 * 
	 * @param dsName
	 * @return
	 * @author MAXIAOQIANG
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] queryOrgName(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select ORGID,ORGNAME FROM ORG_ORGANIZATION WHERE PARENTORGID = 163 ORDER BY ORGID ASC";
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			it = 0;
			if (null != rs) {
				rs.last();
				counts = rs.getRow();
				rs.beforeFirst();
			}	
			DataObject[] dobj = new DataObject[counts];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.commonality.org.OrgOrganization");				
				dtr.setString("orgId", rs.getString("ORGID"));
				dtr.setString("orgName", rs.getString("orgName"));
				dobj[it] = dtr;
				it++;
			}
			return dobj;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject querySqProcess(String sqId,String dsName) {
		DataObject dtr = null;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select SUB_ORG_NAME,TO_ORG_NAME,RE_TYPE,RE_TIME from CMS_SQ_PROCESS WHERE SQ_ID = " + sqId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			
			if (null != rs) {
				rs.last();
				
				rs.beforeFirst();
			}	
		
			while (rs.next()) {
				dtr = DataObjectUtil.createDataObject("com.cms.commonality.sqPro.CmsSqPro");				
				dtr.setString("subOrgName", rs.getString("SUB_ORG_NAME"));
				dtr.setString("reType", rs.getString("RE_TYPE"));
				dtr.setString("toOrgName", rs.getString("TO_ORG_NAME"));
				dtr.setString("reTime", rs.getString("RE_TIME"));		
			}
			return dtr;
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
