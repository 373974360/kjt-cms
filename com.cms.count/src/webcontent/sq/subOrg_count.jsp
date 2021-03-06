<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>来信统计</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 100%; height: 99%;">
		<div class="nui-fit">
			<div id="datagrid1" dataField="data" ajaxData="setRoleId" class="nui-datagrid" style="width: 100%; height: 100%;"
				url="com.cms.count.vo.sqCountService.sqCountByOrg.biz.ext" multiSelect="true" allowSortColumn="false" showPager="false" allowAlternating="true">
				<div property="columns">
					<div type="indexcolumn" width="10" ></div>				
					<div field="orgName" headerAlign="center" align="center" allowSort="true">处理部门</div>
					<div field="count" width="100" headerAlign="center" align="center"allowSort="true">总件数</div>
					<div field="inHand" width="100" headerAlign="center" align="center" allowSort="true">处理中</div>
					<div field="replied" width="100" headerAlign="center" align="center" allowSort="true">已办结</div>
					<div field="proportion" width="100" headerAlign="center" align="center" allowSort="true">办结率</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
	   		nui.parse();
	   		var grid = nui.get("datagrid1");
	   		grid.load();
		    function setRoleId(){
				return {"startTime":"<%=startTime %>","endTime":"<%=endTime %>"};
			}
		</script>
	</body>
</html>
