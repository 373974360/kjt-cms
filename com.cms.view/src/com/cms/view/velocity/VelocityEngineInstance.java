/**
 * 
 */
package com.cms.view.velocity;

import org.apache.velocity.app.VelocityEngine;

import com.cms.siteconfig.TempletUtils;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-22 11:19:25
 *
 */
@Bizlet("")
public class VelocityEngineInstance {
	
	private static VelocityEngine ve = null;
	
	public static VelocityEngine getInstance(){
		if(ve == null){
			ve = createVelocityEngineInstance();
		}
		return ve;
	}
	
	private static VelocityEngine createVelocityEngineInstance(){
		String host_rootPath = TempletUtils.class.getClassLoader().getResource("/").getPath().replace("classes", "templet");
		VelocityEngine velocityEngine = new VelocityEngine();
		velocityEngine.setProperty("input.encoding", "utf-8");
		velocityEngine.setProperty("output.encoding", "utf-8");
		velocityEngine.setProperty("file.resource.loader.path", host_rootPath);
		velocityEngine.setProperty("velocimacro.library.autoreload", "true");
		velocityEngine.setProperty("resource.loader.cache", "false");
		velocityEngine.setProperty("velocimacro.max.depth", 100);
		velocityEngine.init();
		return velocityEngine;
	}
}
