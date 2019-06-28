/**
 * 
 */
package com.cms.view.data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.cms.view.velocity.FormatUtil;
import com.cms.view.velocity.TurnPageBean;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-04 15:12:45
 *
 */
@Bizlet("")
public class AppealUtil {
	
	public static DataObject getAppealContent(String sqId){
		String sql = "select * from cms_sq where id="+sqId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.view.sq.CmsSq");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("mdId", rs.getString("md_id"));
				dtr.setString("title", rs.getString("title"));
				dtr.setString("username", rs.getString("username"));
				dtr.setString("address", rs.getString("address"));
				dtr.setString("phone", rs.getString("phone"));
				dtr.setString("email", rs.getString("email"));
				dtr.setString("isOpen", rs.getString("is_open"));
				dtr.setString("content", FormatUtil.clobToStr(rs.getClob("content")));
				dtr.setString("createTime", rs.getString("create_time"));
				dtr.setString("subOrgId", rs.getString("sub_org_id"));
				dtr.setString("subOrgName", rs.getString("sub_org_name"));
				dtr.setString("replyOrgId", rs.getString("reply_org_id"));
				dtr.setString("replyOrgName", rs.getString("reply_org_name"));
				dtr.setString("replyTime", rs.getString("reply_time"));
				dtr.setString("replyContent", FormatUtil.clobToStr(rs.getClob("reply_content")));
				dtr.setString("isReply", rs.getString("is_reply"));
				dtr.setString("isPublish", rs.getString("is_publish"));
				dtr.setString("searchCode", rs.getString("search_code"));
				dtr.setString("searchPwd", rs.getString("search_pwd"));
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
	
	public static DataObject[] getAppealList(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);
		int counts = 0;
		int it = 0;
		String sql = "select * from (select row_.*, rownum rownum_ from (select * from cms_sq where 1=1";
		sql = initSql(sql,con_map);
		sql += " order by "+con_map.get("orderby")+") row_ where rownum <="+con_map.get("page_size")+"+"+con_map.get("start_num")+") where rownum_ >="+con_map.get("start_num")+" + 1";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.view.sq.CmsSq");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("mdId", rs.getString("md_id"));
				dtr.setString("title", rs.getString("title"));
				dtr.setString("username", rs.getString("username"));
				dtr.setString("address", rs.getString("address"));
				dtr.setString("phone", rs.getString("phone"));
				dtr.setString("email", rs.getString("email"));
				dtr.setString("isOpen", rs.getString("is_open"));
				dtr.setString("content", FormatUtil.clobToStr(rs.getClob("content")));
				dtr.setString("createTime", rs.getString("create_time"));
				dtr.setString("subOrgId", rs.getString("sub_org_id"));
				dtr.setString("subOrgName", rs.getString("sub_org_name"));
				dtr.setString("replyOrgId", rs.getString("reply_org_id"));
				dtr.setString("replyOrgName", rs.getString("reply_org_name"));
				dtr.setString("replyTime", rs.getString("reply_time"));
				dtr.setString("replyContent", FormatUtil.clobToStr(rs.getClob("reply_content")));
				dtr.setString("isReply", rs.getString("is_reply"));
				dtr.setString("isPublish", rs.getString("is_publish"));
				dtr.setString("searchCode", rs.getString("search_code"));
				dtr.setString("searchPwd", rs.getString("search_pwd"));
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
	
	public static int getAppealCount(Map<String, String> con_map){
		int totle = 0;
		String sql = "select count(id) as totle from cms_sq where 1=1";
		sql = initSql(sql,con_map);
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				totle = rs.getInt("totle");
			}
			return totle;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static String initSql(String sql, Map<String, String> con_map){
		Set<String> keys = con_map.keySet();
		for(String key : keys){
			if(key.equals("md_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and md_id in ("+con_map.get(key)+")";
			}
			if(key.equals("title") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and title like '%"+con_map.get(key)+"%'";
			}
			if(key.equals("is_reply") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and is_reply = "+con_map.get(key);
			}
			if(key.equals("dept_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and sub_org_id = '"+con_map.get(key)+"'";
			}
			if(key.equals("search_code") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and search_code = '"+con_map.get(key)+"'";
			}
			if(key.equals("search_pwd") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and search_pwd = '"+con_map.get(key)+"'";
			}
		}
		if(!con_map.containsKey("search_code")&&!con_map.containsKey("search_pwd")){
			sql += " and is_publish = 1 and is_open = 1";
		}
		return sql;
	}
	public static TurnPageBean getAppealCount(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);
        TurnPageBean tpb = new TurnPageBean();
        tpb.setCount(getAppealCount(con_map));
        int cur_page = Integer.parseInt((String)con_map.get("current_page"));
        int page_size = Integer.parseInt((String)con_map.get("page_size"));

        tpb.setCur_page(cur_page);
        tpb.setPage_size(page_size);
        tpb.setPage_count(tpb.getCount() / tpb.getPage_size() + 1);
        if ((tpb.getCount() % tpb.getPage_size() == 0) && (tpb.getPage_count() > 1)) {
            tpb.setPage_count(tpb.getPage_count() - 1);
        }
        if (cur_page > 1) {
            tpb.setPrev_num(cur_page - 1);
        }
        tpb.setNext_num(tpb.getPage_count());
        if (cur_page < tpb.getPage_count()) {
            tpb.setNext_num(cur_page + 1);
        }
        if (tpb.getPage_count() > 10) {
            if (cur_page > 5) {
                if (cur_page > tpb.getPage_count() - 4) {
                    tpb.setCurr_start_num(tpb.getPage_count() - 6);
                } else {
                    tpb.setCurr_start_num(cur_page - 2);
                }
            }
        }
        return tpb;
    }
	
	public static void getInfoSearchCon(String params, Map<String, String> con_map){
		int cur_page = 1;
        int page_size = 15;
        String orderby = "create_time desc";
        String[] tempA = params.split(";");
        for (int i = 0; i < tempA.length; i++){
            if (tempA[i].toLowerCase().startsWith("orderby=")){
                String o_by = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(o_by)) && (!o_by.startsWith("$orderby"))) {
                    orderby = o_by;
                }
            }
        	if (tempA[i].toLowerCase().startsWith("cur_page=")){
                String cp = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(cp)) && (!cp.startsWith("$cur_page")) && (FormatUtil.isNumeric(cp))) {
                    cur_page = Integer.parseInt(cp);
                }
            }
            if (tempA[i].toLowerCase().startsWith("size=")){
                String ps = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(ps)) && (!ps.startsWith("$size")) && (FormatUtil.isNumeric(ps))) {
                    page_size = Integer.parseInt(ps);
                }
            }
            if (tempA[i].toLowerCase().startsWith("md_id=")){
                String md_id = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(md_id)) && (!md_id.startsWith("$md_id")) && (FormatUtil.isNumeric(md_id))) {
                	con_map.put("md_id", md_id);
                }
            }
            if (tempA[i].toLowerCase().startsWith("title=")){
                String title = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(title)) && (!title.startsWith("$title"))) {
                    con_map.put("title", title);
                }
            }
            if (tempA[i].toLowerCase().startsWith("is_reply=")){
                String is_reply = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(is_reply)) && (!is_reply.startsWith("$is_reply")) && (FormatUtil.isNumeric(is_reply))) {
                    con_map.put("is_reply", is_reply);
                }
            }
            if (tempA[i].toLowerCase().startsWith("dept_id=")){
                String dept_id = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(dept_id)) && (!dept_id.startsWith("$dept_id")) && (FormatUtil.isNumeric(dept_id))) {
                    con_map.put("dept_id", dept_id);
                }
            }
            if (tempA[i].toLowerCase().startsWith("search_code=")){
                String search_code = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(search_code)) && (!search_code.startsWith("$search_code"))) {
                    con_map.put("search_code", search_code);
                }
            }
            if (tempA[i].toLowerCase().startsWith("search_pwd=")){
                String search_pwd = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(search_pwd)) && (!search_pwd.startsWith("$search_pwd"))) {
                    con_map.put("search_pwd", search_pwd);
                }
            }
        }
        con_map.put("page_size", page_size + "");
        con_map.put("current_page", cur_page + "");
        con_map.put("start_num", (cur_page - 1) * page_size + "");
        con_map.put("orderby", orderby);
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
