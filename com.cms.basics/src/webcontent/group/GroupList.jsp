<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>作者管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="用户组查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="criteria/_entity" value="com.cms.basics.group.CmsUserGroup">
				<!-- 排序字段 -->
				<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="groupName">
				<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
				<table id="table1" class="table" style="height: 100%;float:left;">
					<tr>
						<td class="form_label">用户组名:</td>
						<td colspan="1">
							<input class="nui-textbox" name="criteria/_expr[2]/groupName" onblur="this.value=this.value.replace(/^\s+|\s+$/g,'')"/>
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
		<div class="nui-panel" title="用户组列表" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 100%;">
							<a class="nui-button" iconCls="icon-add" onclick="add()">增加 </a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
			            	<span class="separator"></span>
						    <a id="categoryAuth" class="nui-button" onclick="authCategory" iconCls="icon-expand">关联栏目</a>
						    <a id="dataAuth" class="nui-button" onclick="authRole" iconCls="icon-node">关联角色</a>
						    <a id="dataAuth" class="nui-button" onclick="authUser" iconCls="icon-node">关联用户</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="group" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.basics.GroupService.queryGroup.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false" allowAlternating="true">
					<div property="columns">
						<div type="checkcolumn" width="10"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
						<div field="groupName" headerAlign="center" allowSort="true">用户组名称</div>
						<div field="infoData" headerAlign="center" allowSort="true">新闻读取权限</div>
						<div field="sqData" headerAlign="center" allowSort="true">来信读取权限</div>
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
			    if (field == "infoData") {
			    	if(row.infoData == 1){
			    		e.cellHtml = "本人发布";
			    	}
			    	if(row.infoData == 2){
			    		e.cellHtml = "本部门发布";
			    	}
			    	if(row.infoData == 3){
			    		e.cellHtml = "全部";
			    	}
			    }
			    if (field == "sqData") {
			    	if(row.sqData == 1){
			    		e.cellHtml = "提交本部门的";
			    	}
			    	if(row.sqData == 2){
			    		e.cellHtml = "全部";
			    	}
			    }
			});
			function authUser(){
		       var row = grid.getSelected();
		       if(row!=null){
			       nui.open({
			          url:"<%=request.getContextPath() %>/basics/group/authUser.jsp?groupId="+row.id,
			          title:'关联用户',
			          width:650,
			          height:500,
			          onload:function(){
			          },
			          ondestroy:function(){
			          }
			       });
		       }else{
		           nui.alert("请选中一条记录！");
		       }
			}
			function authRole(){
		       var row = grid.getSelected();
		       if(row!=null){
			       nui.open({
			          url:"<%=request.getContextPath() %>/basics/group/authRole.jsp?groupId="+row.id,
			          title:'关联角色',
			          width:650,
			          height:500,
			          onload:function(){
			          },
			          ondestroy:function(){
			          }
			       });
		       }else{
		           nui.alert("请选中一条记录！");
		       }
			}
			function authCategory(){
		       var row = grid.getSelected();
		       if(row!=null){
			       nui.open({
			          url:"<%=request.getContextPath() %>/content/category/auth_group_category.jsp?groupId="+row.id,
			          title:'站点栏目授权',
			          width:650,
			          height:500,
			          onload:function(){
			          },
			          ondestroy:function(){
			          }
			       });
		       }else{
		           nui.alert("请选中一条记录！");
		       }
		    }
			//新增
			function add() {
				nui.open({
					url : "<%=request.getContextPath()%>/basics/group/GroupAdd.jsp",
					title : "新增记录",
					width : 500,
					height : 230,
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
						url : "<%=request.getContextPath()%>/basics/group/GroupUpdate.jsp",
						title : "编辑数据",
						width : 500,
						height : 230,
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
								groups : rows
							});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url : "com.cms.basics.GroupService.deleteGroups.biz.ext",
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
