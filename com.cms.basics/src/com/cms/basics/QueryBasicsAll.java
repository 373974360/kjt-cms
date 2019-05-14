/**
 * 
 */
package com.cms.basics;

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
 * @author chaoweima
 * @date 2019-05-13 14:47:09
 *
 */
@Bizlet("文章分类全量列表")
public class QueryBasicsAll {

	/**
	 * @param dsName
	 * @return
	 * @author chaoweima
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] queryInfoType(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,type_name from cms_info_type order by id asc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.infoType.CmsInfoType");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("typeName", rs.getString("type_name"));
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
	 * @param dsName
	 * @return
	 * @author maxiaoqiang
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] queryLxmdName(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,MD_NAME from CMS_LXMD order by id asc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.infoType.CmsInfoType");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("mdName", rs.getString("md_Name"));
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
	 * @param dsName
	 * @return
	 * @author chaoweima
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] querySource(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,source_name from cms_source order by id asc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.source.CmsSource");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("sourceName", rs.getString("source_name"));
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
	 * @param dsName
	 * @return
	 * @author chaoweima
	 */
	@Bizlet(params = { @BizletParam(index = 0, type = CONSTANT) })
	public static DataObject[] queryAuthor(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,author_name from cms_author order by id asc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.author.CmsAuthor");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("authorName", rs.getString("author_name"));
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
