/**
 * 
 */
package com.cms.search;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;

import com.cms.content.QueryCategoryAllTreeNode;
import com.cms.siteconfig.TempletUtils;
import com.cms.view.velocity.FormatUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-06-03 17:43:01
 * 
 */
@Bizlet("")
public class IndexManager {

	public static String indexDir() {
		String savePath = TempletUtils.class.getClassLoader().getResource("/").getPath();
		savePath = savePath.substring(0, savePath.indexOf("WEB-INF")) + "/search/";
		return savePath;
	}

	// 创建所有的信息索引
	public static boolean initAndCreateIndex(boolean isInit) {
		try {
			File file = new File(indexDir());
			if (!file.exists()) {
				initIndexSearch(isInit);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 初始化IndexWriter 如果服务器上没有索引文件夹 调用该方法
	public static void initIndexSearch(boolean isInit) {
		IndexLuceneManager.initIndex();
		if (isInit) {
			readALLToIndex();
		}
	}

	// 通过站点ID读该所有类型的信息到Index中
	public static void readALLToIndex() {
		DataObject[] siteObj =QueryCategoryAllTreeNode.getCategoryById("0");

		for (DataObject obj:siteObj) {
			createAllIndexBySite(obj.getString("enName"));
		}
	}
	public static void createAllIndexBySite(String siteId){
		IndexService.appendALlDocument(siteId);
	}

	// 删除所有信息的索引 -- 也就是删掉索引文件夹
	public static boolean deleteIndexDir() {
		try {
			File file = new File(indexDir());
			if (!file.exists()) {
				return true;
			}
			File fileResource = new File(indexDir() + "_resource");
			if (fileResource.exists()) {
				deleteDir(indexDir() + "_resource");
			}
			deleteDir(indexDir());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 删除目录(包括目录下所有文件).
	 * 
	 * @param strDir
	 *            要删除的目录(绝对路径)
	 * @return true-成功 false-失败 History 2003-05-01 add by kongxx
	 */
	public static boolean deleteDir(String strDir) {
		String[] arrFile = getFileList(strDir);
		File file = null;
		for (int i = 0; i < arrFile.length; i++) {
			file = new File(arrFile[i]);
			if (file.isFile()) {
				file.delete();
			} else if (file.isDirectory()) {
				deleteDir(arrFile[i]);
			}
		}
		file = new File(strDir);
		file.delete();
		return true;
	}

	/**
	 * <pre>
	 * 获得给定目录下所有文件列表包括目录.
	 * 例如：
	 * String []arr = getFileList("e:\\test");
	 * </pre>
	 * 
	 * @param strDir
	 *            给定目录
	 * @return String[]-文件集合
	 */
	public static String[] getFileList(String strDir) {
		ArrayList<String> arrlist = new ArrayList<String>();
		File f = new File(strDir);
		if (f.exists()) {
			File[] arrF = f.listFiles();
			for (int i = 0; i < arrF.length; i++) {
				if (arrF[i].isFile()) {
					arrlist.add(arrF[i].getAbsolutePath());
				} else {
					arrlist.add(arrF[i].getAbsolutePath());
					String[] arr = getFileList(arrF[i].getAbsolutePath());
					for (int j = 0; j < arr.length; j++) {
						arrlist.add(arr[j]);
					}
				} // end if
			} // end for
		} // end if
		return (String[]) arrlist.toArray(new String[arrlist.size()]);
	}
	
	//通过信息Id添加索引
	public static void appendSingleDocument(String infoId){
		IndexService.appendSingleDocumentAppIdInfo(infoId);
	}//通过信息Id删除索引
	public static void deleteSingleDocument(String infoId){
		IndexService.deleteSingleDocument(infoId);
	}
}
