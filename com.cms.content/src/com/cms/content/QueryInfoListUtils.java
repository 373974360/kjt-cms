/**
 * 
 */
package com.cms.content;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-15 09:26:33
 *
 */
@Bizlet("获取信息列表")
public class QueryInfoListUtils {

	@Bizlet("返回用户读取数据的权限")
	public static String getInfoUserData(String userId){
		String infoData = "0";
		String sql = "select * from cms_user_data where user_id="+userId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				infoData = rs.getString("info_data");
			}
			return infoData;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	
	@Bizlet("返回栏目子节点")
	public static String getInfoCatIds(String catId,String result,String userId){
		String id = "";
		DataObject[] dtr = getInfoCategory(catId,userId);
		for(DataObject d:dtr){
			id = d.getString("id");
			result += ","+id;
			String s = getInfoCatIds(id,result,userId);
			result = s;
		}
		return result;
	}
	
	@Bizlet("返回栏目同时发布信息")
	public static String getInfoCats(String catId){
		String result = "";
		if(!StringUtil.isBlank(catId)){
			String[] catArray = catId.split(",");
			for(String c:catArray){
				result+=getInfoCatByCatId(c);
			}
			if(result.length()>0){
				result = result.substring(1);
			}else{
				return null;
			}
		}else{
			return null;
		}
		return result;
	}

	public static String getInfoCatByCatId(String catId){
		String result = "";
		String sql = "select info_id from cms_info_cat where cat_id = "+catId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				result += ","+rs.getString("info_id");
			}
			return result;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static DataObject[] getInfoCategory(String catId,String userId) {
		int counts = 0;
		int it = 0;
		String sql = "select c.id,c.ch_name,c.parent_id from cms_info_category c left join cms_user_category u on c.id=u.cat_id where c.parent_id = "+catId+" and u.user_id="+userId+" order by c.cat_sort asc";
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
