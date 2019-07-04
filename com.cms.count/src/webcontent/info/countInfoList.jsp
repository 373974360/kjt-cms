<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String infoStatus = request.getParameter("infoStatus");
	String inputUser = request.getParameter("inputUser");
	String catId = request.getParameter("catId");;
	String orgId = request.getParameter("orgId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<title>Title</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
	<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body>
		<div class="nui-fit">
			<div id="datagrid1" dataField="data" class="nui-datagrid" style="width: 100%; height: 100%;" ajaxData="setRoleId"
				url="com.cms.count.vo.InfoCountService.queryCountInfoList.biz.ext" idField="id" pageSize="20" showPageInfo="true" 
				multiSelect="true" allowSortColumn="false" allowCellEdit="true" allowCellSelect="true" allowAlternating="true">
				<div property="columns">
					<div type="checkcolumn" width="40"></div>
					<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
					<div field="infoTitle" width="auto" headerAlign="center" allowSort="true">标题</div>
					<div field="CHNAME" width="100" headerAlign="center" align="center" allowSort="true">栏目名称</div>
					<div field="editor" width="100" headerAlign="center" align="center" allowSort="true">编辑</div>
					<div field="orgName" width="100" headerAlign="center" align="center" allowSort="true">单位</div>
					<div field="source" width="100" headerAlign="center" align="center" allowSort="true">来源</div>
					<div field="releasedDtime" width="100" headerAlign="center" align="center" allowSort="true">发布日期</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
	   		nui.parse();
	   		var grid = nui.get("datagrid1");
	   		grid.load();
		    function setRoleId(){
				return {"params/catId":"<%=catId %>","params/startTime":"<%=startTime %>","params/endTime":"<%=endTime %>","params/infoStatus":"<%=infoStatus %>","params/inputUser":"<%=inputUser %>","params/orgId":"<%=orgId %>"};
			}
		</script>
	</body>
</html>