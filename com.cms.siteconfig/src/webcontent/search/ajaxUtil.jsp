<%@page import="com.cms.search.SearchForManager"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@page language="java"%>
<%
	String dbname = request.getParameter("dbname"); 
	String action = request.getParameter("action"); 	

	boolean success = true;
	if(action.equals("create")){
		if(dbname.equals("ALL")){  
	    	success = SearchForManager.initAndCreateIndex();
	    }else{  
	    	//success = SearchForManager.createIndexBySite(dbname); 
	    }
	}else if(action.equals("delete")){
		if(dbname.equals("ALL")){
	    	success = SearchForManager.deleteIndexDir();
	    }else{
	    	//success = SearchForManager.deleteIndexBySite(dbname); 
	    }
	}
	//* 输出判断结果	
	if (success)
		out.println("1");//创建成功
	else
		out.println("0");//创建失败
%>