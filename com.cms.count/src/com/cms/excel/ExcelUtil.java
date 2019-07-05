/**
 * 
 */
package com.cms.excel;

import com.eos.system.annotation.Bizlet;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import com.eos.foundation.common.io.FileUtil;
import com.eos.foundation.eoscommon.ConfigurationUtil;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.BizletParam;
import com.eos.system.annotation.ParamType;
import commonj.sdo.DataObject;

/**
 * 
 * Excel文件操作工具类<BR>
 * 
 * @author primeton wengzr (mailto:)
 */
@Bizlet("Excel工具操作类")
public class ExcelUtil {
	private ExcelUtil() {
		// 工具类不允许实例化
	}

	/**
	 * 将Excel数据导入到数据库指定的表，默认每500条数据执行一次批处理导入
	 * 
	 * @param excelFile
	 *            Excel文件名
	 * @param entityFullName
	 *            导入的实体全名
	 * @return
	 * @throws Exception
	 */
	@Bizlet(value = "将Excel数据导入到数据库指定的表", params = {
			@BizletParam(index = 0, paramAlias = "excelFile", type = ParamType.CONSTANT),
			@BizletParam(index = 1, paramAlias = "entityFullName", type = ParamType.CONSTANT) })
	public static int importExcel(String excelFile, String entityFullName)
			throws Exception {
		ExcelTemplate template = new ExcelTemplate();
		return template.importData(excelFile, entityFullName, 500);
	}

	/**
	 * 将指定的对象数组exportObjects导出到指定模板的Excel文件
	 * 
	 * @param exportObjects
	 *            待导出的对象数组
	 * @param exportInfo
	 *            模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename
	 *            模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(value = "将指定的对象数组导出到指定模板的Excel文件", params = {
			@BizletParam(index = 0, paramAlias = "exportObjects", type = ParamType.VARIABLE),
			@BizletParam(index = 1, paramAlias = "exportInfo", type = ParamType.VARIABLE),
			@BizletParam(index = 2, paramAlias = "templateFilename", type = ParamType.CONSTANT) })
	public static String exportExcel(DataObject[] exportObjects,
			DataObject exportInfo, String templateFilename) throws Exception {
		return exportExcel(exportObjects, exportInfo, templateFilename, false,
				false);
	}

	/**
	 * 分页将对象数组导出到指定的模板Excel文件,注意：此时模板文件必需包含Excel表格的分页符
	 * 
	 * @param exportObjects
	 *            待导出的对象数组
	 * @param exportInfo
	 *            模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename
	 *            模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(value = "分页将对象数组导出到指定的模板Excel文件", params = {
			@BizletParam(index = 0, paramAlias = "exportObjects", type = ParamType.VARIABLE),
			@BizletParam(index = 1, paramAlias = "exportInfo", type = ParamType.VARIABLE),
			@BizletParam(index = 2, paramAlias = "templateFilename", type = ParamType.CONSTANT) })
	public static String exportExcelWithPagnation(DataObject[] exportObjects,
			DataObject exportInfo, String templateFilename) throws Exception {
		return exportExcel(exportObjects, exportInfo, templateFilename, true,
				false);
	}

	/**
	 * 分工作表将对象数组导出到指定的模板Excel文件，默认情况下输出工作表最大行:20000
	 * 
	 * @param exportObjects
	 *            待导出的对象数组
	 * @param exportInfo
	 *            模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename
	 *            模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(value = "分工作表将对象数组导出到指定的模板Excel文件", params = {
			@BizletParam(index = 0, paramAlias = "exportObjects", type = ParamType.VARIABLE),
			@BizletParam(index = 1, paramAlias = "exportInfo", type = ParamType.VARIABLE),
			@BizletParam(index = 2, paramAlias = "templateFilename", type = ParamType.CONSTANT) })
	public static String exportExcelWithSheet(DataObject[] exportObjects,
			DataObject exportInfo, String templateFilename) throws Exception {
		return exportExcel(exportObjects, exportInfo, templateFilename, false,
				true);
	}

	/**
	 * 导出Excel文件,根据指定路径下的模板生成输出的Excel文件
	 * 
	 * @param exportObjects
	 *            待导出的对象数组
	 * @param exportInfo
	 *            模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename
	 *            模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @param autoPagination
	 *            是否分页
	 * @param autoSheet
	 *            是否分工作表
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	private static String exportExcel(DataObject[] exportObjects,
			DataObject exportInfo, String templateFilename,
			boolean autoPagination, boolean autoSheet) throws Exception {
		String filename = templateFilename;
		if (filename.indexOf(".xls") == -1) {
			filename += ".xls";
		}
		// 临时路径是服务器当前war下面的excel-config目录
		String urlDir = "/count/info/";
		String templateDir = ApplicationContext.getInstance().getWarRealPath() + urlDir;
		String excelExportMaxnum = "1000000";

		if (!templateDir.endsWith("/")) {
			templateDir += "/";
		}
		String tempDir = templateDir + "temp/";
		File file = new File(tempDir);
		if (!file.exists()) {
			// 创建临时目录
			FileUtil.mkDir(tempDir);
			// file.createNewFile();
		}
		String templateFile = templateDir + filename;
		String tempName = generateOutputExcelFile(filename);
		String outputFile = tempDir + tempName;
		ExcelTemplate template = new ExcelTemplate(templateFile, outputFile);
		template.setAutoPagination(autoPagination);
		template.setAutoSheet(autoSheet);
		int excelExportMaxnumInt = 0;
		try {
			excelExportMaxnumInt = Integer.parseInt(excelExportMaxnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		template.setMaxRow(excelExportMaxnumInt);
		template.generate(Arrays.asList(exportObjects), exportInfo);
		String downloadUrl = urlDir+"temp/"+tempName;
		return downloadUrl;
	}

	/**
	 * 生成EXCEL输出文件，默认带时间戳
	 * 
	 * @param templateFilename
	 *            文件名
	 * @return
	 */
	private static String generateOutputExcelFile(String templateFilename) {
		String filename = templateFilename;
		if (templateFilename.endsWith(".xls")) {
			filename = templateFilename.substring(0,
					templateFilename.length() - 4);
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String datetimeString = format.format(new Date());
		filename = filename + "_" + datetimeString + ".xls";
		return filename;
	}
}
