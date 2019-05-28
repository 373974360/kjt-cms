<%@page pageEncoding="UTF-8"%>
<%
	String model = request.getParameter("modelId");
	if(model.equals("article")){
%>
	<%@include file="/content/info/info_article_add.jsp" %>
<%
	}
	if(model.equals("doc")){
%>
	<%@include file="/content/info/info_doc_add.jsp" %>
<%
	}
	if(model.equals("download")){
%>
	<%@include file="/content/info/info_download_add.jsp" %>
<%
	}
	if(model.equals("expert")){
%>
	<%@include file="/content/info/info_expert_add.jsp" %>
<%
	}
	if(model.equals("leader")){
%>
	<%@include file="/content/info/info_leader_add.jsp" %>
<%
	}
	if(model.equals("link")){
%>
	<%@include file="/content/info/info_link_add.jsp" %>
<%
	}
	if(model.equals("pic")){
%>
	<%@include file="/content/info/info_pic_add.jsp" %>
<%
	}
	if(model.equals("video")){
%>
	<%@include file="/content/info/info_video_add.jsp" %>
<%
	}
 %>