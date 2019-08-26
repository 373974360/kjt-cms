/**
 * 
 */
package com.cms.siteconfig.collection;

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
 * @date 2019-08-26 10:19:36
 *
 */
@Bizlet("")
public class GetCollectionAllList {
	
	
	/**
	 * 根据栏目ID查询栏目
	 * */
	@Bizlet("")
	public static DataObject[] getCollectionAllList(){
		int counts = 0;
		int it = 0;
		String sql = "SELECT * FROM CMS_COLLECTION WHERE COLL_INTERVAL = 1";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.siteconfig.collection.CmsCollection");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("collName", rs.getString("coll_name"));
				dtr.setString("modelType", rs.getString("model_type"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("pageCharset", rs.getString("page_charset"));
				dtr.setString("collUrl", rs.getString("coll_url"));
				dtr.setString("collPageNumStart", rs.getString("coll_page_num_start"));
				dtr.setString("collPageNumEnd", rs.getString("coll_page_num_end"));
				dtr.setString("collPageNumInterval", rs.getString("coll_page_num_interval"));
				dtr.setString("collType", rs.getString("coll_type"));
				dtr.setString("listTagsStart", rs.getString("list_tags_start"));
				dtr.setString("listTagsEnd", rs.getString("list_tags_end"));
				dtr.setString("titleTagsStart", rs.getString("title_tags_start"));
				dtr.setString("titleTagsEnd", rs.getString("title_tags_end"));
				dtr.setString("contentTagsStart", rs.getString("content_tags_start"));
				dtr.setString("contentTagsEnd", rs.getString("content_tags_end"));
				dtr.setString("authorTagsStart", rs.getString("author_tags_start"));
				dtr.setString("authorTagsEnd", rs.getString("author_tags_end"));
				dtr.setString("docnoTagsStart", rs.getString("docno_tags_start"));
				dtr.setString("docnoTagsEnd", rs.getString("docno_tags_end"));
				dtr.setString("dtimeTagsStart", rs.getString("dtime_tags_start"));
				dtr.setString("dtimeTagsEnd", rs.getString("dtime_tags_end"));
				dtr.setString("sourceTagsStart", rs.getString("source_tags_start"));
				dtr.setString("sourceTagsEnd", rs.getString("source_tags_end"));
				dtr.setString("keywordsTagsStart", rs.getString("keywords_tags_start"));
				dtr.setString("keywordsTagsEnd", rs.getString("keywords_tags_end"));
				dtr.setString("collInterval", rs.getString("coll_interval"));
				dtr.setString("collImages", rs.getString("coll_images"));
				dtr.setString("isStatus", rs.getString("is_status"));
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
