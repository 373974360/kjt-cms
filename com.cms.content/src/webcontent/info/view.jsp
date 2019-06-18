<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%
	String info_id = request.getParameter("info_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>内容预览</title>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/content/layui/css/layui.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
<style type="text/css">
#infoLogs li {
	float: left;
	padding: 5px 10px;
	border: 1px solid #ccc
}
#viewLeft{width:20%;height:100%;float:left;}
#viewRight{width:79%;float:right;border-left:1px solid #ccc;}
</style>
</head>
<body>
	<div id="viewLeft">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
			<legend>信息发布时间线</legend>
		</fieldset>
		<ul class="layui-timeline"></ul>
	</div>
	<div id="viewRight">
		<iframe src="<%=request.getContextPath()%>/content/info/view_content.jsp?info_id=<%=info_id%>" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	<script type="text/javascript">
		var _ul = $(".layui-timeline");
		$("#viewRight").css("height",document.documentElement.clientHeight);
		loadInfoLogs();
		function loadInfoLogs() {
			var typeCode = ["通过","驳回","发布"];
			var json = nui.encode({params : {infoId :<%=info_id%>}});
			$.ajax({
				url : "com.cms.content.ContentService.queryWfInfoLogs.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					if (text.data.length > 0) {
						for (var j = 0; j < text.data.length; j++) {
							var type;
							if(text.data[j].wfOptType)
							_ul.append('<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis"></i>'
									+ '<div class="layui-timeline-content layui-text">'
									+ '<h3 class="layui-timeline-title">'+text.data[j].wfOptTime+'</h3>'
									+ '<p>用户：' + text.data[j].wfOptUser+'</p>'
									+ '<p>操作：' + typeCode[text.data[j].wfOptType-1]+'</p>'
									+ '<p>意见：' + text.data[j].wfOptDesc+'</p>'
									+ '</div></li>');
						}
					}
				}
			});
		}
	</script>
</body>
</html>