/**
 * 
 */
package com.cms.content;

import com.eos.system.annotation.Bizlet;import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-09 16:43:32
 *
 */
@Bizlet("站点栏目管理")
public class QueryCategoryTreeNode {


	private static int counts = 0;
	private static int it = 0;
	/**
	 * @param data
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("栏目树结构处理")
	public static DataObject[] getCategoryTreeByRoot(String dsName) {
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,ch_name as chName from cms_info_category where parent_id = 0 order by cat_sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
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
				dtr.setString("chName",rs.getString("ch_name"));
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
