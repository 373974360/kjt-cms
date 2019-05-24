<%@page import="java.net.URL"%>
<%@page import="com.cms.siteview.data.CategoryUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.cms.siteview.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
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
%>