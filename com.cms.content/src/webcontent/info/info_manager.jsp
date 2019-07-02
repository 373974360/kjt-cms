<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-02-28 10:38:33
  - Description:应用功能管理入口
-->
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
	<div id="region1" region="west" title="站点栏目" showHeader="true" class="sub-sidebar" 
	width="200" allowResize="false">
		<ul id="tree1" class="nui-tree" url="com.cms.content.ContentService.queryInfoCategoryTreeNode.biz.ext" 
		style="width:98%;height:98%;padding:5px;" textField="text" idField="id" resultAsTree="false" 
		parentField="pid" onnodeclick="onNodeClick" showTreeLines="true"
		 onbeforeload="onBeforeTreeLoad" ajaxData="setRoleId" style="background:#fafafa;">
    	</ul>
    </div>
    <div title="center" region="center" style="border:0;padding-left:5px;">
    	<div class="nui-panel" title="信息查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<table id="table1" class="table" style="height: 100%;float:left;">
					<tr>
						<td class="form_label">文章分类:</td>
						<td>
							<input name="infoType" class="nui-combobox" style="width:150px;" textField="typeName" valueField="id"
						    url="com.cms.basics.InfoTypeService.queryInfoTypeAll.biz.ext" dataField="data" showNullItem="true" />
						</td>
						<td class="form_label">标题:</td>
						<td>
							<input class="nui-textbox" name="searchKey" id="searchKey"/>
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
    	<!--Tabs-->
		<div class="nui-panel" title="内容列表" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
	       <div id="infotabs" class="nui-tabs bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
			    <div name="info_list_tab_3" title="已发布" visible="true"></div>
			    <div name="info_list_tab_4" title="已撤稿" visible="true"></div>
			    <div name="info_list_tab_1" title="草稿箱" visible="true"></div>
			    <div name="info_list_tab_5" title="回收站" visible="true"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    nui.parse();
    var tree = nui.get("tree1");
    var tabs = nui.get("infotabs");
    
    function setRoleId(){
		return {"userId":"<%=userObject.getUserId() %>","nodeId":0};
	}
    
    function onBeforeTreeLoad(e) {
		e.params.nodeType = e.node.type;
		e.params.nodeId = e.node.realId;
    }
	var info_list_1  = { title: '草稿箱', path: '<%=request.getContextPath() %>/content/info/info_list.jsp?infoStatus=1' ,refreshOnClick:true};
	var info_list_3  = { title: '已发布', path: '<%=request.getContextPath() %>/content/info/info_list.jsp?infoStatus=3' ,refreshOnClick:true};
	var info_list_4  = { title: '已撤稿', path: '<%=request.getContextPath() %>/content/info/info_list.jsp?infoStatus=4' ,refreshOnClick:true};
	var info_list_5  = { title: '已删除', path: '<%=request.getContextPath() %>/content/info/info_list.jsp?infoStatus=5' ,refreshOnClick:true};
	var applicationtabs_map = {};
	applicationtabs_map["category"] = [info_list_3,info_list_4,info_list_1,info_list_5];
	
	function setUrlParam(url,params){
		if(!url){
			return url;
		}
		return url + "&nodeId=" + params.realId+"&isAdd="+params.isLeaf+"&searchKey="+$("input[name=searchKey]").val().replace(/^\s+|\s+$/g,'')+"&infoType="+$("input[name=infoType]").val();
	}
	
	function refreshTab(node){
		var tabs = nui.get("infotabs");
		var applicationtabs = applicationtabs_map[node.type];
		
		for(var i=0;i<applicationtabs.length;i++){
			var obj = applicationtabs[i];
			obj.url = setUrlParam(obj.path,node);
		}
		tabs.setTabs(applicationtabs);
	}
	//树左键点击触发事件
	function onNodeClick(e){
		var node = e.node;
		refreshTab(node);
	}
	refresh();
	function refresh(){
		var node = tree.getSelectedNode();
		if(!node){
			node = tree.getNode("root");
		}
		tree.loadNode(node);
		refreshTab(node);
	}
	
	//查询
	function search() {
		var tab = tabs.getActiveTab();
		var node = tree.getSelectedNode();
		if(!node){
			node = tree.getNode("root");
		}
		refreshTab(node);
		tabs.activeTab(tab);
	}

	//重置查询条件
	function reset() {
		var form = new nui.Form("#queryform");//将普通form转为nui的form
		form.reset();
		var tab = tabs.getActiveTab();
		var node = tree.getSelectedNode();
		if(!node){
			node = tree.getNode("root");
		}
		refreshTab(node);
		tabs.activeTab(tab);
	}
</script>
</body>
</html>