<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("nodeId");
	String searchKey = request.getParameter("searchKey");
	String infoStatus = request.getParameter("infoStatus");
	String infoType = request.getParameter("infoType");
	boolean isAdd = Boolean.parseBoolean(request.getParameter("isAdd"));
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
			<!-- 查询字段 -->
			<input class="nui-hidden" name="params/catId" value="<%=catId %>"/>
			<input class="nui-hidden" name="params/infoStatus" value="<%=infoStatus %>"/>
			<input class="nui-hidden" name="params/infoType" value="<%=infoType %>"/>
			<input class="nui-hidden" name="params/searchKey" value="<%=searchKey %>"/>
			<input class="nui-hidden" name="params/userId" value="<%=userObject.getUserId() %>"/>
			<input class="nui-hidden" name="params/orgId" value="<%=userObject.getUserOrgId() %>"/>
		</div>
		<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<%
							if(isAdd && infoStatus.equals("3")){
						%>
							<a id="add" class="nui-menubutton" menu="#popupMenu" >新增...</a>
						    <ul id="popupMenu" class="nui-menu" style="display:none;">
				                <li id="article" iconCls="icon-article" onclick="add('article')" style="display:none;">文章</li>
				                <li id="video" iconCls="icon-video" onclick="add('video')" style="display:none;">视频</li>
				                <li id="pic" iconCls="icon-pic" onclick="add('pic')" style="display:none;">组图</li>
				                <li id="link" iconCls="icon-link" onclick="add('link')" style="display:none;">链接</li>
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
							<a id="publish_update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
							<a id="remove" class="nui-button" iconCls="icon-remove" onclick="setInfoStatus(5,'删除')">删除</a>
	            			<span class="separator"></span>
							<a id="pushWeChat" class="nui-button" iconCls="icon-upload" onclick="doPubsWeChat()">微信推送</a>
							<a id="publishHtml" class="nui-button" iconCls="icon-ok" onclick="publishHtml()">发布静态页</a>
	            			<span class="separator"></span>
							<a id="getInfo" class="nui-button" iconCls="icon-filter" onclick="getInfo()">获取信息</a>
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
							<a id="publish" class="nui-button" iconCls="icon-goto" onclick="setInfoStatus(3,'发布')">发布</a>
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
				url="com.cms.content.ContentService.queryInfoListSql.biz.ext" idField="id" pageSize="20" showPageInfo="true" 
				multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false" allowCellEdit="true" allowCellSelect="true" allowAlternating="true">
				<div property="columns">
					<div type="checkcolumn" width="40"></div>
					<div field="id" headerAlign="center" allowSort="true" visible="false">内容ID</div>
					<div field="title" width="auto" headerAlign="left" allowSort="true">标题</div>
					<div type="checkboxcolumn" field="isTop" width="50" trueValue="1" falseValue="2" headerAlign="center" align="center" allowSort="true">置顶</div>
					<div type="checkboxcolumn" field="isTuijian" width="50" trueValue="1" falseValue="2" headerAlign="center" align="center" allowSort="true">推荐</div>
					<div field="weight" width="50" headerAlign="center" align="center" allowSort="true">权重
						<input property="editor" class="nui-spinner"  minValue="0" maxValue="99" style="width:80%;"/>
					</div>
					<div field="editor" width="100" headerAlign="center" align="center" allowSort="true">编辑</div>
					<div field="releasedDtime" width="130" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">发布时间</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
         	var formData = new nui.Form("#queryform").getData(false, false);
         	grid.load(formData);
         	
         	grid.on("cellendedit", function (e) {
			    var field = e.field,
			        value = e.value,
			        row = e.row;
			    if (field == "weight") {
		      		var json = '{"cmsInfo":{"id":"'+row.id+'","weight":"'+value+'"}}';
		      		$.ajax({
		                url: "com.cms.content.ContentService.updateInfoParams.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
		                success: function (text) {
		                   refresh();
		                }
		            });
		      	}
			});
         	
         	grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value,
			        row = e.row;
			    if (field == "title") {
		      		e.cellHtml = "<a class='icon-"+row.modelId+"' style='padding-left:20px;cursor:pointer;' href='<%=request.getContextPath()%>/content/info/view.jsp?info_id="+row.id+"' target='_blank'>"+row.infoTitle+"</a>";
			    }
			});
			
			grid.on("cellclick", function (e) {
			    var field = e.field,
			        value = e.value,
			        row = e.row;
			    if (field == "isTop") {
			    	if(value==2){
			    		value=1;
			    	}else{
			    		value=2;
			    	}
			    	var json = '{"cmsInfo":{"id":"'+row.id+'","isTop":"'+value+'"}}';
		      		$.ajax({
		                url: "com.cms.content.ContentService.updateInfoParams.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
		                success: function (text) {
		                   refresh();
		                }
		            });
			    }
			    if (field == "isTuijian") {
			    	if(value==2){
			    		value=1;
			    	}else{
			    		value=2;
			    	}
			    	var json = '{"cmsInfo":{"id":"'+row.id+'","isTuijian":"'+value+'"}}';
		      		$.ajax({
		                url: "com.cms.content.ContentService.updateInfoParams.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
		                success: function (text) {
		                   refresh();
		                }
		            });
			    }
			});
         	
         	setAuthBtn();
         	function setAuthBtn(){
         		var btn = ["add","revoke","update","remove","publish","reduction","del","pushWeChat","getInfo"];
         		var json = nui.encode({params:{userId:<%=userObject.getUserId() %>,funId:1021}});
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
				var url = "<%=request.getContextPath()%>/content/info/info_"+model+"_add.jsp?catId=<%=catId %>&modelId="+model+"&group=manager";
				nui.open({
					url : url,
					title : "新增记录",
					width : '90%',
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
				var rows = grid.getSelecteds();
				if (rows.length == 1) {
					nui.open({
						url : "<%=request.getContextPath()%>/content/info/info_"+rows[0].modelId+"_edit.jsp?catId="+rows[0].catId+"&group=manager",
						title : "编辑数据",
						width : '90%',
						height : '100%',
						onload : function() {
							var iframe = this.getIFrameEl();
							var data = rows[0];
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
			
			//微信推送
			function doPubsWeChat() {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					if(rows.length<=8){
						var json = nui.encode({
							infos : rows
						});
						nui.confirm("确定将选中的信息推送至微信公众号？","系统提示",function(action) {
							if (action == "ok") {
								grid.loading("正在推送中,请稍等...");
								$.ajax({
									url : "com.cms.content.ContentService.doPushWeChat.biz.ext",
									type : 'POST',
									data : json,
									cache : false,
									contentType : 'text/json',
									success : function(text) {
										var returnJson = nui.decode(text);
										if (returnJson.exception == null) {
											grid.reload();
											nui.alert("推送成功","系统提示",function(action) {
											});
										} else {
											grid.unmask();
											nui.alert("推送失败","系统提示");
										}
									}
								});
							}
						});
					}else{
						nui.alert("最多选择8条信息！");
					}
				} else {
					nui.alert("请选中一条记录！");
				}
			}
			
			//修改信息状态
			function setInfoStatus(infoStatus,msg) {
				var rows = grid.getSelecteds();
				if (rows.length > 0) {
					for(var i=0;i<rows.length;i++){
						rows[i].infoStatus = infoStatus;
					}
					var json = nui.encode({catId:<%=catId %>,infos : rows});
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
										nui.alert(msg+"失败","系统提示");
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
					<%
						if(infoStatus.equals("1")||infoStatus.equals("2")||infoStatus.equals("4")){
					%>
						nui.get("update").disable();
					<%
						}else{
					%>
						nui.get("publish_update").disable();
					<%
						}
					%>
				} else {
					<%
						if(infoStatus.equals("1")||infoStatus.equals("2")||infoStatus.equals("4")){
					%>
						nui.get("update").enable();
					<%
						}else{
					%>
						nui.get("publish_update").enable();
					<%
						}
					%>
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
			
			//信息获取
			function getInfo() {
				var json = nui.encode({catId:<%=catId %>});
				$.ajax({
					url:"com.cms.content.ContentService.checkChildrenCategory.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						if(text.data.length==0){
							nui.open({
								url : "<%=request.getContextPath()%>/content/info/getInfo.jsp?catId=<%=catId %>",
								title : "信息获取",
								width : '80%',
								height : '80%',
								onload : function() {
								},
								ondestroy : function(action) {
									if (action == "saveSuccess") {
										grid.reload();
									}
								}
							});
						}else{
							nui.alert("请选择最末级栏目","系统提示");
						}
			         }
	          	});
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
