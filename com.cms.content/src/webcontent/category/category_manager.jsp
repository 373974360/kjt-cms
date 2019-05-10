<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="/coframe/tools/skins/common.jsp" %>
<html>
	<head>
		<style>
			#tree1 .mini-grid-viewport{
				background-color:transparent !important;
			}
			#tree1 .mini-panel-viewport{
				background-color:transparent !important;
			}
			#applicationtabs .mini-tabs-bodys{
				padding:0px;
			}
		</style>
	</head>
	<body>
		<div id="layout1" class="nui-layout" style="width:100%;height:100%;">
			<div id="region1" region="west" title="站点栏目管理" showHeader="true" class="sub-sidebar" 
			width="240" allowResize="false">
				<ul id="tree1" class="nui-tree" url="com.cms.content.CategoryService.querySiteCategoryTreeNode.biz.ext" 
				style="width:98%;height:98%;padding:5px;" showTreeIcon="true" textField="text" idField="id" resultAsTree="false" 
				parentField="pid" showTreeLines="true" onnodeclick="onNodeClick" allowDrag="true" allowDrop="true" 
				contextMenu="#categoryTreeMenu" onbeforeload="onBeforeTreeLoad" ongivefeedback="onGiveFeedback" ondrop="onDrop" style="background:#fafafa;">
		    	</ul>
		    	<ul id="categoryTreeMenu" class="nui-contextmenu"  onbeforeopen="onBeforeOpen">
				</ul>
		    </div>
		    <div title="center" region="center" style="border:0;padding-left:5px;padding-top:5px;">
		    	<!--Tabs-->
		       <div id="categorytabs" class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
				    <div name="category_list_tab"
				    title="站点列表" url="<%=request.getContextPath() %>/content/category/category_site_list.jsp" visible="true" >
				    </div>
				</div>
			</div>
		</div>
	</body>
</html>