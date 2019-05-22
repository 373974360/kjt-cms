<%@page import="com.cms.siteview.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	String catId = request.getParameter("cat_id");
	if(catId != null && !"".equals(catId)){
		String templetId = "22";//根据栏目ID 查询栏目列表页模板
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		vc.setTemplateID(templetId);
		String content = vc.parseTemplate();
		if(content != null && !"".equals(content) && content.length() > 0){
			out.println(content);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
			request.getRequestDispatcher("/404.htm").forward(request,response);
		}
	}
%>