/**
 * 
 */
package com.cms.basics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import com.cms.view.velocity.DateUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-10-25 15:26:27
 *
 */
@Bizlet("")
public class ResetAuth {

	@Bizlet("")
	public static void setReadAuth(DataObject obj,DataObject user) {
		DataObject[] oldUserData = getUserDataCount(user.getInt("USER_ID"));
		DataObject userData = DataObjectUtil.createDataObject("com.cms.content.category.CmsUserData");
		userData.setLong("userId",user.getInt("USER_ID"));
		userData.setLong("sqData",obj.getLong("sqData"));
		userData.setLong("infoData",obj.getLong("infoData"));
		if(oldUserData.length == 0){
			DatabaseExt.getPrimaryKey(userData);
			DatabaseUtil.insertEntity("default", userData);
		}else{
			userData.setLong("id", oldUserData[0].getLong("id"));
			DatabaseUtil.updateEntity("default", userData);
		}
	}


	@Bizlet("")
	public static void setUserCategory(DataObject[] category,DataObject user) {
		if(category.length>0){
			int userId = user.getInt("USER_ID");
			clearUserCategory(userId);
			for(DataObject obj:category){
				DataObject userCategory = DataObjectUtil.createDataObject("com.cms.content.category.CmsUserCategory");
				userCategory.setLong("userId",userId);
				userCategory.setLong("catId",obj.getLong("CATEGORY_ID"));
				DatabaseExt.getPrimaryKey(userCategory);
				DatabaseUtil.insertEntity("default", userCategory);
			}
		}
	}


	@Bizlet("")
	public static void setUserRole(DataObject[] role,DataObject user) {
		if(role.length>0){
			int userId = user.getInt("USER_ID");
			clearUserRole(userId);
			for(DataObject obj:role){
				DataObject userCategory = DataObjectUtil.createDataObject("com.cms.content.category.CmsUserCategory");
				userCategory.setString("partyId",userId+"");
				userCategory.setString("roleId",obj.getString("ROLE_ID"));
				insertUserRole(userCategory);
			}
		}
	}
	public static void insertUserRole(DataObject obj) {
		String sql = "INSERT INTO CAP_PARTYAUTH VALUES ('role', '"+obj.getString("partyId")+"', 'emp', '"+obj.getString("roleId")+"', 'default', 'sysadmin', TO_DATE('"+DateUtil.getCurrentDateTime()+"', 'SYYYY-MM-DD HH24:MI:SS'))";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		PreparedStatement pstmt;
		try {
	        pstmt = (PreparedStatement) conn.prepareStatement(sql);
	        pstmt.execute();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	public static void clearUserRole(int userId) {
		String sql = "delete from cap_partyauth where party_id = "+userId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
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

	public static void clearUserCategory(int userId) {
		String sql = "delete from cms_user_category where user_id = "+userId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
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
	
	public static DataObject[] getUserDataCount(int userId) {
		int counts = 0;
		int it = 0;
		String sql = "select * from cms_user_data where user_id="+userId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsUserData");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("userId", rs.getString("user_id"));
				dtr.setString("sqData", rs.getString("sq_data"));
				dtr.setString("infoData", rs.getString("info_data"));
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
