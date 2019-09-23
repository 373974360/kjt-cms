<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String id = request.getParameter("id");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>模板管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
			<div id="queryform" class="nui-form" align="center">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="criteria/_entity" value="com.cms.siteconfig.templet.CmsTempletVer">
				<!-- 排序字段 -->
				<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="version">
				<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
				<input class="nui-hidden" name="templet/templetId" value="<%=id %>"/>
			</div>
		<div class="nui-panel" title="模板列表" iconCls="icon-add" style="width: 100%; height: 100%;" showToolbar="false" showFooter="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="templet" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.siteconfig.TempletService.queryTempletVer.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false" allowAlternating="true">
					<div property="columns">
						<div type="checkcolumn" width="50"></div>
						<div field="id" headerAlign="center" align="center" allowSort="true" width="50">ID</div>
						<div field="templetName" headerAlign="center" allowSort="true" width="auto">模板名称</div>
						<div field="version" headerAlign="center" align="center" allowSort="true" width="50">版本号</div>
						<div field="createTime" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="150">创建时间</div>
						<div field="action" headerAlign="center" align="center" allowSort="true" width="200">操作</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
			
			grid.on("drawcell", function (e) {
			    var field = e.field,
			        row = e.row;
			    if (field == "action") {
		      		e.cellHtml = "<a style='cursor:pointer;' href='javascript:templetView("+row.id+")'>查看</a>&nbsp;&nbsp;&nbsp;<a style='cursor:pointer;' href='javascript:recoveryTemplet("+row.id+")'>恢复</a>";
			    }
			});
			//编辑
			function templetView(id) {
				nui.open({
					url : "<%=request.getContextPath()%>/siteconfig/templet/TempletView.jsp",
					title : "编辑数据",
					width : '80%',
					height : '100%',
					onload : function() {
						var iframe = this.getIFrameEl();
						//直接从页面获取，不用去后台获取
						iframe.contentWindow.setData(id);
					},
					ondestroy : function(action) {
						if (action == "saveSuccess") {
							grid.reload();
						}
					}
				});
			}
			
			//删除
			function recoveryTemplet(id) {
				nui.confirm("确定要恢复该模板？","系统提示",
				function(action) {
					if (action == "ok") {
						var json = nui.encode({
							templet : {id:id}
						});
						grid.loading("正在恢复中,请稍等...");
						$.ajax({
							url : "com.cms.siteconfig.TempletService.recoveryTemplte.biz.ext",
							type : 'POST',
							data : json,
							cache : false,
							contentType : 'text/json',
							success : function(text) {
								var returnJson = nui.decode(text);
								if (returnJson.exception == null) {
									grid.reload();
									nui.alert("恢复成功","系统提示",function(action) {
									});
								} else {
									grid.unmask();
									nui.alert("恢复失败","系统提示");
								}
							}
						});
					}
				});
			}
			//当选择列时
			function selectionChanged() {
				var rows = grid.getSelecteds();
			}
		</script>
	</body>
</html>
