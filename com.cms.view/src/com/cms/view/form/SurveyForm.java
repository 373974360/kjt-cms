/**
 * 
 */
package com.cms.view.form;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cms.view.data.SurveyUtil;
import com.cms.view.survey.CmsSurvey;
import com.cms.view.velocity.DateUtil;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-11 17:48:34
 */
@Bizlet("")
public class SurveyForm {
	
	@Bizlet("")
	public static int checkIpSubmitNums(String ip,String surveyId){
		int code = 0;
		CmsSurvey survey = SurveyUtil.getSurvey(surveyId);
		String lastTime = getSurveyAnswerLastTime(surveyId,ip);
		int answerNum = getSurveyAnswerNum(surveyId,ip);
		int day = 0;
		if(!StringUtil.isBlank(lastTime)){
			day = Integer.parseInt(DateUtil.daysOf2Day(DateUtil.getCurrentDate(),lastTime.substring(0,10))+"");
		}
		if(survey.getSubmitNum()!=0 && answerNum >= survey.getSubmitNum()){
			code = 1; //提交次数超过限制
		}
		if(day < survey.getSubmitDay()){
			code = 2; //提交过于频繁
		}
		if(survey.getIsEnd()==2){
			code = 3;//调查已结束
		}
		return code;
	}
	
	public static String getSurveyAnswerLastTime(String surveyId,String ip){
		String sql = "select max(answer_time) as answer_time from cms_survey_answer where survey_id="+surveyId+" and ip = '"+ip+"' order by answer_time desc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			DataObject[] dobj = new DataObject[1];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.view.survey.CmsSurveyAnswer");
				dtr.setString("answerTime", rs.getString("answer_time"));
				dobj[0] = dtr;
			}
			if(dobj[0]!=null){
				return dobj[0].getString("answerTime");
			}
			return "";
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	public static int getSurveyAnswerNum(String surveyId,String ip){
		int totle = 0;
		String sql = "select count(id) as totle from cms_survey_answer where survey_id="+surveyId+" and ip = '"+ip+"' order by answer_time desc";
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
