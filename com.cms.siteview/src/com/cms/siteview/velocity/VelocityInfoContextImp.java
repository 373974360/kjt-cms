/**
 * 
 */
package com.cms.siteview.velocity;

import javax.servlet.http.HttpServletRequest;

import com.cms.siteview.data.CategoryUtil;
import com.cms.siteview.data.InfoDataUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-22 11:17:43
 *
 */
@Bizlet("")
public class VelocityInfoContextImp extends VelocityContextAbstract {
	public VelocityInfoContextImp(HttpServletRequest request){
		super(request);
	}
	public VelocityInfoContextImp(String infoId,String templet_id){
		DataObject infoData = InfoDataUtil.getInfoData(infoId);
		vcontext.put("cat_id", infoData.getString("catId"));
		vcontext.put("infoData", infoData);
		template_id = templet_id;			
	}
	public void setTemplateID(String templateId){
		template_id = templateId;
	}
	public void setTemplateID(String catId,String tempType){
		if(tempType.equals("info")){
			DataObject infoData = InfoDataUtil.getInfoData(catId);
			DataObject modelData = InfoDataUtil.getModelById(infoData.getString("modelId"));
			vcontext.put("cat_id", infoData.getString("catId"));
			vcontext.put("infoData", infoData);
			template_id = modelData.getString("infoTemplet");
		}else{
			DataObject catObj = CategoryUtil.getCategoryById(catId);
			template_id = catObj.getString(tempType);
		}
	}
}
