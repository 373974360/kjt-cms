<%@page import="com.cms.siteview.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	String templetId = "22";//查询站点绑定的首页模板
	VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
	vc.setTemplateID(templetId);
	String content = vc.parseTemplate();
	if(content != null && !"".equals(content) && content.length() > 0){
		out.println(content);
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
		request.getRequestDispatcher("/404.htm").forward(request,response);
	}
%>