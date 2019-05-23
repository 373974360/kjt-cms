<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("nodeId");
	String searchKey = request.getParameter("searchKey");
	String infoStatus = request.getParameter("infoStatus");
	String infoType = request.getParameter("infoType");
	boolean isAdd = Boolean.parseBoolean(request.getParameter("isAdd"));
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
			<!-- 查询字段 -->
			<input class="nui-hidden" name="params/catId" value="<%=catId %>"/>
			<input class="nui-hidden" name="params/infoStatus" value="<%=infoStatus %>"/>
			<input class="nui-hidden" name="params/infoType" value="<%=infoType %>"/>
			<input class="nui-hidden" name="params/searchKey" value="<%=searchKey %>"/>
		</div>
		<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<%
							if(isAdd && infoStatus.equals("3")){
						%>
							<a class="nui-menubutton" menu="#popupMenu" >新增...</a>
						    <ul id="popupMenu" class="nui-menu" style="display:none;">
				                <li id="article" iconCls="icon-article" onclick="add('article')" style="display:none;">文章</li>
				                <li id="video" iconCls="icon-video" onclick="add('video')" style="display:none;">视频</li>
				                <li id="pic" iconCls="icon-pic" onclick="add('pic')" style="display:none;">组图</li>
				                <li id="link" iconCls="icon-link" onclick="add('link')" style="display:none;">连接</li>
				                <li id="leader" iconCls="icon-leader" onclick="add('leader')" style="display:none;">领导</li>
				                <li id="doc" iconCls="icon-doc" onclick="add('doc')" style="display:none;">文件</li>
				                <li id="expert" iconCls="icon-expert" onclick="add('expert')" style="display:none;">专家</li>
				                <li id="download" iconCls="icon-download" onclick="add('download')" style="display:none;">下载</li>
						    </ul>
						<%
							}
						%>
						
						<%
							if(infoStatus.equals("3")){
						%>
							<a id="revoke" class="nui-button" iconCls="icon-redo" onclick="setInfoStatus(4,'撤稿')">撤稿 </a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a id="remove" class="nui-button" iconCls="icon-remove" onclick="setInfoStatus(5,'删除')">删除</a>
							<a id="publishHtml" class="nui-button" iconCls="icon-ok" onclick="publishHtml()">发布静态页</a>
						<%
							}
						%>
						
						<%
							if(infoStatus.equals("2")){
						%>
							<a id="publish" class="nui-button" iconCls="icon-goto" onclick="setInfoStatus(3,'发布')">发布</a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a id="remove" class="nui-button" iconCls="icon-remove" onclick="setInfoStatus(5,'删除')">删除</a>
						<%
							}
						%>
						
						<%
							if(infoStatus.equals("4")||infoStatus.equals("1")){
						%>
							<a id="submits" class="nui-button" iconCls="icon-upload" onclick="setInfoStatus(2,'送审')">送审 </a>
							<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a id="remove" class="nui-button" iconCls="icon-remove" onclick="setInfoStatus(5,'删除')">删除</a>
						<%
							}
						%>
						
						<%
							if(infoStatus.equals("5")){
						%>
							<a id="reduction" class="nui-button" iconCls="icon-ok" onclick="setInfoStatus(1,'还原')">还原</a>
							<a id="del" class="nui-button" iconCls="icon-remove" onclick="del()">彻底删除</a>
						<%
							}
						%>
						<a id="reload" class="nui-button" iconCls="icon-reload" onclick="refresh()">刷新</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="datagrid1" dataField="info" class="nui-datagrid" style="width: 100%; height: 100%;"
				url="com.cms.content.ContentService.queryInfoListSql.biz.ext"
				pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div field="id" headerAlign="center" allowSort="true" visible="false">内容ID</div>
					<div field="infoStatus" headerAlign="center" allowSort="true" visible="false">infoStatus</div>
					<div field="modelId" headerAlign="center" allowSort="true" visible="false">modelId</div>
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
         	var formData = new nui.Form("#queryform").getData(false, false);
         	grid.load(formData);
         	
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
		      		e.cellHtml = "<a class='icon-"+row.modelId+"' style='padding-left:20px;cursor:pointer;'>"+row.infoTitle+"</a>";
			    }
			});
         	
			setAddBtn();
			function setAddBtn(){
	        	var json = nui.encode({catId:<%=catId %>});
				$.ajax({
					url:"com.cms.content.CategoryService.queryInfoCategoryModel.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						if(text.data.length>0){
							for(var i=0;i<text.data.length;i++){
								$("#"+text.data[i].modelId).css("display","block");
							}
						}
			         }
	          	});
	        }
			
			//新增
			function add(model) {
				var url = "<%=request.getContextPath()%>/content/info/info_"+model+"_add.jsp?catId=<%=catId %>&modelId="+model;
				nui.open({
					url : url,
					title : "新增记录",
					width : '80%',
					height : '100%',
					onload : function() {
					},
					ondestroy : function(action) {//弹出页面关闭前
						if (action == "saveSuccess") {
							grid.reload();
		                	refresh();
						}
					}
				});
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
			
			//修改信息状态
			function setInfoStatus(infoStatus,msg) {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					var json = '{"infos":[';
					for(var i=0;i<rows.length;i++){
						if(i>0){
							json+=',{"id":"'+rows[i].id+'","infoStatus":"'+infoStatus+'"}';
						}else{
							json+='{"id":"'+rows[i].id+'","infoStatus":"'+infoStatus+'"}';
						}
					}
					json += "]}";
					nui.confirm("确定"+msg+"选中记录？","系统提示",function(action) {
						if (action == "ok") {
							grid.loading("正在删除中,请稍等...");
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
			
			
			//删除
			function del() {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					nui.confirm("确定彻底删除选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							var json = nui.encode({
								infos : rows
							});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url : "com.cms.content.ContentService.deleteInfos.biz.ext",
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
	
			//当选择列时
			function selectionChanged() {
				var rows = grid.getSelecteds();
				if (rows.length > 1) {
					nui.get("update").disable();
				} else {
					nui.get("update").enable();
				}
			}
			function publishHtml(){
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					nui.confirm("确定生成选中记录？","系统提示",
					function(action) {
						if (action == "ok") {
							var json = nui.encode({
								infos : rows
							});
							grid.loading("正在生成,请稍等...");
							$.ajax({
								url : "com.cms.content.ContentService.createContentHtml.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {
										grid.reload();
										nui.alert("生成成功","系统提示",function(action) {
										});
									} else {
										grid.unmask();
										nui.alert("生成失败","系统提示");
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
			}
		</script>
	</body>
</html>
