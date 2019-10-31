<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@page pageEncoding="UTF-8"%>
<%
	String catId = request.getParameter("cat_id");
	String t_id = request.getParameter("tm_id");
	String sq_id = request.getParameter("sq_id");
	String hv_id = request.getParameter("hv_id");
	String zixun = request.getParameter("zixun");
	if(!JspFilterHandl.isTure(request) && (!StringUtil.isBlank(catId) || !StringUtil.isBlank(t_id))){
		try{
			if(!StringUtil.isBlank(catId)){
				int i = Integer.parseInt(catId);
			}
			if(!StringUtil.isBlank(t_id)){
				int i = Integer.parseInt(t_id);
			}
			if(!StringUtil.isBlank(sq_id)){
				int i = Integer.parseInt(sq_id);
			}
			if(!StringUtil.isBlank(hv_id)){
				int i = Integer.parseInt(hv_id);
			}
			if(!StringUtil.isBlank(zixun)){
				int i = Integer.parseInt(zixun);
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