<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	if(!JspFilterHandl.isTure(request)){
		String catId = request.getParameter("cat_id");
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		vc.setTemplateID(catId,"indexTemplet");
		String content = vc.parseTemplate();
		if(content != null && !"".equals(content) && content.length() > 0){
			out.println(content);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
			request.getRequestDispatcher("/404.htm").forward(request,response);
		}
	}else{
		out.println("<script>");
		out.println("top.alert('请勿输入非法字符！')");
		out.println("location.href='/'");
		out.println("</script>");
		return;
	}
%>