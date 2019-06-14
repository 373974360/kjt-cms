<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>调查管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="问卷查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="criteria/_entity" value="com.cms.commonality.survey.CmsSurvey">
				<!-- 排序字段 -->
				<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="createTime">
				<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
				<table id="table1" class="table" style="height: 100%;float:left;">
					<tr>
						<td class="form_label">问卷标题:</td>
						<td colspan="1">
							<input class="nui-textbox" name="criteria/_expr[2]/title" />
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
		<div class="nui-panel" title="问卷列表" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 100%;">
							<a class="nui-button" iconCls="icon-add" onclick="add()">增加 </a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
	            			<span class="separator"></span>
							<a id="update" class="nui-button" iconCls="icon-ok" onclick="setPublish(2,'发布')">发布 </a>
							<a class="nui-button" iconCls="icon-redo" onclick="setPublish(1,'撤销')">撤销发布</a>
	            			<span class="separator"></span>
							<a class="nui-button" iconCls="icon-collapse" onclick="subConfig()">题目设置</a>
							<a class="nui-button" iconCls="icon-sort" onclick="surveyCount()">数据统计</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="survey" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.commonality.SurveyService.querySurvey.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
					<div property="columns">
						<div type="checkcolumn" width="40"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
						<div field="title" width="auto" headerAlign="center" allowSort="true">标题</div>
						<div field="startTime" width="170" headerAlign="center" align="center" allowSort="true">开始时间</div>
						<div field="endTime" width="170" headerAlign="center" align="center" allowSort="true">截止时间</div>
						<div field="isPublish" width="100" headerAlign="center" align="center" allowSort="true">发布状态</div>
						<div field="isEnd" width="100" headerAlign="center" align="center" allowSort="true">投票状态</div>
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
			    if (field == "isPublish") {
			        if (value == 1){
			        	e.cellHtml = "未发布";
			        }else{
			        	e.cellHtml = "已发布";
			        }
			    }
			    if (field == "isEnd") {
			        if (value == 1){
			        	e.cellHtml = "进行中";
			        }else{
			        	e.cellHtml = "已截止";
			        }
			    }
			});
	
			//新增
			function add() {
				nui.open({
					url : "<%=request.getContextPath()%>/commonality/survey/SurveyAdd.jsp",
					title : "新增记录",
					width : "70%",
					height : "70%",
					onload : function() {
					},
					ondestroy : function(action) {//弹出页面关闭前
						if (action == "saveSuccess") {
							grid.reload();
						}
					}
				});
			}
	
			//编辑
			function edit() {
				var row = grid.getSelected();
				if (row) {
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/survey/SurveyUpdate.jsp",
						title : "编辑数据",
						width : "70%",
						height : "70%",
						onload : function() {
							var iframe = this.getIFrameEl();
							var data = row;
							//直接从页面获取，不用去后台获取
							iframe.contentWindow.setData(data);
						},
						ondestroy : function(action) {
							if (action == "saveSuccess") {
								grid.reload();
							}
						}
					});
				} else {
					nui.alert("请选中一条记录", "提示");
				}
			}
	
			//删除
			function remove() {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					nui.confirm("确定删除选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							var json = nui.encode({
								surveys : rows
							});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url : "com.cms.commonality.SurveyService.deleteSurveys.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert("删除成功","系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert("删除失败","系统提示");
									}
								}
							});
						}
					});
				} else {
					nui.alert("请选中一条记录！");
				}
			}
			
			function setPublish(status,msg) {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					nui.confirm("确定"+msg+"选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							for(var i=0;i<rows.length;i++){
								rows[i].isPublish = status;
							}
							var json = nui.encode({
								surveys : rows
							});
							grid.loading("正在"+msg+"中,请稍等...");
							$.ajax({
								url : "com.cms.commonality.SurveyService.setPublish.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert(""+msg+"成功","系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert(""+msg+"失败","系统提示");
									}
								}
							});
						}
					});
				} else {
					nui.alert("请选中一条记录！");
				}
			}
			
			//题目设置
			function subConfig() {
				var row = grid.getSelected();
				if (row) {
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/survey/SubList.jsp?surveyId="+row.id,
						title : "题目设置",
						width : "80%",
						height : "100%",
						onload : function() {
						},
						ondestroy : function(action) {
							if (action == "saveSuccess") {
								grid.reload();
							}
						}
					});
				} else {
					nui.alert("请选中一条记录", "提示");
				}
			}
			
			//数据统计
			function surveyCount() {
				var row = grid.getSelected();
				if (row) {
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/survey/SurveyCount.jsp?surveyId="+row.id,
						title : "数据统计",
						width : "80%",
						height : "100%",
						onload : function() {
						},
						ondestroy : function(action) {
						}
					});
				} else {
					nui.alert("请选中一条记录", "提示");
				}
			}
	
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
	
			//当选择列时
			function selectionChanged() {
				var rows = grid.getSelecteds();
				if (rows.length > 1) {
					nui.get("update").disable();
				} else {
					nui.get("update").enable();
				}
			}
		</script>
	</body>
</html>
