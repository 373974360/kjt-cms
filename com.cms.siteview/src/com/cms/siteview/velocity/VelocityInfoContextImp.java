/**
 * 
 */
package com.cms.siteview.velocity;

import javax.servlet.http.HttpServletRequest;

import com.eos.system.annotation.Bizlet;

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
	

	public void setTemplateID(String templateId){
		template_id = templateId;
	}
	//详情页
	public void setTemplateID(String infoId,String tempType){
		template_id = "22";//根据信息ID 查询 该信息归属栏目的详情模板
	}
}
