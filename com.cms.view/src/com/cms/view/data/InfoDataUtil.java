/**
 * 
 */
package com.cms.view.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.cms.content.QueryInfoListUtils;
import com.cms.view.velocity.FormatUtil;
import com.cms.view.velocity.TurnPageBean;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-22 11:23:51
 *
 */
@Bizlet("网站前台获取信息相关类")
public class InfoDataUtil {
	public static int getHits(String infoId){
		int hits = 0;
		String sql = "select hits from cms_info where id="+infoId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				hits = rs.getInt("hits");
			}
			updateHits(infoId);
			return hits+1;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	public static void updateHits(String infoId) {
		String sql = "update cms_info set hits = hits+1 where id = "+infoId;
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

	public static DataObject getInfoData(String infoId,String infoStatus){
		String sql = "select * from cms_info i,cms_info_category c where i.cat_id=c.id and i.id="+infoId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("topTitle", rs.getString("top_title"));
				dtr.setString("subTitle", rs.getString("sub_title"));
				dtr.setString("modelId", rs.getString("model_id"));
				dtr.setString("infoType", rs.getString("info_type"));
				dtr.setString("thumbUrl", rs.getString("thumb_url"));
				dtr.setString("description", rs.getString("description"));
				dtr.setString("author", rs.getString("author"));
				dtr.setString("editor", rs.getString("editor"));
				dtr.setString("source", rs.getString("source"));
				dtr.setString("keywords", rs.getString("keywords"));
				dtr.setString("contentUrl", rs.getString("content_url"));
				dtr.setString("infoStatus", rs.getString("info_status"));
				dtr.setString("weight", rs.getString("weight"));
				dtr.setString("hits", rs.getString("hits"));
				dtr.setString("isTop", rs.getString("is_top"));
				dtr.setString("isTuijian", rs.getString("is_tuijian"));
				dtr.setString("releasedDtime", rs.getString("released_dtime"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("gkNo", rs.getString("gk_no"));
				dtr.setString("gkIndex", rs.getString("gk_index"));
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("gkDept", rs.getString("gk_dept"));
				dtr.setString("gkCwrq", rs.getString("gk_cwrq"));
				dtr.setString("gkFwrq", rs.getString("gk_fwrq"));
				dtr.setString("gkWjyxx", rs.getString("gk_wjyxx"));
				dtr.setString("sourceUrl", rs.getString("source_url"));
				if(!rs.getString("model_id").equals("link") && !rs.getString("model_id").equals("download")){
					DataObject obj;
					if(rs.getString("model_id").equals("expert") || rs.getString("model_id").equals("leader")){
						obj = getInfoLeader(rs.getString("id"));
						dtr.setString("ldzw", obj.getString("ldzw"));
						dtr.setString("grjl", obj.getString("grjl"));
						dtr.setString("zrfg", obj.getString("zrfg"));
						dtr.setString("kycg", obj.getString("kycg"));
					}else{
						obj = getInfoContent(rs.getString("id"));
						dtr.setString("picContent", obj.getString("picContent"));
						dtr.setString("videoPath", obj.getString("videoPath"));
						dtr.setString("infoContent", obj.getString("infoContent"));
					}
				}
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
	
	public static DataObject getInfoData(String infoId){
		String sql = "select * from cms_info i,cms_info_category c where i.cat_id=c.id and i.id="+infoId+" and i.info_status=3";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("topTitle", rs.getString("top_title"));
				dtr.setString("subTitle", rs.getString("sub_title"));
				dtr.setString("modelId", rs.getString("model_id"));
				dtr.setString("infoType", rs.getString("info_type"));
				dtr.setString("thumbUrl", rs.getString("thumb_url"));
				dtr.setString("description", rs.getString("description"));
				dtr.setString("author", rs.getString("author"));
				dtr.setString("editor", rs.getString("editor"));
				dtr.setString("source", rs.getString("source"));
				dtr.setString("keywords", rs.getString("keywords"));
				dtr.setString("contentUrl", rs.getString("content_url"));
				dtr.setString("infoStatus", rs.getString("info_status"));
				dtr.setString("weight", rs.getString("weight"));
				dtr.setString("hits", rs.getString("hits"));
				dtr.setString("isTop", rs.getString("is_top"));
				dtr.setString("isTuijian", rs.getString("is_tuijian"));
				dtr.setString("releasedDtime", rs.getString("released_dtime"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("gkNo", rs.getString("gk_no"));
				dtr.setString("gkIndex", rs.getString("gk_index"));
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("gkDept", rs.getString("gk_dept"));
				dtr.setString("gkCwrq", rs.getString("gk_cwrq"));
				dtr.setString("gkFwrq", rs.getString("gk_fwrq"));
				dtr.setString("gkWjyxx", rs.getString("gk_wjyxx"));
				dtr.setString("sourceUrl", rs.getString("source_url"));
				if(!rs.getString("model_id").equals("link") && !rs.getString("model_id").equals("download")){
					DataObject obj;
					if(rs.getString("model_id").equals("expert") || rs.getString("model_id").equals("leader")){
						obj = getInfoLeader(rs.getString("id"));
						dtr.setString("ldzw", obj.getString("ldzw"));
						dtr.setString("grjl", obj.getString("grjl"));
						dtr.setString("zrfg", obj.getString("zrfg"));
						dtr.setString("kycg", obj.getString("kycg"));
					}else{
						obj = getInfoContent(rs.getString("id"));
						dtr.setString("picContent", obj.getString("picContent"));
						dtr.setString("videoPath", obj.getString("videoPath"));
						dtr.setString("infoContent", obj.getString("infoContent"));
					}
				}
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
	
	
	public static DataObject getInfoContent(String infoId){
		String sql = "select * from cms_info_content where info_id="+infoId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoContent");
				dtr.setString("picContent", FormatUtil.clobToStr(rs.getClob("pic_content")));
				dtr.setString("videoPath", rs.getString("video_path"));
				dtr.setString("infoContent", FormatUtil.clobToStr(rs.getClob("info_content")));
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
	public static DataObject getInfoLeader(String infoId){
		String sql = "select * from cms_info_leader where info_id="+infoId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoLeader");
				dtr.setString("ldzw", FormatUtil.clobToStr(rs.getClob("ldzw")));
				dtr.setString("grjl", FormatUtil.clobToStr(rs.getClob("grjl")));
				dtr.setString("zrfg", FormatUtil.clobToStr(rs.getClob("zrfg")));
				dtr.setString("kycg", FormatUtil.clobToStr(rs.getClob("kycg")));
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
	
	public static String getTempletId(String modelId,String catId){
		String templetid = "";
		String sql = "select templet_id from cms_info_category_model where model_id='"+modelId+"' and cat_id="+catId+"";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				templetid = rs.getString("templet_id");
			}
			return templetid;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	public static DataObject[] getInfoList(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);
		int counts = 0;
		int it = 0;
		String sql = "select * from (select row_.*, rownum rownum_ from (select * from (select i.*,c.ch_name from cms_info i,cms_info_category c where i.cat_id=c.id";
		sql = initSql(sql,con_map,"list");
		sql += ") i order by i.is_top asc,i.weight desc,"+con_map.get("orderby")+") row_ where rownum <="+con_map.get("page_size")+"+"+con_map.get("start_num")+") where rownum_ >="+con_map.get("start_num")+" + 1";
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
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("catId", rs.getString("cat_id"));
				dtr.setString("infoTitle", rs.getString("info_title"));
				dtr.setString("topTitle", rs.getString("top_title"));
				dtr.setString("subTitle", rs.getString("sub_title"));
				dtr.setString("modelId", rs.getString("model_id"));
				dtr.setString("infoType", rs.getString("info_type"));
				dtr.setString("thumbUrl", rs.getString("thumb_url"));
				dtr.setString("description", rs.getString("description"));
				dtr.setString("author", rs.getString("author"));
				dtr.setString("editor", rs.getString("editor"));
				dtr.setString("source", rs.getString("source"));
				dtr.setString("keywords", rs.getString("keywords"));
				dtr.setString("contentUrl", rs.getString("content_url"));
				dtr.setString("infoStatus", rs.getString("info_status"));
				dtr.setString("weight", rs.getString("weight"));
				dtr.setString("hits", rs.getString("hits"));
				dtr.setString("isTop", rs.getString("is_top"));
				dtr.setString("isTuijian", rs.getString("is_tuijian"));
				dtr.setString("releasedDtime", rs.getString("released_dtime"));
				dtr.setString("orgName", rs.getString("org_name"));
				dtr.setString("gkNo", rs.getString("gk_no"));
				dtr.setString("gkIndex", rs.getString("gk_index"));
				dtr.setString("chName", rs.getString("ch_name"));
				dtr.setString("gkDept", rs.getString("gk_dept"));
				dtr.setString("gkCwrq", rs.getString("gk_cwrq"));
				dtr.setString("gkFwrq", rs.getString("gk_fwrq"));
				dtr.setString("gkWjyxx", rs.getString("gk_wjyxx"));
				dtr.setString("sourceUrl", rs.getString("source_url"));
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
	public static int getBroInfoCount(Map<String, String> con_map){
		int totle = 0;
		String sql = "select count(i.id) as totle from cms_info i where 1=1";
		sql = initSql(sql,con_map,"count");
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
	
	public static TurnPageBean getInfoCount(String params){
		Map<String, String> con_map = new HashMap<String, String>();
		getInfoSearchCon(params,con_map);

        TurnPageBean tpb = new TurnPageBean();
        tpb.setCount(getBroInfoCount(con_map));
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
        String cat_id = "";
        String orderby = "i.released_dtime desc";
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
            if (tempA[i].toLowerCase().startsWith("cat_id=")) {
                cat_id = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
            }
            if (tempA[i].toLowerCase().startsWith("model_id=")){
                String model_id = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(model_id)) && (!model_id.startsWith("$model_id"))) {
                    con_map.put("model_id", model_id);
                }
            }
            if (tempA[i].toLowerCase().startsWith("title=")){
                String title = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(title)) && (!title.startsWith("$title"))) {
                    con_map.put("title", title);
                }
            }
            if (tempA[i].toLowerCase().startsWith("info_type=")){
                String info_type = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(info_type)) && (!info_type.startsWith("$info_type")) && (FormatUtil.isNumeric(info_type))) {
                    con_map.put("info_type", info_type);
                }
            }
            if (tempA[i].toLowerCase().startsWith("keywords=")){
                String keywords = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(keywords)) && (!keywords.startsWith("$keywords"))) {
                    con_map.put("keywords", keywords);
                }
            }
            if (tempA[i].toLowerCase().startsWith("gk_no=")){
                String gk_no = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(gk_no)) && (!gk_no.startsWith("$gk_no"))) {
                    con_map.put("gk_no", gk_no);
                }
            }
            if (tempA[i].toLowerCase().startsWith("gk_index=")){
                String gk_index = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(gk_index)) && (!gk_index.startsWith("$gk_index"))) {
                    con_map.put("gk_index", gk_index);
                }
            }
            if (tempA[i].toLowerCase().startsWith("is_top=")){
                String is_top = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(is_top)) && (!is_top.startsWith("$is_top")) && (FormatUtil.isNumeric(is_top))) {
                    con_map.put("is_top", is_top);
                }
            }
            if (tempA[i].toLowerCase().startsWith("is_tuijian=")){
                String is_tuijian = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(is_tuijian)) && (!is_tuijian.startsWith("$is_tuijian")) && (FormatUtil.isNumeric(is_tuijian))) {
                    con_map.put("is_tuijian", is_tuijian);
                }
            }
            if (tempA[i].toLowerCase().startsWith("weight=")){
                String weight = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(weight)) && (!weight.startsWith("$weight")) && (FormatUtil.isNumeric(weight))) {
                    con_map.put("weight", weight);
                }
            }
            if (tempA[i].toLowerCase().startsWith("thumb_url=")){
                String thumb_url = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(thumb_url)) && (!thumb_url.startsWith("$thumb_url"))) {
                    con_map.put("thumb_url", thumb_url);
                }
            }
            if (tempA[i].toLowerCase().startsWith("cat_id=")) {
                cat_id = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
            }
            if (!"".equals(cat_id) && !"0".equals(cat_id) && !cat_id.startsWith("$cat_id")) {
            	con_map.put("cat_id", getInfoCatIds(cat_id, cat_id));
            }
            if (tempA[i].toLowerCase().startsWith("start_time=")){
                String start_time = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(start_time)) && (!start_time.startsWith("$start_time")) && (FormatUtil.isNumeric(start_time))) {
                    con_map.put("start_time", start_time);
                }
            }
            if (tempA[i].toLowerCase().startsWith("end_time=")){
                String end_time = FormatUtil.formatNullString(tempA[i].substring(tempA[i].indexOf("=") + 1));
                if ((!"".equals(end_time)) && (!end_time.startsWith("$end_time")) && (FormatUtil.isNumeric(end_time))) {
                    con_map.put("end_time", end_time);
                }
            }
        }
        con_map.put("page_size", page_size + "");
        con_map.put("current_page", cur_page + "");
        con_map.put("start_num", (cur_page - 1) * page_size + "");
        con_map.put("orderby", orderby);
	}
	
	public static String initSql(String sql, Map<String, String> con_map,String type){
		Set<String> keys = con_map.keySet();
		for(String key : keys){
			if(key.equals("cat_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.cat_id in ("+con_map.get(key)+")";
			}
			if(key.equals("model_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.model_id = '"+con_map.get(key)+"'";
			}
			if(key.equals("title") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.info_title like '%"+con_map.get(key)+"%'";
			}
			if(key.equals("info_type") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.info_type = "+con_map.get(key);
			}
			if(key.equals("keywords") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and (i.info_title like '%"+con_map.get(key)+"%' or i.keywords like '%"+con_map.get(key)+"%')";
			}
			if(key.equals("gk_no") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.gk_no = '"+con_map.get(key)+"'";
			}
			if(key.equals("gk_index") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.gk_index = '"+con_map.get(key)+"'";
			}
			if(key.equals("is_top") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.is_top = "+con_map.get(key);
			}
			if(key.equals("is_tuijian") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.is_tuijian = "+con_map.get(key);
			}
			if(key.equals("weight") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.weight = "+con_map.get(key);
			}
			if(key.equals("thumb_url") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.thumb_url is not null";
			}
			if(key.equals("start_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.gk_fwrq >=" + con_map.get(key);
			}
			if(key.equals("end_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
				sql += " and i.gk_fwrq <= " + con_map.get(key);
			}
		}
		sql += " and i.info_status = 3";
		if(type.equals("list")){
			sql+=" union select i.*,c.ch_name from cms_info i,cms_info_category c where i.cat_id=c.id and i.id in ("+QueryInfoListUtils.getInfoCats(con_map.get("cat_id"))+")";
			for(String key : keys){
				if(key.equals("model_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.model_id = '"+con_map.get(key)+"'";
				}
				if(key.equals("title") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.info_title like '%"+con_map.get(key)+"%'";
				}
				if(key.equals("info_type") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.info_type = "+con_map.get(key);
				}
				if(key.equals("keywords") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and (i.info_title like '%"+con_map.get(key)+"%' or i.keywords like '%"+con_map.get(key)+"%')";
				}
				if(key.equals("gk_no") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_no = '"+con_map.get(key)+"'";
				}
				if(key.equals("gk_index") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_index = '"+con_map.get(key)+"'";
				}
				if(key.equals("is_top") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.is_top = "+con_map.get(key);
				}
				if(key.equals("is_tuijian") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.is_tuijian = "+con_map.get(key);
				}
				if(key.equals("weight") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.weight = "+con_map.get(key);
				}
				if(key.equals("thumb_url") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.thumb_url is not null";
				}
				if(key.equals("start_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_fwrq >=" + con_map.get(key);
				}
				if(key.equals("end_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_fwrq <= " + con_map.get(key);
				}
			}
			sql += " and i.info_status = 3";
		}else{
			sql += " or (i.id in ("+QueryInfoListUtils.getInfoCats(con_map.get("cat_id"))+")";
			for(String key : keys){
				if(key.equals("model_id") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.model_id = '"+con_map.get(key)+"'";
				}
				if(key.equals("title") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.info_title like '%"+con_map.get(key)+"%'";
				}
				if(key.equals("info_type") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.info_type = "+con_map.get(key);
				}
				if(key.equals("keywords") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and (i.info_title like '%"+con_map.get(key)+"%' or i.keywords like '%"+con_map.get(key)+"%')";
				}
				if(key.equals("gk_no") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_no = '"+con_map.get(key)+"'";
				}
				if(key.equals("gk_index") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_index = '"+con_map.get(key)+"'";
				}
				if(key.equals("is_top") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.is_top = "+con_map.get(key);
				}
				if(key.equals("is_tuijian") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.is_tuijian = "+con_map.get(key);
				}
				if(key.equals("weight") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.weight = "+con_map.get(key);
				}
				if(key.equals("thumb_url") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.thumb_url is not null";
				}
				if(key.equals("start_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_fwrq >=" + con_map.get(key);
				}
				if(key.equals("end_time") && con_map.containsKey(key) && !StringUtil.isBlank(con_map.get(key))){
					sql += " and i.gk_fwrq <= " + con_map.get(key);
				}
			}
			sql += " and i.info_status = 3";
			sql += ")";
		}
		return sql;
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
