/**
 * 
 */
package com.cms.search;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 14:14:34
 */
@Bizlet("")
public class SearchInnerManager {
	private static Set infoSetAdd = new HashSet();   //存放信息Id  来实现增量创建索引  -- 添加
	private static Set infoSetDel = new HashSet();   //存放信息Id  来实现增量创建索引  -- 删除
	private static ArrayList<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
	
	static{
		Timer timer = new Timer();
		Date now = new Date();
        SearchIndexTask task = new SearchIndexTask();
        //timer.schedule(task, now, 1000 * 60 * 3); //每3分钟
        timer.schedule(task, now, 1000 * 60 * 1); //每1分钟，测试用
	}
	//存放信息Id  来实现增量创建索引  -- 添加
	@Bizlet("")
	public static void infoSetAdd(String id){
		Map map = new HashMap();
		map.put("id",id);
		map.put("flag","1"); //1 表示是添加
		list.add(map);
	}
	
	//存放信息Id  来实现增量创建索引  -- 删除
	@Bizlet("")
	public static void infoSetDel(String id){
		Map map = new HashMap();
		map.put("id",id);
		map.put("flag","0"); //0表示是删除
		list.add(map);
	}
	static class SearchIndexTask extends TimerTask {
	    public void run() {
	    	System.out.println("Start SearchIndex Task!!!");
			if(list != null && list.size() > 0){
				int size = list.size();//原始list 长度
				for (Iterator it = list.iterator(); it.hasNext();) {
					Map<String, Object> stringObjectMap = (Map<String, Object>)it.next();
					String id = (String)stringObjectMap.get("id");
					String flag = (String)stringObjectMap.get("flag");
					if(flag.equals("1")){
						System.out.println("Create SearchIndex map =====" + id);
						IndexManager.appendSingleDocument(id);
					}
					if(flag.equals("0")){
						System.out.println("Delete SearchIndex map =====" + id);
						IndexManager.deleteSingleDocument(id);
					}
					if(list.size()!=size){//在循环执行生成索引的过程中用户删除或者新增了信息 特别是用户批量删除操作 导致 list 长度改变   跳出循环等待下一次执行
						break;
					}else{
						it.remove();//移除已经生成或者删除的 记录
						size = size-1;//list 原始长度 减1
						continue;
					}
				}
			}
			System.out.println("End SearchIndex Task!!!");
	    }
	}
}
