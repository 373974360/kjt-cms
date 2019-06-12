/**
 * 
 */
package com.cms.view.data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cms.view.interview.CmsInterview;
import com.cms.view.interview.CmsInterviewGuest;
import com.cms.view.velocity.FormatUtil;
import com.cms.view.velocity.TurnPageBean;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-12 15:29:47
 *
 */
@Bizlet("")
public class InterviewUtil {
	public static CmsInterview getInterviewContent(String interviewId){
		String sql = "select * from cms_interview where id="+interviewId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			CmsInterview interview = new CmsInterview();
			while (rs.next()) {
				interview.setId(rs.getInt("id"));
				interview.setTitle(rs.getString("title"));
				interview.setStartTime(rs.getString("start_time"));
				interview.setEndTime(rs.getString("end_time"));
				interview.setStatus(rs.getInt("status"));
				interview.setImgUrl(rs.getString("img_url"));
				interview.setVideoUrl(rs.getString("video_url"));
				interview.setContent(FormatUtil.clobToStr(rs.getClob("content")));
				interview.setInputDtime(rs.getString("input_dtime"));
				interview.setInputUser(rs.getString("input_user"));
				interview.setHits(rs.getInt("hits"));
				interview.setGuestList(getInterviewGuestList(interviewId));
			}
			return interview;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static List<CmsInterview> getInterviewList(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInterviewSearchCon(params,con_map);
		String sql = "select * from (select row_.*, rownum rownum_ from (select * from cms_interview where 1=1";
		sql = initSql(sql,con_map);
		sql += " order by "+con_map.get("orderby")+") row_ where rownum <="+con_map.get("page_size")+"+"+con_map.get("start_num")+") where rownum_ >="+con_map.get("start_num")+" + 1";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsInterview> interviewList = new ArrayList<CmsInterview>();
			while (rs.next()) {
				CmsInterview interview = new CmsInterview();
				interview.setId(rs.getInt("id"));
				interview.setTitle(rs.getString("title"));
				interview.setStartTime(rs.getString("start_time"));
				interview.setEndTime(rs.getString("end_time"));
				interview.setStatus(rs.getInt("status"));
				interview.setImgUrl(rs.getString("img_url"));
				interview.setVideoUrl(rs.getString("video_url"));
				interview.setContent(FormatUtil.clobToStr(rs.getClob("content")));
				interview.setInputDtime(rs.getString("input_dtime"));
				interview.setInputUser(rs.getString("input_user"));
				interview.setHits(rs.getInt("hits"));
				interviewList.add(interview);
			}
			return interviewList;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static List<CmsInterviewGuest> getInterviewGuestList(String interId){
		String sql = "select * from cms_interview_guest where inter_id = "+interId+" order by sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsInterviewGuest> guestList = new ArrayList<CmsInterviewGuest>();
			while (rs.next()) {
				CmsInterviewGuest guest = new CmsInterviewGuest();
				guest.setId(rs.getInt("id"));
				guest.setInterId(rs.getInt("inter_id"));
				guest.setUsername(rs.getString("username"));
				guest.setZw(rs.getString("zw"));
				guest.setWork(rs.getString("work"));
				guest.setRemark(rs.getString("remark"));
				guest.setPhoto(rs.getString("photo"));
				guest.setSort(rs.getInt("sort"));
				guestList.add(guest);
			}
			return guestList;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static int getInterviewCount(Map<String, String> con_map){
		int totle = 0;
		String sql = "select count(id) as totle from cms_interview where 1=1";
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
			if(key.equals("title") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and title like '%"+con_map.get(key)+"%'";
			}
		}
		sql += " and status = 2";
		return sql;
	}
	public static TurnPageBean getInterviewCount(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInterviewSearchCon(params,con_map);
        TurnPageBean tpb = new TurnPageBean();
        tpb.setCount(getInterviewCount(con_map));
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
	
	public static void getInterviewSearchCon(String params, Map<String, String> con_map){
		int cur_page = 1;
        int page_size = 15;
        String orderby = "start_time desc";
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
            if (tempA[i].toLowerCase().startsWith("title=")){
                String title = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(title)) && (!title.startsWith("$title"))) {
                    con_map.put("title", title);
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
