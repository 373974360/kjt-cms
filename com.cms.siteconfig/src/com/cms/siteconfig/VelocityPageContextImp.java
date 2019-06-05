/**
 * 
 */
package com.cms.siteconfig;

import com.cms.view.velocity.VelocityContextAbstract;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-05 15:52:46
 *
 */
@Bizlet("")
public class VelocityPageContextImp extends VelocityContextAbstract {

	public String getHtmlContent(String templet_id){
		template_id = templet_id;
		return super.parseTemplate();
	}	
}
