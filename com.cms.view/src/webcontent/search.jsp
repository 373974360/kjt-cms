<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page import="com.cms.view.search.SearchManager"%>
<%@page import="com.cms.view.search.SearchResult"%>
<%@page import="com.cms.view.data.CategoryUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
	String t_id = request.getParameter("t_id");
	URL url = new URL(request.getRequestURL().toString());
	String domain = url.getHost();
    DataObject siteObj = CategoryUtil.getSiteByDomain(domain);
	if(t_id==null || t_id==""){
		return;
	}
	SearchResult result = SearchManager.search(request);
	VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
	vc.vcontextPut("result",result);
	vc.setTemplateID(t_id); 
	out.println(vc.parseTemplate()); 
%>