<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>索引管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="索引列表" iconCls="icon-add" style="width: 100%; height: 100%;" showToolbar="false" showFooter="false">
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 100%;">
							<a class="nui-button" iconCls="icon-add" onclick="createAll()">生成全部索引 </a>
							<a class="nui-button" iconCls="icon-remove" onclick="deleteAll()">删除全部索引</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="data" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.siteconfig.SearchService.querySiteList.biz.ext" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
					<div property="columns">
						<div type="checkcolumn" width="50"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
						<div field="chName" width="auto" headerAlign="center" allowSort="true">站点名称</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
			grid.load();
			
			var nameDb = '';
			function createAll() {
				nui.confirm("操作会导致前台搜索功能暂不可用，<br/>确定要继续吗？","系统提示",
				function(action) {
					if (action == "ok") {
						dbname = "ALL";
						grid.loading("正在生成索引中,请稍等...");
						var url = "ajaxUtil.jsp?action=create&dbname="+dbname;
						$.get(url,null,callBack);
					}
				});
			}
			function callBack(data) {
				if ($.trim(data) == '1') {
					nui.alert("创建索引成功","系统提示",function(action) {
					});
				} else {
					nui.alert("创建索引失败","系统提示");
				}
				grid.reload();
				nameDb = "";
			}
			function deleteAll() {
				nui.confirm("操作会导致前台搜索功能暂不可用，<br/>确定要继续吗？","系统提示",
				function(action) {
					if (action == "ok") {
						dbname = "ALL";
						grid.loading("正在生成索引中,请稍等...");
						var url = "ajaxUtil.jsp?action=delete&dbname="+dbname;
						$.get(url,null,deleteCallBack);
					}
				});
			}
			function deleteCallBack(data) {
				if ($.trim(data) == '1') {
					nui.alert("删除索引成功","系统提示",function(action) {
					});
				} else {
					nui.alert("删除索引失败","系统提示");
				}
				grid.reload();
				nameDb = "";
			}
		</script>
	</body>
</html>
