/**
 * 
 */
package com.cms.siteconfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-05-22 09:56:47
 * 
 */
@Bizlet("模板管理IO帮助类")
public class TempletUtils {
	
	/**
	 * @return
	 * @author chaoweima
	 */
	@Bizlet("")
	public static DataObject[] queryTempletAll(String dsName) {
		int counts = 0;
		int it = 0;
		if (dsName == null || dsName.length() == 0)
			dsName = "default";
		String sql = "select id,templet_name from cms_templet order by templet_name asc";
		Connection conn = ConnectionHelper.getCurrentContributionConnection(dsName);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			it = 0;
			if (null != rs) {
				rs.last();
				counts = rs.getRow();
				rs.beforeFirst();
			}	
			DataObject[] dobj = new DataObject[counts];
			while (rs.next()) {
				DataObject dtr = DataObjectUtil.createDataObject("com.cms.siteconfig.templet.CmsTemplet");
				dtr.setString("id", rs.getString("id"));
				dtr.setString("templetName", rs.getString("templet_name"));
				dobj[it] = dtr;
				it++;
			}
			return dobj;
		} catch (Throwable e) {
			throw new RuntimeException(e);
		} finally {
			close(rs);
			close(stmt);
			close(conn);
		}
	}
	
	
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
	public static boolean writeStringToFile(String strFile,String strContent, boolean blnAppend, String charsetName) throws IOException {
		File file = new File(strFile);
		return writeStringToFile(file, strContent, blnAppend, charsetName);
	}
	
	private static void close(Connection conn) {
		if (conn == null)
			return;
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static void close(Statement stmt) {
		if (stmt == null)
			return;
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static void close(ResultSet rs) {
		if (rs == null)
			return;
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
