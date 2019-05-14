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
 * @author maxiaoqiang
 * @version 1.00.00
 * 
 */

@Bizlet("群众来信全量")
public class QueryCommonalityAll {

	/**
	 * @param dsName
	 * @return
	 * @author maxiaoqiang
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] querySqTitle(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "SELECT id,title from CMS_Sq ORDER by id asc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.commonality.sq.CmsSq");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("title", rs.getString("title"));
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
