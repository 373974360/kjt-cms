<%@page import="com.cms.view.data.InfoDataUtil"%>
<%@page import="java.util.*"%>
<%@page pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	int hits = 0;
	try{
		if(id!=null){
			int i = Integer.parseInt(id);
		}
	}catch(Exception e){
		out.println("<script>");
		out.println("top.location.href='/'");
		out.println("</script>");
		return;
	}
	hits = InfoDataUtil.getHits(request.getParameter("id"));
 %>
document.write("<%=hits %>");