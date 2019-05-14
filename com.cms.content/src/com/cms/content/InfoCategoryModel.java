/**
 * 
 */
package com.cms.content;

import java.sql.Connection;

import com.eos.common.connection.ConnectionHelper;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;
import com.eos.foundation.data.DataObjectUtil;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @author chaoweima
 * @date 2019-05-14 14:16:58
 *
 */
@Bizlet("栏目关联模型相关")
public class InfoCategoryModel {

	/**
	 * @param catId
	 * @author chaoweima
	 */
	@Bizlet("根据栏目ID删除绑定模型")
	public static void deleteByCatId(String catId,String dsName) {
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "delete from cms_info_category_model where cat_id="+catId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
		PreparedStatement pstmt;
		try {
	        pstmt = (PreparedStatement) conn.prepareStatement(sql);
	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Bizlet("根据栏目ID获取绑定的模型")
	public static DataObject[] queryAllByCatId(String catId,String dsName) {
		int it = 0;
		int counts = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,cat_id,model_id from cms_info_category_model where cat_id="+catId;
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoCategoryModel");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId",rs.getString("cat_id"));
				dtr.setString("modelId",rs.getString("model_id"));
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
