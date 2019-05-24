/**
 * 
 */
package com.cms.view.data;

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
 * @date 2019-05-23 09:05:57
 *
 */
@Bizlet("前台栏目展现相关类")
public class CategoryUtil {

	
	/**
	 * 根据栏目ID查询当前位置
	 * */
	public static DataObject[] getCategoryPosition(String catId){
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
		return dobj;
	}
	
	/**
	 * 根据栏目ID查询栏目
	 * */
	public static DataObject getCategoryById(String catId){
		String sql = "select * from cms_info_category where id = "+catId+" order by cat_sort desc";
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
	 * 根据栏目ID查询子栏目
	 * */
	public static DataObject[] getCategoryChildById(String catId){
		int counts = 0;
		int it = 0;
		String sql = "select * from cms_info_category where parent_id = "+catId+" order by cat_sort desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
				dtr.setString("parentId", rs.getString("parent_id"));
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("enName", rs.getString("en_name"));
				dtr.setString("indexTemplet", rs.getString("index_templet"));
				dtr.setString("listTemplet", rs.getString("list_templet"));
				dtr.setString("linkUrl", rs.getString("link_url"));
				dtr.setString("remark", rs.getString("remark"));
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
	 * 根据栏目ID查询栏目
	 * */
	public static DataObject getSiteByDomain(String domain){
		String sql = "select * from cms_info_category where site_domin like '%"+domain+"%'";
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
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("enName", rs.getString("en_name"));
				dtr.setString("indexTemplet", rs.getString("index_templet"));
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
