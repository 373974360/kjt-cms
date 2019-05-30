<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String searchKey = request.getParameter("searchKey");
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>内容管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
		<link href="<%=request.getContextPath()%>/content/icons/icons.css" rel="stylesheet" type="text/css"/>
	</head>
	<body style="width: 98%; height: 95%;">
		<div id="queryform" class="nui-form" align="center">
			<input class="nui-hidden" name="params/userId" value="<%=userObject.getUserId() %>"/>
		</div>
		<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<a id="examine" class="nui-button" iconCls="icon-filter" onclick="setInfoStatus(4,'撤稿')">审核</a>
						<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
						<a id="remove" class="nui-button" iconCls="icon-remove" onclick="setInfoStatus(5,'删除')">删除</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="datagrid1" dataField="info" class="nui-datagrid" style="width: 100%; height: 100%;"
				url="com.cms.content.WellComeService.myAgency.biz.ext"
				pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div field="id" headerAlign="center" allowSort="true" visible="false">内容ID</div>
					<div field="title" width="300" headerAlign="left" allowSort="true">标题</div>
					<div field="isTop" width="40" headerAlign="center" align="center" allowSort="true">置顶</div>
					<div field="editor" width="70" headerAlign="center" align="center" allowSort="true">编辑</div>
					<div field="inputDtime" width="80" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">录入时间</div>
					<div field="releasedDtime" width="80" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">发布时间</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
         	grid.load();
         	
         	grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value,
			        row = e.row;
			    if (field == "isTop") {
			        if (value == 1){
			        	e.cellHtml = "是";
			        }else{
			        	e.cellHtml = "否";
			        }
			    }
			    if (field == "title") {
		      		e.cellHtml = "<a class='icon-"+row.modelId+"' style='padding-left:20px;cursor:pointer;' href='<%=request.getContextPath()%>/content/info/view.jsp?info_id="+row.id+"' target='_blank'>"+row.infoTitle+"</a>";
			    }
			});
			setAuthBtn();
         	function setAuthBtn(){
         		var btn = ["examine","update","remove"];
         		var json = nui.encode({params:{userId:<%=userObject.getUserId() %>}});
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
									if(btn[i] == text.data[j].RESID.replace("info_","")){
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
         	//修改信息状态
			function setInfoStatus(infoStatus,msg) {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					for(var i=0;i<rows.length;i++){
						rows[i].infoStatus = infoStatus;
					}
					var json = nui.encode({
						infos : rows
					});
					nui.confirm("确定"+msg+"选中记录？","系统提示",function(action) {
						if (action == "ok") {
							grid.loading("正在"+msg+"中,请稍等...");
							$.ajax({
								url : "com.cms.content.ContentService.setInfoStatus.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert(msg+"成功","系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert(msg+"成功","系统提示");
									}
								}
							});
						}
					});
				} else {
					nui.alert("请选中一条记录！");
				}
			}
         	//编辑
			function edit() {
				var row = grid.getSelected();
				if (row) {
					nui.open({
						url : "<%=request.getContextPath()%>/content/info/info_"+row.modelId+"_edit.jsp?catId="+row.catId,
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
