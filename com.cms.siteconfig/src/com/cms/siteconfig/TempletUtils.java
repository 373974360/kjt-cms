/**
 * 
 */
package com.cms.siteconfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;


import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-22 09:56:47
 * 
 */
@Bizlet("模板管理IO帮助类")
public class TempletUtils {
	
	@Bizlet("写入模板")
	public static boolean saveTemplateFileHandl(int id, String content) {
		String path = TempletUtils.class.getClassLoader().getResource("/").getPath().replace("classes", "templet")+id+"_vm.vm";
		mkDirectory(new File(path));
		try {
			return writeStringToFile(new File(path), content,false, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void mkDirectory(File f) {
		if (!f.exists()) {
			if (f.getPath().toLowerCase().endsWith(".vm")) {
				f.getParentFile().mkdirs();
				try {
					f.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				f.mkdirs();
			}
		}
	}

	public static boolean writeStringToFile(File file, String strContent,
			boolean blnAppend, String charsetName) throws IOException {
		if (!file.exists()) {
			file.getParentFile().mkdirs();
			file.createNewFile();
		}
		OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(
				file, blnAppend), charsetName);
		fw.write(strContent);
		fw.close();
		return true;
	}
}
