<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>模型管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="模型查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="criteria/_entity" value="com.cms.siteconfig.model.CmsModel">
				<!-- 排序字段 -->
				<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="id">
				<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
				<table id="table1" class="table" style="height: 100%;float:left;">
					<tr>
						<td class="form_label">模型名称:</td>
						<td colspan="1">
							<input class="nui-textbox" name="criteria/_expr[2]/modelName" />
							<input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
							<input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
						</td>
						<td>
							<div property="footer" align="center">
								<a class="nui-button" onclick="search()">查询 </a>
								<a class="nui-button" onclick="reset()">重置 </a>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="nui-panel" title="模型列表" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="model" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.siteconfig.ModelService.queryModel.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
					<div property="columns">
						<div type="checkcolumn" width="10"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">模型ID</div>
						<div field="modelName" headerAlign="center" allowSort="true">模型名称</div>
						<div field="modelEnName" headerAlign="center" allowSort="true">代码</div>
						<div field="modelType" headerAlign="center" allowSort="true">模型类型</div>
						<div field="modelStatus" headerAlign="center" allowSort="true">模型状态</div>
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
			        value = e.value;
			    if (field == "modelType") {
			        if (value == 1){
			        	e.cellHtml = "系统";
			        }else{
			        	e.cellHtml = "自定义";
			        }
			    }
			    if (field == "modelStatus") {
			        if (value == 1){
			        	e.cellHtml = "启用";
			        }else{
			        	e.cellHtml = "停用";
			        }
			    }
			});
			
			//重新刷新页面
			function refresh() {
				var form = new nui.Form("#queryform");
				var json = form.getData(false, false);
				grid.load(json);//grid查询
				nui.get("update").enable();
			}
	
			//查询
			function search() {
				var form = new nui.Form("#queryform");
				var json = form.getData(false, false);
				grid.load(json);//grid查询
			}
	
			//重置查询条件
			function reset() {
				var form = new nui.Form("#queryform");//将普通form转为nui的form
				form.reset();
			}
	
			//enter键触发查询
			function onKeyEnter(e) {
				search();
			}
		</script>
	</body>
</html>
