<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="java.net.URL"%>
<%@page import="com.cms.view.data.CategoryUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%	
	if(!JspFilterHandl.isTure(request)){
		URL url = new URL(request.getRequestURL().toString());
		String domain = url.getHost();
	    DataObject siteObj = CategoryUtil.getSiteByDomain(domain);
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		vc.setTemplateID(siteObj.getString("indexTemplet"));
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