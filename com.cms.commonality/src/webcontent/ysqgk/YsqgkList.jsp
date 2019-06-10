<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>依申请公开</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="依申请公开查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<!-- 排序字段 -->
				<input name="params/userOrgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>"> 
				<input name="params/userId" class="nui-hidden" value="<%=userObject.getUserId() %>"> 
				<table id="table1" class="table" style="height: 100%;float:left;">
					<tr>
						<td class="form_label">申请编码:</td>
						<td colspan="1">
							<input name="params/ysqCode" class="nui-textbox" />							
						</td>						
						<td class="nui-form-label">回复：</td>
		                <td colspan="1">    
		                    <input name="params/isReply" width="40" class="nui-dictcombobox" dictTypeId="CMS_YESORNO" showNullItem="true"/>
		                </td>
						<td class="nui-form-label">公开：</td>
		                <td colspan="1">    
		                    <input name="params/isOpen" width="40" class="nui-dictcombobox" dictTypeId="CMS_YESORNO" showNullItem="true"/>
		                </td>
		                <td class="nui-form-label">发布：</td>
		                <td colspan="1">    
		                    <input name="params/isPublish" width="40" class="nui-dictcombobox" dictTypeId="CMS_YESORNO" showNullItem="true"/>
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
		<div class="nui-panel" title="依申请公开列表" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%;">
					<tr>
						<td style="width: 100%;">
							<a class="nui-button" iconCls="icon-add" onclick="add()">录入 </a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
							<a class="nui-button" iconCls="icon-reload" onclick="reload()">刷新</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="ysqgk" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.commonality.YsqgkService.queryYsqgkByNamedSQL.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
					<div property="columns">
						<div type="checkcolumn" align="center" width="10"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
						<div field="ysqType" headerAlign="center" allowSort="true" visible="false" >申请人类型</div>
						<div field="ysqCode" headerAlign="center" allowSort="true" >申请编码</div>							
						<div field="createDtime" headerAlign="center" width="60" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">提交时间</div>		
						<div field="replyDtime" headerAlign="center" width="60" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">回复时间</div>
						<div field="replyContent" headerAlign="center" allowSort="true" visible="false">回复内容</div>
						<div field="isReply" width="30" align="center" headerAlign="center" allowSort="true" renderer="onYesOrNoRenderer">回复</div>
						<div field="content" headerAlign="center" allowSort="true" visible="false">内容描述</div>
						<div field="isPublish" width="30" align="center" headerAlign="center" allowSort="true" renderer="onYesOrNoRenderer">发布</div>
						<div field="isOpen" width="30" align="center" headerAlign="center" allowSort="true" renderer="onYesOrNoRenderer">公开</div>
						<div name="action" width="40" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">申请详情</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
	
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
			//判断是否
			function onYesOrNoRenderer(e){
				return nui.getDictText('CMS_YESORNO',e.value);
			}			
	
			//新增
			function add() {
				nui.open({
					url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkAdd.jsp",
					title : "新增记录",
					width : '80%',
					height : '100%',
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
						url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkUpdate.jsp",
						title : "编辑数据",
						width : '80%',
						height : '100%',
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
								ysqgks : rows
							});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url : "com.cms.commonality.YsqgkService.deleteYsqgks.biz.ext",
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
	
			//重新刷新此页面
			function refreshIt() {
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
			
			//刷新
			function reload(){
				grid.reload();
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
			//单击详情按钮时发生
			function detailsRow(row_uid) {
				var row = grid.getRowByUID(row_uid);
				if (row){
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkDetail.jsp?ysqgkId="+row.id,
						title : "依申请公开详情&处理",
						width : '80%',
						height : '100%',
						onload : function() {
							var iframe = this.getIFrameEl();
							var data = row;
							//直接从页面获取，不用去后台获取
							iframe.contentWindow.setDataParams(data);		
						},
						ondestroy : function(action) {
							if (action == "saveSuccess") {
								grid.reload();
							}
						}
					});		
				}
							
			}			
			function onActionRenderer(e) {	            
	            var record = e.record;
	            var uid = record._uid;

	            var s = '<a class="Edit_Button" href="javascript:detailsRow(\'' + uid + '\')">详情&处理</a>';
	            return s;
	        }
	        
	        
		</script>
	</body>
</html>
