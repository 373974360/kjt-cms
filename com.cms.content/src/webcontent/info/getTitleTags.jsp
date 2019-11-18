<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@page import="com.cms.content.Sample,java.net.URLDecoder"%>
<%
	String title = request.getParameter("title");
	if(!StringUtil.isBlank(title)){
		String infoTitle = URLDecoder.decode(title,"UTF-8");
		out.println(Sample.getTitleTags(infoTitle));
	}else{
		out.println("null");
	}
%>