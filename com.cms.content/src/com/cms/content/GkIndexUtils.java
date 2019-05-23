/**
 * 
 */
package com.cms.content;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-23 16:44:51
 *
 */
@Bizlet("索引号生成相关")
public class GkIndexUtils {

	@Bizlet("索引号生成相关")
	public static GkIndexVo getGkIndex(){
		GkIndexVo indexvo = new GkIndexVo();
		String year = DateUtils.getYear();
		String num = getInfoContent(year)+"";
		String index = "000000";
		index = index.substring(0,6-num.length())+num;
		String gkIndex = "SSXKJJST-"+year+"-"+index;
		indexvo.setYear(year);
		indexvo.setNum(num);
		indexvo.setIndex(gkIndex);
		return indexvo;
	}
	
	public static int getInfoContent(String year){
		int totle = 0;
		String sql = "select count(id) as totle from cms_info where input_dtime like '"+year+"%'";
		Connection conn = ConnectionHelper.getCurrentContributionConnection("default");
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				totle = rs.getInt("totle");
			}
			return totle+1;
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
