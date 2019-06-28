/**
 * 
 */
package com.cms.commonality;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.eos.common.connection.ConnectionHelper;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-12 11:18:14
 *
 */
@Bizlet("")
public class GetTimerSurveyList {

	/**
	 * @author chaoweima
	 * 
	 */
	@Bizlet("")
	public static void setEndSurvey(String currTime) {
		String sql = "update cms_survey set is_end = 2 where end_time <= '"+currTime+"'";
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
}
