<%@page import="com.cms.view.data.InfoDataUtil"%>
<%@page pageEncoding="UTF-8"%>
<%
	int hits = InfoDataUtil.getHits(request.getParameter("id"));
 %>
document.write("<%=hits %>");