/**
 * 
 */
package com.cms.view.data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cms.view.survey.CmsSurvey;
import com.cms.view.survey.CmsSurveyItem;
import com.cms.view.survey.CmsSurveyItemText;
import com.cms.view.survey.CmsSurveySub;
import com.cms.view.velocity.FormatUtil;
import com.cms.view.velocity.TurnPageBean;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-11 14:46:07
 *
 */
@Bizlet("")
public class SurveyUtil {
	
	public static CmsSurvey getSurveyContent(String id){
		CmsSurvey survey = getSurvey(id);
		List<CmsSurveySub> subList = getSubList(id);
		for(CmsSurveySub sub:subList){
			sub.setItemList(getItemList(sub.getId()+""));
		}
		survey.setSubList(subList);
		return survey;
	}
	

	public static List<CmsSurveyItem> getItemList(String subId){
		String sql = "select * from cms_survey_item where sub_id="+subId+" order by sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsSurveyItem> itemList = new ArrayList<CmsSurveyItem>();
			//创建一个数值格式化对象   
			NumberFormat numberFormat = NumberFormat.getInstance();   
			//设置精确到小数点后2位   
			numberFormat.setMaximumFractionDigits(2);
			while (rs.next()) {
				CmsSurveyItem item = new CmsSurveyItem();
				item.setId(rs.getInt("id"));
				item.setSurveyId(rs.getInt("survey_id"));
				item.setSubId(rs.getInt("sub_id"));
				item.setItemName(rs.getString("item_name"));
				item.setSort(rs.getInt("sort"));
				int itemNum = getItemNum(subId,rs.getString("id"));
				int subNum = getSubNum(subId);
				item.setNum(itemNum);
				String proportion = numberFormat.format((float)itemNum/(float)subNum*100)+"%";
				item.setProportion(proportion);
				itemList.add(item);
			}
			return itemList;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}

	public static List<CmsSurveySub> getSubList(String surveyId){
		String sql = "select * from cms_survey_sub where survey_id="+surveyId+" order by sort asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsSurveySub> subList = new ArrayList<CmsSurveySub>();
			while (rs.next()) {
				CmsSurveySub sub = new CmsSurveySub();
				sub.setId(rs.getInt("id"));
				sub.setSurveyId(rs.getInt("survey_id"));
				sub.setSubTitle(rs.getString("sub_title"));
				sub.setSubType(rs.getInt("sub_type"));
				sub.setIsRequired(rs.getInt("is_required"));
				sub.setSort(rs.getInt("sort"));
				sub.setNum(getSubNum(rs.getString("id")));
				sub.setItemTextlist(getItemTextList(rs.getString("id")));
				subList.add(sub);
			}
			return subList;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static List<CmsSurveyItemText> getItemTextList(String subId){
		String sql = "select item_text from cms_survey_answer_item where sub_id="+subId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			List<CmsSurveyItemText> itemTextList = new ArrayList<CmsSurveyItemText>();
			while (rs.next()) {
				CmsSurveyItemText itemText = new CmsSurveyItemText();
				itemText.setItemText(rs.getString("item_text"));
				itemTextList.add(itemText);
			}
			return itemTextList;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	public static int getItemNum(String subId,String itemId){
		int num = 0;
		String sql = "select count(*) as totle from cms_survey_answer_item where sub_id="+subId+" and item_id="+itemId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("totle");
			}
			return num;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static int getSubNum(String subId){
		int num = 0;
		String sql = "select count(*) as totle from cms_survey_answer_item where sub_id="+subId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("totle");
			}
			return num;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	

	
	public static int getSurveyNum(String surveyId){
		int num = 0;
		String sql = "select count(*) as totle from cms_survey_answer a,cms_survey_answer_item i where a.id=i.answer_id and a.survey_id="+surveyId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("totle");
			}
			return num;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	

	public static int getSurveyPopleNum(String surveyId){
		int num = 0;
		String sql = "select count(*) as totle from cms_survey_answer where survey_id="+surveyId;
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num = rs.getInt("totle");
			}
			return num;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static CmsSurvey getSurvey(String id){
		String sql = "select * from cms_survey where id="+id+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			CmsSurvey survey = new CmsSurvey();
			while (rs.next()) {
				survey.setId(rs.getInt("id"));
				survey.setTitle(rs.getString("title"));
				survey.setStartTime(rs.getString("start_time"));
				survey.setEndTime(rs.getString("end_time"));
				survey.setSubmitNum(rs.getInt("submit_num"));
				survey.setSubmitDay(rs.getInt("submit_day"));
				survey.setContent(FormatUtil.clobToStr(rs.getClob("content")));
				survey.setIsPublish(rs.getInt("is_publish"));
				survey.setCreateTime( rs.getString("create_time"));
				survey.setIsEnd(rs.getInt("is_end"));
				survey.setNum(getSurveyNum(id));
				survey.setPepoleNum(getSurveyPopleNum(id));
			}
			return survey;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static DataObject[] getSurveyList(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getSurveySearchCon(params,con_map);
		int counts = 0;
		int it = 0;
		String sql = "select * from (select row_.*, rownum rownum_ from (select * from cms_survey where 1=1";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.commonality.survey.CmsSurvey");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("title", rs.getString("title"));
				dtr.setString("startTime", rs.getString("start_time"));
				dtr.setString("endTime", rs.getString("end_time"));
				dtr.setString("submitNum", rs.getString("submit_num"));
				dtr.setString("submitDay", rs.getString("submit_day"));
				dtr.setString("content", FormatUtil.clobToStr(rs.getClob("content")));
				dtr.setString("isPublish", rs.getString("is_publish"));
				dtr.setString("createTime", rs.getString("create_time"));
				dtr.setString("isEnd", rs.getString("is_end"));
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
	
	public static int getSurveyCount(Map<String, String> con_map){
		int totle = 0;
		String sql = "select count(id) as totle from cms_survey where 1=1";
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
		sql += " and is_publish = 2";
		return sql;
	}
	public static TurnPageBean getSurveyCount(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getSurveySearchCon(params,con_map);
        TurnPageBean tpb = new TurnPageBean();
        tpb.setCount(getSurveyCount(con_map));
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
	
	public static void getSurveySearchCon(String params, Map<String, String> con_map){
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
