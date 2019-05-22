/**
 * 
 */
package com.cms.siteview.velocity;

import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-22 11:16:20
 *
 */
@Bizlet("")
public class VelocityContextAbstract {

	protected VelocityContext vcontext = new VelocityContext();
	
	private static Map<String, Object> map = new HashMap<String, Object>();
	protected String template_id = "";
	
	/**
	 * 处理request提交过来的参数，并put进vcontext
	 * @return boolean
	 */
	public VelocityContextAbstract(HttpServletRequest request){
		inputParam(request);
	}
	
	public void inputParam(HttpServletRequest request){  
		vcontext.put("v_session", request.getSession());
		vcontext.put("v_request", request);//request对象
		String params = FormatUtil.getParameterStrInRequest(request);
		if(params != null && !"".equals(params)){
			String[] tempA = params.split("&");
			for (int i=0;i<tempA.length;i++){
				int index_num = tempA[i].indexOf("=");
				String vals = tempA[i].substring(index_num+1);
				if(FormatUtil.isNumeric(vals)){
					try{
						vcontext.put(tempA[i].substring(0,index_num), Integer.parseInt(vals));
					}catch(NumberFormatException n){
						vcontext.put(tempA[i].substring(0,index_num), vals);
					}
				}else
					vcontext.put(tempA[i].substring(0,index_num), vals);
			}
			if(params.indexOf("cur_page") == -1)
				vcontext.put("cur_page", 1);
			vcontext.put("requet_params", params);
		}
	}
	
	static {
		//从配置文件中得来
		try {
			try{
				map.put("InfoUtilData", Class.forName("com.cms.siteview.data.InfoDataUtil"));
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 模板解析并保存解析后 的文件
	 * @return boolean
	 */
	public String parseTemplate(){
		try{
			String path = template_id+"_vm.vm";
			Template template = VelocityEngineInstance.getInstance().getTemplate(path);
			Writer writer = new StringWriter();
			loadClassContext();
			template.merge(vcontext, writer);
			return writer.toString();
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	
	/**
	 * 加载所有前台类
	 *  void
	 */
	public void loadClassContext(){
		Set<String> keys = map.keySet();
		for(String key : keys){
			vcontext.put(key, map.get(key));
		}
	}
}
