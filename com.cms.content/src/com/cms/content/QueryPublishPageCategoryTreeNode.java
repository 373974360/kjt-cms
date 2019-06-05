/**
 * 
 */
package com.cms.content;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-24 14:32:17
 *
 */
@Bizlet("")
public class QueryPublishPageCategoryTreeNode {
	
	@Bizlet("")
	public static DataObject[] queryPublishPageCategoryTreeNode() {
		int counts = 0;
		int it = 0;
		String sql = "select id,ch_name,parent_id from cms_info_category order by cat_sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			it = 0;
			if (null != rs) {
				rs.last();
				counts = rs.getRow();
				rs.beforeFirst();
			}
						
			DataObject[] dobj = new DataObject[counts];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoCategory");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("pid",  rs.getString("parent_id"));
				dtr.setString("text",rs.getString("ch_name"));
				if(rs.getString("parent_id").equals("0")){
					dtr.setString("iconCls", "icon-application");
				}
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
