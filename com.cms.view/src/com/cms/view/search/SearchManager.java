/**
 * 
 */
package com.cms.view.search;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:06:49
 *
 */
@Bizlet("")
public class SearchManager {
	public static SearchResult search(HttpServletRequest request){  
	   String query = SearchUtil.getXmlParam(request);
	   return search(query);
	}
	/**
	 *简单搜索
	 *@param String query
	 *@return SearchResult 
	* */
	public static SearchResult search(String query){  
	   Map map = SearchUtil.initPraToMap(query);
	   return SearchInfoManager.search(map);
	}
}
