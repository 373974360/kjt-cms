/**
 * 
 */
package com.cms.view;

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
 * @date 2019-07-05 09:17:46
 *
 */
@Bizlet("")
public class CmsInfoCategoryViewUtil {
	@Bizlet("按照栏目统计信息")
	public static DataObject[] infoViewByCategory(String catId,String startTime,String endTime){
		int counts = 0;
		int it = 0;
		if(StringUtil.isBlank(catId)){
			catId="all";
		}
		if(!StringUtil.isBlank(startTime)&&startTime.length()>=10){
			startTime = startTime.substring(0,10)+" 00:00:00";
		}
		if(!StringUtil.isBlank(endTime)&&endTime.length()>=10){
			endTime = endTime.substring(0,10)+" 23:59:59";
		}
		String sql = "select i.*,l.wf_opt_user from (select i.*,c.ch_name from (select i.id,i.info_title,u.empname,i.org_name,i.editor,i.source,i.released_dtime,i.info_status,i.cat_id from cms_info i left join org_employee u on i.input_user = u.empid where i.cat_id in ("+catId+") and i.released_dtime >= '"+startTime+"' and i.released_dtime<='"+endTime+"' order by substr(i.released_dtime,0,10) asc,i.input_user asc,i.org_id asc) i left join cms_info_category c on i.cat_id=c.id) i left join (select * from cms_workflow_logs where wf_opt_type=3) l on i.id=l.bus_id";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.count.cmsinfo.CmsInfo");
				String releasedDtime = rs.getString("released_dtime");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("editor", rs.getString("editor"));
				dtr.setString("source", rs.getString("source"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("userName", rs.getString("empname"));
				dtr.setString("releasedDtime", releasedDtime);
				if(rs.getString("info_status").equals("3")){
					dtr.setString("infoStatus", "已采用");
				}else{
					dtr.setString("infoStatus", "未采用");
				}
				dtr.setString("date", releasedDtime.substring(0,10));
				dtr.setString("catName", rs.getString("ch_name"));
				String optuser = rs.getString("wf_opt_user");
				if(!StringUtil.isBlank(optuser)){
					dtr.setString("replayUser", optuser);
				}else{
					dtr.setString("replayUser",  rs.getString("editor"));
				}
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
