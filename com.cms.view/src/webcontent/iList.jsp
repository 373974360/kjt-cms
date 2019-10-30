<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	if(!JspFilterHandl.isTure(request)){
		String catId = request.getParameter("cat_id");
		String t_id = request.getParameter("tm_id");
		try{
			if(catId!=null){
				int i = Integer.parseInt(catId);
			}
			if(t_id!=null){
				int i = Integer.parseInt(t_id);
			}
		}catch(Exception e){
			out.println("<script>");
			out.println("top.location.href='/'");
			out.println("</script>");
			return;
		}
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		if(t_id!=null&&t_id!=""){
			vc.setTemplateID(t_id);
		}else{
			vc.setTemplateID(catId,"listTemplet");
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