/**
 * 
 */
package com.cms.content;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cms.view.velocity.FormatUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-07-12 10:12:05
 *
 */
@Bizlet("微信推送")
public class DoPushWeChat {
	@Bizlet("微信推送")
	public static boolean doPush(DataObject[] obj){
		boolean b = false;
		String ids = "";
		if(obj!=null){
			for(DataObject o:obj){
				ids+=","+o.getString("id");
			}
			ids = ids.substring(1);
			try {
				b = WeixinUtils.doPush(getInfo(ids));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return b;
	}
	
	
	public static DataObject[] getInfo(String ids){
		int counts = 0;
		int it = 0;
		String sql = "select i.id,i.site_id,i.info_title,i.author,i.editor,i.content_url,i.description,i.thumb_url,c.info_content from cms_info i,cms_info_content c where i.id=c.info_id and i.id in ("+ids+") and c.info_content is not null and i.model_id='article' order by i.released_dtime desc";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id",rs.getString("id"));
				dtr.setString("siteId",rs.getString("site_id"));
				dtr.setString("infoTitle",rs.getString("info_title"));
				dtr.setString("author",rs.getString("author"));
				dtr.setString("editor",rs.getString("editor"));
				dtr.setString("contentUrl",rs.getString("content_url"));
				dtr.setString("description",rs.getString("description"));
				dtr.setString("thumbUrl",rs.getString("thumb_url"));
				dtr.setString("infoContent",FormatUtil.clobToStr(rs.getClob("info_content")));
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
