/**
 * 
 */
package com.cms.basics;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-10-25 12:49:51
 *
 */
@Bizlet("")
public class SetGroup {
	@Bizlet("")
	public static DataObject setGroupRole(DataObject obj) {
		DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.group.CmsUserGroupRole");
		dtr.setLong("roleId", obj.getInt("ID"));
		return dtr;
	}
	@Bizlet("")
	public static DataObject setGroupUser(DataObject obj) {
		DataObject dtr = DataObjectUtil.createDataObject("com.cms.basics.group.CmsUserGroupUser");
		dtr.setLong("userId", obj.getInt("ID"));
		return dtr;
	}
}
