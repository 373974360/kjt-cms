/**
 * 
 */
package com.cms.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import com.cms.count.vo.CmsInfoCategory;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-14 14:15:36
 *
 */
@Bizlet("")
public class InfoCountCategoryUtil {

	@Bizlet("按照栏目统计信息")
	public static List<CmsInfoCategory> infoCountByCategory(String catId,String startTime,String endTime){
		if(StringUtil.isBlank(catId)){
			catId="all";
		}
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select id,ch_name,parent_id from cms_info_category";
		if(!catId.equals("all")){
			sql+=" where parent_id="+catId;
		}
		sql+=" order by cat_sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsInfoCategory> list = new ArrayList<CmsInfoCategory>();
			//创建一个数值格式化对象   
			NumberFormat numberFormat = NumberFormat.getInstance();   
			//设置精确到小数点后2位   
			numberFormat.setMaximumFractionDigits(2);
			while (rs.next()) {
				CmsInfoCategory category = new CmsInfoCategory();
				category.setId(rs.getInt("id"));
				category.setPid(rs.getInt("parent_id"));
				category.setText(rs.getString("ch_name"));
				int count = infoCountByCatId(rs.getString("id"),startTime,endTime);
				int publishCount = infoPublishCountByCatId(rs.getString("id"),startTime,endTime);
				category.setCount(count);
				category.setPublisCount(publishCount);
				String proportion = numberFormat.format((float)publishCount/(float)count*100)+"%";
				category.setProportion(proportion);
				list.add(category);
			}
			return list;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	

	public static int infoPublishCountByCatId(String catId,String startTime,String endTime){
		int count = 0;
		String catIds = getInfoCatIds(catId,catId);
		String sql = "select count(*) as totle from cms_info where cat_id in ("+catIds+") and info_status = 3 and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"'";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				count = rs.getInt("totle");
			}
			return count;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static int infoCountByCatId(String catId,String startTime,String endTime){
		int count = 0;
		String catIds = getInfoCatIds(catId,catId);
		String sql = "select count(*) as totle from cms_info where cat_id in ("+catIds+") and released_dtime >= '"+startTime+"' and released_dtime<='"+endTime+"'";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				count = rs.getInt("totle");
			}
			return count;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	
	
	public static String getInfoCatIds(String catId,String result){
		String id = "";
		DataObject[] dtr = getInfoCategory(catId);
		for(DataObject d:dtr){
			id = d.getString("id");
			result += ","+id;
			String s = getInfoCatIds(id,result);
			result = s;
		}
		return result;
	}
	
	public static DataObject[] getInfoCategory(String catId) {
		int counts = 0;
		int it = 0;
		String sql = "select c.id,c.ch_name,c.parent_id from cms_info_category c where c.parent_id = "+catId+" order by c.cat_sort asc";
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
