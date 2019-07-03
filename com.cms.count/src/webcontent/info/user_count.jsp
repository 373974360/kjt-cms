<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String catId = request.getParameter("catId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>信息统计</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div id="datagrid1" dataField="data" ajaxData="setRoleId" class="nui-datagrid" style="width: 100%; height: 100%;" showPager = "false"
			url="com.cms.count.vo.InfoCountService.infoCountByUser.biz.ext" multiSelect="true" allowSortColumn="false" allowAlternating="true">
			<div property="columns">
				<div type="checkcolumn" width="40"></div>
				<div field="userName" width="auto" headerAlign="center" allowSort="true">姓名</div>
				<div field="count" width="100" headerAlign="center" allowSort="true">信息总数</div>
				<div field="publisCount" width="100" headerAlign="center" allowSort="true">已发信息</div>
				<div field="proportion" width="100" headerAlign="center" allowSort="true">发稿率</div>
			</div>
		</div>
		<script type="text/javascript">
	   		nui.parse();
	   		var grid = nui.get("datagrid1");
	   		grid.load();
		    function setRoleId(){
				return {"catId":"<%=catId %>","startTime":"<%=startTime %>","endTime":"<%=endTime %>"};
			}
		</script>
	</body>
</html>
