/**
 * 
 */
package com.cms.content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.eos.common.connection.ConnectionHelper;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-09-02 12:35:55
 *
 */
@Bizlet("")
public class ResetGkIndex {
	/**
     * 批量生成内容页
     *
     * @param List<InfoBean> l
     * @param Set<Integer>   cat_ids
     * @throws IOException
     */
	@Bizlet("生成静态内容页")
    public static boolean resetGkIndex(DataObject[] objArray) {
        int index = 1;
        for (DataObject obj : objArray) {
            try {
                System.out.println("总共需要重置" + objArray.length + "条信息，当前第" + index + "条，" + "info_id为：" + obj.getString("id"));
                updateGkIndex(obj,index);
                index = index + 1;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return true;
    }
	
	public static void updateGkIndex(DataObject obj,int i){
		String year = obj.getString("releasedDtime").substring(0,4);
		String num = i+"";
		String index = "000000";
		index = index.substring(0,6-num.length())+num;
		String gkIndex = "SSXKJJST-"+year+"-"+index;
		String sql = "update cms_info set gk_year = "+year+", gk_num = "+num+", gk_index = '"+gkIndex+"' where id = "+obj.getString("id");
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
