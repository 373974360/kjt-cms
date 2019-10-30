<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page import="com.cms.view.search.SearchManager"%>
<%@page import="com.cms.view.search.SearchResult"%>
<%@page import="com.cms.view.data.CategoryUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
	if(!JspFilterHandl.isTure(request)){
		String t_id = request.getParameter("tm_id");
		try{
			if(t_id!=null){
				int i = Integer.parseInt(t_id);
			}
		}catch(Exception e){
			out.println("<script>");
			out.println("top.location.href='/'");
			out.println("</script>");
			return;
		}
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
	}else{
		out.println("<script>");
		out.println("location.href='/'");
		out.println("</script>");
		return;
	}
%>