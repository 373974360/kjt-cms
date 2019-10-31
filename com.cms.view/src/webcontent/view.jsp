<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@page pageEncoding="UTF-8"%>
<%
	String infoId = request.getParameter("info_id");
	String t_id = request.getParameter("tm_id");
	if(!JspFilterHandl.isTure(request) && (!StringUtil.isBlank(t_id)||!StringUtil.isBlank(infoId))){
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		if(t_id!=null&&t_id!=""){
			vc.setTemplateID(t_id);
		}else{
			vc.setTemplateID(infoId,"info");
		}
		String content = vc.parseTemplate();
		if(content != null && !"".equals(content) && content.length() > 0){
			out.println(content);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
			request.getRequestDispatcher("/404.htm").forward(request,response);
		}
	}else{
		out.println("<script>");
		out.println("location.href='/'");
		out.println("</script>");
		return;
	}
%>