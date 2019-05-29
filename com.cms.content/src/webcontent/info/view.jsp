<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	String infoId = request.getParameter("info_id");
	if(infoId != null && !"".equals(infoId)){
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		vc.setTemplateID(infoId,"info","2");
		String content = vc.parseTemplate();
		if(content != null && !"".equals(content) && content.length() > 0){
			out.println(content);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
			request.getRequestDispatcher("/404.htm").forward(request,response);
		}
	}
%>