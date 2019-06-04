/**
 * 
 */
package com.cms.search;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-03 17:41:03
 *
 */
@Bizlet("")
public class SearchForManager {
	//创建所有的信息索引
	public static boolean initAndCreateIndex(){
		boolean result = IndexManager.initAndCreateIndex(true);
		return result;
	}

	//删除所有信息的索引 -- 也就是删掉索引文件夹
	public static boolean deleteIndexDir(){
		return IndexManager.deleteIndexDir();
	}
}
