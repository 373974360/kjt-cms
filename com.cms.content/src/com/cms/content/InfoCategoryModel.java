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
	 * 根据栏目ID查询当前位置
	 * */
	@Bizlet("获取网站根栏目的英文名称")
	public static String getSiteId(String catId){
		String siteId = "";
		DataObject currObj = getCategoryById(catId);
		String catIds = catId;
		for(int i=0;i<10;i++){
			currObj = getCategoryById(currObj.getString("parentId"));
			if(currObj==null||currObj.getString("id")==null){
				break;
			}
			catIds += ","+currObj.getString("id");
		}
		String[] catArray = catIds.split(",");
		String[] reverseArray = new String[catArray.length];
		for (int i = 0; i < catArray.length; i++) {
			reverseArray[i] = catArray[catArray.length - i - 1];
        }
		DataObject[] dobj = new DataObject[catArray.length];
		for(int i=0;i<reverseArray.length;i++){
			dobj[i] = getCategoryById(reverseArray[i]);
		}
		siteId = dobj[0].getString("enName");
		return siteId;
	}
	
	/**
	 * 根据栏目ID查询栏目
	 * */
	public static DataObject getCategoryById(String catId){
		String sql = "select * from cms_info_category where id = "+catId+" order by cat_sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoCategory");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("parentId", rs.getString("parent_id"));
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("enName", rs.getString("en_name"));
				dtr.setString("indexTemplet", rs.getString("index_templet"));
				dtr.setString("listTemplet", rs.getString("list_templet"));
				dtr.setString("linkUrl", rs.getString("link_url"));
				dtr.setString("remark", rs.getString("remark"));
				dobj[0] = dtr;
			}
			return dobj[0];
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
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
		String sql = "select id,cat_id,model_id,templet_id from cms_info_category_model where cat_id="+catId;
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
				dtr.setString("templetId",rs.getString("templet_id"));
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
