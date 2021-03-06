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
							<input name="params/ysqCode" width="160" class="nui-textbox" onblur="this.value=this.value.replace(/^\s+|\s+$/g,'')"/>							
						</td>						
						<td class="nui-form-label">回复：</td>
		                <td colspan="1"> 
		                	<input name="params/isReply" width="40" class="nui-combobox nui-form-input" showNullItem="true"  
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>   		                  
		                </td>
						<td class="nui-form-label">公开：</td>
		                <td colspan="1">
		                	<input name="params/isOpen" width="40" class="nui-combobox nui-form-input" showNullItem="true" 
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>    
		                </td>
		                <td class="nui-form-label">发布：</td>
		                <td colspan="1">
		                	<input name="params/isPublish" width="40" class="nui-combobox nui-form-input" showNullItem="true" 
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>    
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
							<a id="add" class="nui-button" iconCls="icon-add" onclick="add()">录入</a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑</a>
							<a id="remove" class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
							<span class="separator"></span>
							<a id="isPublish" class="nui-button" iconCls="icon-ok" onclick="isPublishOrNot(1,'发布')">发布</a>
							<a id="noPublish" class="nui-button" iconCls="icon-redo" onclick="isPublishOrNot(2,'撤销发布')">撤销发布</a>
							<span class="separator"></span>
							<a id="isOpen" class="nui-button" iconCls="icon-ok" onclick="isOpenOrNot(1,'公开')">公开</a>
							<a id="noOpen" class="nui-button" iconCls="icon-redo" onclick="isOpenOrNot(2,'撤销公开')">撤销公开</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="ysqgk" class="nui-datagrid" style="width: 100%; height: 100%;"
					url="com.cms.commonality.YsqgkService.queryYsqgkByNamedSQL.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false" allowAlternating="true">
					<div property="columns">
						<div type="checkcolumn" align="center" width="10"></div>
						<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
						<div field="ysqCode" headerAlign="center" align="center" allowSort="true" >申请编码</div>							
						<div field="ysqType" headerAlign="center" width="40" align="center" allowSort="true" >申请类型</div>
						<div field="name" headerAlign="center" width="40" align="center" allowSort="true" >申请人员</div>
						<div field="orgCode" headerAlign="center" width="40" align="center" allowSort="true" >组织机构代码</div>
						<div field="createDtime" headerAlign="center" width="60" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">申请时间</div>		
						<div field="replyDtime" headerAlign="center" width="60" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">回复时间</div>
						<div field="replyContent" headerAlign="center" allowSort="true" visible="false">回复内容</div>
						<div field="isReply" width="30" align="center" headerAlign="center" allowSort="true">回复</div>
						<div field="content" headerAlign="center" allowSort="true" visible="false">内容描述</div>
						<div field="isPublish" width="30" align="center" headerAlign="center" allowSort="true">发布</div>
						<div field="isOpen" width="30" align="center" headerAlign="center" allowSort="true">公开</div>
						<div name="action" width="40" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">具体内容</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
	
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
			grid.load(formData);
			grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value;
			    if (field == "isReply") {
			        if (value == 1){
			        	e.cellHtml = "是";
			        }else{
			        	e.cellHtml = "否";
			        }
			    }
			    if (field == "isPublish") {
			        if (value == 1){
			        	e.cellHtml = "是";
			        }else{
			        	e.cellHtml = "否";
			        }
			    }
			    if (field == "isOpen") {
			        if (value == 1){
			        	e.cellHtml = "是";
			        }else{
			        	e.cellHtml = "否";
			        }
			    }
			    if (field == "ysqType") {
			        if (value == 1){
			        	e.cellHtml = "公民";
			        }else{
			        	e.cellHtml = "法人或其他组织";
			        }
			    }
			    if (field == "name") {
			        if (value == null){
			        	e.cellHtml = "-";
			        }
			    }
			    if (field == "orgCode") {
			        if (value == null){
			        	e.cellHtml = "-";
			        }
			    }
			});
					
	
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
			//发布or撤销发布
			function isPublishOrNot(isPublish,msg){
				var rows = grid.getSelecteds();
				for(var i=0;i<rows.length;i++){
					rows[i].isPublish = isPublish;
				}
				if (rows.length > 0) {
					nui.confirm("确定"+msg+"选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							var json = nui.encode({
								ysqgks : rows
							});
							grid.loading("正在"+msg+"中,请稍等...");
							$.ajax({
								url : "com.cms.commonality.YsqgkService.setYsqgkIsStateOrNot.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert("申请已"+msg,"系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert("申请已"+msg,"系统提示");
									}
								}
							});
						}
					});
				} else {
					nui.alert("请选中一条或多条记录！");
				}
			}
			//公开or撤销公开
			function isOpenOrNot(isOpen,msg){
				var rows = grid.getSelecteds();
				for(var i=0;i<rows.length;i++){
					rows[i].isOpen = isOpen;
				}
				if (rows.length > 0) {
					nui.confirm("确定"+msg+"选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							var json = nui.encode({
								ysqgks : rows
							});
							grid.loading("正在"+msg+"中,请稍等...");
							$.ajax({
								url : "com.cms.commonality.YsqgkService.setYsqgkIsStateOrNot.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert("申请已"+msg,"系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert("申请已"+msg,"系统提示");
									}
								}
							});
						}
					});
				} else {
					nui.alert("请选中一条或多条记录！");
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
					nui.get("isPublish").enable();
					nui.get("noPublish").enable();
					nui.get("isOpen").enable();
					nui.get("noOpen").enable();			
				}
				//发布和公开按钮依据选中记录的状态显示
				for(var i=0;i<rows.length;i++){
					if (rows[i].isPublish =="2"||rows[i].isPublish==null){
						nui.get("isPublish").enable();
						nui.get("noPublish").disable();							
					}else{
						nui.get("isPublish").disable();
						nui.get("noPublish").enable();	
					}
					if(rows[i].isOpen =="2"|| rows[i].isOpen==null){
						nui.get("isOpen").enable();
						nui.get("noOpen").disable();						
					}else{
						nui.get("isOpen").disable();
						nui.get("noOpen").enable();					
					}									
				}
				
			}
			
			//单击详情按钮时发生
			function detailsRow(row_uid) {
				var row = grid.getRowByUID(row_uid);
				if (row){
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkDetail.jsp?ysqgkId="+row.id +"&isPublish=" + row.isPublish +"&isOpen=" + row.isOpen +"&isReply=" + row.isReply,
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
	        
	        //依据用户权限设置按钮操作
			setAuthBtn();
         	function setAuthBtn(){
         		var btn = ["add","update","remove","isPublish","noPublish","isOpen","noOpen"];
         		var json = nui.encode({params:{userId:<%=userObject.getUserId() %>,funId:1181}});
				$.ajax({
					url:"com.cms.content.ContentService.queryBtnAuth.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						for(var i=0;i<btn.length;i++){
							if(text.data.length>0){
								var b = false;
								for(var j=0;j<text.data.length;j++){
									if(btn[i] == text.data[j].RESID.replace("sq_","")){
										b = true;
									}
								}
								if(!b){
									$("#"+btn[i]).remove();
								}
							}else{
								$("#"+btn[i]).remove();
							}
						}
			         }
	          	});
         	}
	        
		</script>
	</body>
</html>
