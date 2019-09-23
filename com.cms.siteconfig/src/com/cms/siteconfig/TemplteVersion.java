/**
 * 
 */
package com.cms.siteconfig;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-09-23 14:38:25
 *
 */
@Bizlet("")
public class TemplteVersion {

	@Bizlet("")
	public static int getVersion(int version){
		return version+1; 
	}
}
