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
public class YsqgklUtil {
	
	public static DataObject getYsqgkContent(String sqId){
		String sql = "select * from cms_ysqgk where id="+sqId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.view.ysqgk.CmsYsqgk");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("ysqCode", rs.getString("ysq_code"));
				dtr.setString("queryCode", rs.getString("query_code"));
				dtr.setString("ysqType", rs.getString("ysq_type"));
				dtr.setString("name", rs.getString("name"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("cardName", rs.getString("card_name"));
				dtr.setString("cardCode", rs.getString("card_code"));
				dtr.setString("tel", rs.getString("tel"));
				dtr.setString("mobile", rs.getString("tel"));
				dtr.setString("telCz", rs.getString("tel_cz"));
				dtr.setString("email", rs.getString("email"));
				dtr.setString("address", rs.getString("address"));
				dtr.setString("yzbm", rs.getString("yzbm"));
				dtr.setString("orgCode", rs.getString("org_code"));
				dtr.setString("licence", rs.getString("licence"));
				dtr.setString("legalperson", rs.getString("legalperson"));
				dtr.setString("linkman", rs.getString("linkman"));
				dtr.setString("content", FormatUtil.clobToStr(rs.getClob("content")));
				dtr.setString("description", FormatUtil.clobToStr(rs.getClob("description")));
				dtr.setString("isDerate", rs.getString("is_derate"));
				dtr.setString("offerType", rs.getString("offer_type"));
				dtr.setString("getMethod", rs.getString("get_method"));
				dtr.setString("isOther", rs.getString("is_other"));
				dtr.setString("createDtime", rs.getString("create_dtime"));
				dtr.setString("replyContent", FormatUtil.clobToStr(rs.getClob("reply_content")));
				dtr.setString("replyDtime", rs.getString("reply_dtime"));
				dtr.setString("isReply", rs.getString("is_reply"));
				dtr.setString("isPublish", rs.getString("is_publish"));
				dtr.setString("isOpen", rs.getString("is_open"));
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
	
	public static DataObject[] getYsqgkList(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);
		int counts = 0;
		int it = 0;
		String sql = "select * from (select row_.*, rownum rownum_ from (select * from cms_ysqgk where 1=1";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.view.ysqgk.CmsYsqgk");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("ysqCode", rs.getString("ysq_code"));
				dtr.setString("queryCode", rs.getString("query_code"));
				dtr.setString("ysqType", rs.getString("ysq_type"));
				dtr.setString("name", rs.getString("name"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("cardName", rs.getString("card_name"));
				dtr.setString("cardCode", rs.getString("card_code"));
				dtr.setString("tel", rs.getString("tel"));
				dtr.setString("mobile", rs.getString("tel"));
				dtr.setString("telCz", rs.getString("tel_cz"));
				dtr.setString("email", rs.getString("email"));
				dtr.setString("address", rs.getString("address"));
				dtr.setString("yzbm", rs.getString("yzbm"));
				dtr.setString("orgCode", rs.getString("org_code"));
				dtr.setString("licence", rs.getString("licence"));
				dtr.setString("legalperson", rs.getString("legalperson"));
				dtr.setString("linkman", rs.getString("linkman"));
				dtr.setString("content", FormatUtil.clobToStr(rs.getClob("content")));
				dtr.setString("description", FormatUtil.clobToStr(rs.getClob("description")));
				dtr.setString("isDerate", rs.getString("is_derate"));
				dtr.setString("offerType", rs.getString("offer_type"));
				dtr.setString("getMethod", rs.getString("get_method"));
				dtr.setString("isOther", rs.getString("is_other"));
				dtr.setString("createDtime", rs.getString("create_dtime"));
				dtr.setString("replyContent", FormatUtil.clobToStr(rs.getClob("reply_content")));
				dtr.setString("replyDtime", rs.getString("reply_dtime"));
				dtr.setString("isReply", rs.getString("is_reply"));
				dtr.setString("isPublish", rs.getString("is_publish"));
				dtr.setString("isOpen", rs.getString("is_open"));
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
	
	public static int getYsqgkCount(Map<String, String> con_map){
		int totle = 0;
		String sql = "select count(id) as totle from cms_ysqgk where 1=1";
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
			if(key.equals("ysq_code") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and ysq_code = '"+con_map.get(key)+"'";
			}
			if(key.equals("query_code") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and query_code = '"+con_map.get(key)+"'";
			}
		}
		sql += " and is_publish = 1";
		return sql;
	}
	public static TurnPageBean getYsqgkCount(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);
        TurnPageBean tpb = new TurnPageBean();
        tpb.setCount(getYsqgkCount(con_map));
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
        String orderby = "create_dtime desc";
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
            if (tempA[i].toLowerCase().startsWith("ysq_code=")){
                String ysq_code = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(ysq_code)) && (!ysq_code.startsWith("$ysq_code"))) {
                    con_map.put("ysq_code", ysq_code);
                }
            }
            if (tempA[i].toLowerCase().startsWith("query_code=")){
                String query_code = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(query_code)) && (!query_code.startsWith("$query_code"))) {
                    con_map.put("query_code", query_code);
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
