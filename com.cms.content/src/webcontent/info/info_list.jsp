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
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity" value="com.cms.content.category.CmsInfo">
			<!-- 查询字段 -->
			<input class="nui-hidden" name="criteria/_expr[0]/catId" value="<%=catId %>"/>
			<input class="nui-hidden" name="criteria/_expr[0]/_op" value="=">
			<input class="nui-hidden" name="criteria/_expr[1]/infoStatus" value="<%=infoStatus %>"/>
			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
			<input class="nui-hidden" name="criteria/_expr[2]/title" value="<%=searchKey %>"/>
			<input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
			<input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
			<input class="nui-hidden" name="criteria/_expr[3]/infoType" value="<%=infoType %>"/>
			<input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
		</div>
		<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<%
							if(isAdd){
						%>
							<a class="nui-menubutton" menu="#popupMenu" >新增...</a>
						    <ul id="popupMenu" class="nui-menu" style="display:none;">
				                <li id="article" iconCls="icon-article" onclick="add('article')" style="display:none;">文章</li>
				                <li id="video" iconCls="icon-video" onclick="add('video')" style="display:none;">视频</li>
				                <li id="pic" iconCls="icon-pic" onclick="add('pic')" style="display:none;">组图</li>
				                <li id="link" iconCls="icon-link" onclick="add('link')" style="display:none;">连接</li>
				                <li id="leader" iconCls="icon-leader" onclick="add('leader')" style="display:none;">领导</li>
				                <li id="doc" iconCls="icon-doc" onclick="add('doc')" style="display:none;">发文</li>
				                <li id="expert" iconCls="icon-expert" onclick="add('expert')" style="display:none;">专家</li>
				                <li id="download" iconCls="icon-download" onclick="add('download')" style="display:none;">下载</li>
						    </ul>
						<%
							}
						%>
						<a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">编辑 </a>
						<a id="remove" class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="datagrid1" dataField="info" class="nui-datagrid" style="width: 100%; height: 100%;"
				url="com.cms.content.ContentService.queryInfoList.biz.ext"
				pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
				<div property="columns">
					<div type="checkcolumn" width="20"></div>
					<div field="id" headerAlign="center" allowSort="true" visible="false">内容ID</div>
					<div field="infoTitle" width="300" headerAlign="left" allowSort="true">标题</div>
					<div field="action" width="100" headerAlign="center" allowSort="true">管理操作</div>
					<div field="editor" width="80" headerAlign="center" allowSort="true">编辑</div>
					<div field="inputDtime" width="100" headerAlign="center" allowSort="true">录入时间</div>
					<div field="releasedDtime" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">发布时间</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
	
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
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
			         	console.log(text.data.length);
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
			
			//重新刷新页面
			function refresh() {
				var form = new nui.Form("#queryform");
				var json = form.getData(false, false);
				grid.load(json);//grid查询
			}
		</script>
	</body>
</html>
