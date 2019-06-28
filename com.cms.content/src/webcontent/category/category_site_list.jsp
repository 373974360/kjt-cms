<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>站点管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div id="queryform" class="nui-form" align="center">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity" value="com.cms.content.category.CmsInfoCategory">
			<input class="nui-hidden" name="criteria/_expr[1]/parentId" value="0"/>
			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
		</div>
		<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<a class="nui-button" iconCls="icon-add" onclick="add()">增加 </a>
						<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
						<a id="remove" class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="datagrid1" dataField="category" class="nui-datagrid" style="width: 100%; height: 100%;"
				url="com.cms.content.CategoryService.queryCategory.biz.ext"
				pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div field="id" headerAlign="center" align="center" allowSort="true" width="20">ID</div>
					<div field="chName" headerAlign="center" allowSort="true">站点名称</div>
					<div field="enName" headerAlign="center" allowSort="true">英文名称</div>
					<div field="siteDomin" headerAlign="center" allowSort="true">站点域名</div>
					<div field="remark" headerAlign="center" allowSort="true">备注</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
	
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
	
			//新增
			function add() {
				nui.open({
					url : "<%=request.getContextPath()%>/content/category/category_site_add.jsp",
					title : "新增记录",
					width : 700,
					height : 330,
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
						url : "<%=request.getContextPath()%>/content/category/category_site_update.jsp",
						title : "编辑数据",
						width : 700,
						height : 330,
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
					var bool = isExist(rows[0].id);
					if(bool>0){
						nui.alert("请先删除子栏目","系统提示",function(action) {
						});
						return;
					}
					nui.confirm("确定删除选中记录？","系统提示", function(action) {
						if (action == "ok") {
							var json = nui.encode({
								categorys : rows
							});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url : "com.cms.content.CategoryService.deleteCategorys.biz.ext",
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
			
			
	
			//判断是否有子栏目
		    function isExist(value){
		    	var bool;
		    	$.ajax({
			        url:"com.cms.content.CategoryService.isExist.biz.ext",
			        type:'POST',
			        data:'parentId='+value,
			        cache:false,
			        async:false,
			        dataType:'json',
			        success:function(text){
			        console.log(text);
			       		bool = text.data>0;
			        }
		      });
		      return bool;
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
					nui.get("remove").disable();
				} else {
					nui.get("update").enable();
					nui.get("remove").enable();
				}
			}
		</script>
	</body>
</html>
