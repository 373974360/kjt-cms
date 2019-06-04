/**
 * 
 */
package com.cms.content.html;


import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.cms.siteconfig.TempletUtils;
import com.cms.view.data.CategoryUtil;
import com.cms.view.data.InfoDataUtil;
import com.cms.view.velocity.VelocityInfoContextImp;
import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-23 17:31:38
 *
 */
@Bizlet("生成静态内容页")
public class CreateContentHTML {
	/**
     * 批量生成内容页
     *
     * @param List<InfoBean> l
     * @param Set<Integer>   cat_ids
     * @throws IOException
     */
	@Bizlet("生成静态内容页")
    public static boolean createContentHTML(DataObject[] objArray) {
        int index = 1;
        for (DataObject obj : objArray) {
            try {
                System.out.println("总共需要生成" + objArray.length + "条信息，当前第" + index + "条，" + "info_id为：" + obj.getString("id"));
                createContentHTML(obj);
                index = index + 1;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return true;
    }
	
	@Bizlet("生成静态内容页")
    public static boolean createContentHTML(DataObject obj) {
        try {
            if (obj != null) {
                //发布状态下才生成页面,必须不是链接类型的
                if (obj.getString("infoStatus").equals("3") && !obj.getString("modelId").equals("link")) {
                    String template_id = InfoDataUtil.getTempletId(obj.getString("modelId"),obj.getString("catId"));
                    String content_url = obj.getString("contentUrl");
                    if (StringUtil.isBlank(content_url)) {
                        content_url = getFoldePathByCategoryID(obj.getString("catId"))+"/";
                        content_url = content_url + obj.getString("id") + ".html";
                        updateContentUrl(content_url, obj.getString("id"));
                    }
                    VelocityInfoContextImp vici = new VelocityInfoContextImp(obj.getString("id"),template_id);
                    String content = vici.parseTemplate();
                    String savePath = TempletUtils.class.getClassLoader().getResource("/").getPath();
                    savePath = savePath.substring(0,savePath.indexOf("WEB-INF"))+content_url;
                    TempletUtils.writeStringToFile(savePath, content, false, "utf-8");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
	
	@Bizlet("删除静态内容页")
    public static boolean deleteContentHTML(DataObject obj) {
        try {
        	if(obj!=null){
        		String contentUrl = obj.getString("contentUrl");
                String savePath = TempletUtils.class.getClassLoader().getResource("/").getPath();
                savePath = savePath.substring(0,savePath.indexOf("WEB-INF"))+contentUrl;
                File f = new File(savePath);
                if (f.exists())
                    f.delete();
        	}
        	
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
	
	public static void updateContentUrl(String contentUrl,String id) {
		String sql = "update cms_info set content_url = '"+contentUrl+"' where id = "+id;
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
	
	public static String getFoldePathByCategoryID(String catId){
		DataObject currObj = CategoryUtil.getCategoryById(catId);
		String catIds = catId;
		for(int i=0;i<10;i++){
			currObj = CategoryUtil.getCategoryById(currObj.getString("parentId"));
			if(currObj==null||currObj.getString("id")==null){
				break;
			}
			catIds += ","+currObj.getString("id");
		}
		String[] catArray = catIds.split(",");
		String[] reverseArray = new String[catArray.length];
		for (int i = 0; i < catArray.length; i++) {
			reverseArray[i] = catArray[catArray.length - i - 1];
        }
		String path = "";
		for(int i=0;i<reverseArray.length;i++){
			path+="/"+CategoryUtil.getCategoryById(reverseArray[i]).getString("enName");
		}
		return path;
	}
}
