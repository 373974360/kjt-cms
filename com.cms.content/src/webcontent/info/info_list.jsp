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
				                <li iconCls="icon-article" onclick="add('article')">文章</li>
				                <li iconCls="icon-video" onclick="add('video')">视频</li>
				                <li iconCls="icon-pic" onclick="add('pic')">组图</li>
				                <li iconCls="icon-link" onclick="add('link')">连接</li>
				                <li iconCls="icon-leader" onclick="add('leader')">领导</li>
				                <li iconCls="icon-doc" onclick="add('doc')">发文</li>
				                <li iconCls="icon-expert" onclick="add('expert')">专家</li>
				                <li iconCls="icon-download" onclick="add('download')">下载</li>
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
					<div field="inputUser" width="80" headerAlign="center" allowSort="true">录入人</div>
					<div field="inputDtime" width="100" headerAlign="center" allowSort="true">录入时间</div>
					<div field="releasedTime" width="100" headerAlign="center" allowSort="true">发布时间</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			nui.parse();
			var grid = nui.get("datagrid1");
	
			var formData = new nui.Form("#queryform").getData(false, false);
			grid.load(formData);
			
			//新增
			function add(model) {
				var url = "<%=request.getContextPath()%>/content/info/info_"+model+"_add.jsp?catId=<%=catId %>";
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
		                	parent.refresh();
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
