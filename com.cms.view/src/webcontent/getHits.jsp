<%@page import="com.cms.view.data.InfoDataUtil"%>
<%@page import="com.cms.view.filter.JspFilterHandl"%>
<%@page import="java.util.*"%>>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@page pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	int hits = 0;
	if(!JspFilterHandl.isTure(request) && !StringUtil.isBlank(id)){
		hits = InfoDataUtil.getHits(id);
	}
 %>
document.write("<%=hits %>");