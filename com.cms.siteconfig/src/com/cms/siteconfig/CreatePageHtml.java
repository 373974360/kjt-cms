/**
 * 
 */
package com.cms.siteconfig;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cms.view.velocity.DateUtil;
import com.cms.view.velocity.FormatUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-05 15:47:23
 * 
 */
@Bizlet("")
public class CreatePageHtml {
	
	@Bizlet("")
	public static boolean createPageHandl(DataObject obj) throws IOException {
		VelocityPageContextImp vpc = new VelocityPageContextImp();
		String html_content = vpc.getHtmlContent(obj.getString("templetId"));
		String save_path = TempletUtils.class.getClassLoader().getResource("/").getPath();
		save_path = FormatUtil.formatPath(save_path.substring(0,save_path.indexOf("WEB-INF")) + obj.getString("pagePath"));
		File f = new File(save_path);
		if (!f.exists()) {
			f.mkdirs();
		}
		save_path = FormatUtil.formatPath(save_path + "/" + obj.getString("pageEnname") + ".html");
		FileOperation.writeStringToFile(save_path, html_content, false,"utf-8");
		updatePage(obj.getString("id"), DateUtil.getCurrentDateTime(),DateUtil.getDateTimeAfter(DateUtil.getCurrentDateTime(), obj.getInt("pageInterval")));
		return true;
	}
	
	public static void updatePage(String id,String lastTime,String nextTime) {
		String sql = "update cms_page set last_dtime = '"+lastTime+"',next_dtime='"+nextTime+"' where id = "+id;
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
	
	
	/**
	 * 根据栏目ID查询栏目
	 * */
	@Bizlet("")
	public static DataObject[] getTimerPageList(String currTime){
		int counts = 0;
		int it = 0;
		String sql = "SELECT * FROM cms_page WHERE page_interval > 0 AND ( next_dtime = '"+currTime+"' OR next_dtime < '"+currTime+"' ) ORDER BY id";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.siteconfig.page.CmsPage");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("pageEnname", rs.getString("page_enname"));
				dtr.setString("pageChname", rs.getString("page_chname"));
				dtr.setString("templetId", rs.getString("templet_id"));
				dtr.setString("pagePath", rs.getString("page_path"));
				dtr.setString("pageInterval", rs.getString("page_interval"));
				dtr.setString("lastDtime", rs.getString("last_dtime"));
				dtr.setString("nextDtime", rs.getString("next_dtime"));
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
