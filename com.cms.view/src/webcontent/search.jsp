<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page import="com.cms.view.search.SearchManager"%>
<%@page import="com.cms.view.search.SearchResult"%>
<%@page import="com.cms.view.data.CategoryUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
	String t_id = request.getParameter("tm_id");
	String catId = request.getParameter("catId");
	String hvid = request.getParameter("hvid");
	String pz = request.getParameter("pz");
	if(!JspFilterHandl.isTure(request) && !StringUtil.isBlank(t_id)){
		try{
			if(!StringUtil.isBlank(t_id)){
				int i = Integer.parseInt(t_id);
			}
			if(!StringUtil.isBlank(catId)){
				int i = Integer.parseInt(catId);
			}
			if(!StringUtil.isBlank(hvid)){
				int i = Integer.parseInt(hvid);
			}
			if(!StringUtil.isBlank(pz)){
				int i = Integer.parseInt(pz);
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