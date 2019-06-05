/**
 * 
 */
package com.cms.siteconfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-05 15:56:12
 *
 */
@Bizlet("")
public class FileOperation {

	/**
     * 用指定编码向指定文件中写入内容.
     * @param strFile String
     * @param strContent String
     * @param blnAppend boolean
     * @param charsetName String
     * @throws IOException
     * @return boolean
     */
    public static boolean writeStringToFile(String strFile,
                                            String strContent,
                                            boolean blnAppend, String charsetName) throws
        IOException {
        File file = new File(strFile);
        return writeStringToFile(file, strContent, blnAppend, charsetName);
    }
    
    /**
     * 用指定编码向指定文件中写入内容.
     * @param file File
     * @param strContent String
     * @param blnAppend boolean
     * @param charsetName String
     * @throws IOException
     * @return boolean
     */
    public static boolean writeStringToFile(File file,
                                            String strContent,
                                            boolean blnAppend, String charsetName) throws
        IOException {
        if (!file.exists()) {
        	file.getParentFile().mkdirs();
            file.createNewFile();
        }
        OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(file, blnAppend),
            charsetName);
        fw.write(strContent);
        fw.close();
        return true;
    }
}
