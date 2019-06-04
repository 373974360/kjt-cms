/**
 * 
 */
package com.cms.view.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:15:12
 *
 */
@Bizlet("")
public class InitCiku {
	public static List<String> list = new ArrayList<String>();
	public static HashMap<String, String> hashMap = new HashMap<String, String>();
	static String classpath = InitCiku.class.getResource("").getPath();
	
	static {
		InitCiku.initCiku("");
	}
	
	public static void initCiku(String root) {
		try {
			if(hashMap.size()<1){//还没有进行初始化
				FileReader fr = new FileReader(classpath + File.separator + "dict2.txt");
				BufferedReader bf = new BufferedReader(fr);
				String str;
				while ((str = bf.readLine()) != null) {
					String strR[] = str.split("=");
					// System.out.println(strR[1]);
					hashMap.put(strR[0], strR[1]);
				}
				bf.close();
				fr.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	public static String getTongyinci(String search){
        String pinyin = Pinyin4j.makeStringByStringSet(Pinyin4j.getPinyin(search));
        String py[] = pinyin.split(",");
  		StringBuffer sb = new StringBuffer();
	    for(String py_1 : py){
    	     String value = hashMap.get(py_1);
    	     if(value!=null){
				 sb.append(value+",");
    	     }
	    }
	    HashSet<String> strSet = new HashSet<String>();
	    CollectionUtils.addAll(strSet, sb.toString().replaceAll(",,",",").split(","));
	    Iterator<String> it = strSet.iterator();
	    sb.delete(0, sb.length());
	    while(it.hasNext()){
	    	sb.append(it.next()+" ");
	    }
        return sb.toString().replaceAll(",,",",");
	}
	
}
