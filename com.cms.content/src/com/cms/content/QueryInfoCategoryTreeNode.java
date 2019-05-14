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
 * @date 2019-05-13 10:30:21
 *
 */
@Bizlet("内容管理栏目树")
public class QueryInfoCategoryTreeNode {
	/**
	 * @param data
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("内容管理栏目树")
	public static DataObject[] getInfoCategoryTreeNode(int nodeId,String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,ch_name,parent_id from cms_info_category where parent_id = "+nodeId+" order by cat_sort asc";
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
				dtr.setBoolean("expanded", false);
				dtr.setInt("realId", rs.getInt("id"));
				dtr.setString("text",rs.getString("ch_name"));
				dtr.setString("type","category");
				if(nodeId==0){
					dtr.setString("id", "root");
					dtr.setString("iconCls", "icon-application");
					dtr.setBoolean("isLeaf", false);
				}else{
					dtr.setString("id", "category_"+rs.getString("id"));
					int nodeCount = getTreeNode(rs.getInt("id"),dsName);
					if(nodeCount > 0){
						dtr.setBoolean("isLeaf", false);
					}else{
						dtr.setBoolean("isLeaf", true);
					}
					dtr.setString("pid", "category_"+rs.getString("parent_id"));
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
	
	/**
	 * @param data
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("栏目树结构处理")
	public static int getTreeNode(int parentId,String dsName) {
		int counts = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id from cms_info_category where parent_id = "+parentId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			if (null != rs) {
				rs.last();
				counts = rs.getRow();
				rs.beforeFirst();
			}
			return counts;
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
