/**
 * 
 */
package com.cms.content.html;


import com.cms.siteconfig.TempletUtils;
import com.cms.siteview.data.InfoDataUtil;
import com.cms.siteview.velocity.VelocityInfoContextImp;
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
                	DataObject modelData = InfoDataUtil.getModelById(obj.getString("modelId"));
                    String template_id = modelData.getString("infoTemplet");
                    String content_url = obj.getString("contentUrl");
                    if ((content_url == "") || (content_url == null) || (content_url == "null") || ("".equals(content_url))) {
                        //content_url = CategoryUtil.getFoldePathByCategoryID(ib.getCat_id(), ib.getApp_id(), ib.getSite_id());
                        content_url = content_url + obj.getString("id") + ".html";
                        //Map<K, V> m = new HashMap();
                        //m.put("sql", "update cs_info set content_url ='" + content_url + "' where info_id=" + ib.getInfo_id());
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
}
