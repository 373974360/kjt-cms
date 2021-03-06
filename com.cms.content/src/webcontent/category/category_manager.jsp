<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
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
	<div id="region1" region="west" title="站点栏目管理" showHeader="true" class="sub-sidebar" 
	width="240" allowResize="false">
			<ul id="tree1" class="nui-tree" url="com.cms.content.CategoryService.queryCategoryAllTreeNode.biz.ext" 
			style="width:98%;height:98%;padding:5px;" textField="text" idField="id" resultAsTree="false" 
			parentField="pid" onnodeclick="onNodeClick" allowDrag="true" allowDrop="true" showTreeLines="true"
			contextMenu="#applicaitonTreeMenu" onbeforeload="onBeforeTreeLoad" ongivefeedback="onGiveFeedback" ondrop="onDrop" style="background:#fafafa;">
	    	</ul>
	    	<ul id="applicaitonTreeMenu" class="nui-contextmenu"  onbeforeopen="onBeforeOpen">
			</ul>
    </div>
    <div title="center" region="center" style="border:0;padding-left:5px;padding-top:5px;">
    	<!--Tabs-->
       <div id="applicationtabs" class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
		    <div name="application_list_tab"
		    title="站点列表" url="<%=request.getContextPath() %>/content/category/category_site_list.jsp" visible="true" >
		    </div>
		</div>
	</div>
</div>


<script type="text/javascript">
    nui.parse();
    var tree = nui.get("tree1");
    function onBeforeTreeLoad(e) {
		e.params.nodeType = e.node.type;
		e.params.nodeId = e.node.realId;
    }
	var site_list  = { title: '站点列表', path: '<%=request.getContextPath() %>/content/category/category_site_list.jsp' };
	var category_list  = { title: '栏目列表', path: '<%=request.getContextPath() %>/content/category/category_list.jsp' };
	
	var applicationtabs_map = {};
	applicationtabs_map["root"] = [site_list];
	applicationtabs_map["site"] = [category_list];
	applicationtabs_map["category"] = [category_list];
	
	function setUrlParam(url,params){
		if(!url){
			return url;
		}
		return url + "?nodeId=" + params.realId;
	}
	
	function refreshTab(node){
		var tabs = nui.get("applicationtabs");
		var applicationtabs = applicationtabs_map[node.type];
		
		for(var i=0;i<applicationtabs.length;i++){
			var obj = applicationtabs[i];
			obj.url = setUrlParam(obj.path,node);
		}
		tabs.setTabs(applicationtabs);
	}
	
	function onGiveFeedback(e) {
		var tree = e.sender;
		var node = e.targetNode;              //被拖拽的节点
		var targetNode = e.targetNode;  //目标投放节点
		var effect = e.effect;          //投放方式：add|before|after
		
		if(effect == "before" || effect == "after"){
			e.effect = "no";
		}
		//根节点和应用节点不允许拖放
		if(node.type == "root" || node.type == "site"){
			e.effect = "no";
		}
    }	
	//树左键点击触发事件
	function onNodeClick(e){
		var node = e.node;
		refreshTab(node);
	}
	
	function refresh(){
		var node = tree.getSelectedNode();
		if(!node){
			node = tree.getNode("root_root");
		}
		tree.loadNode(node);
	}
	
	function refreshParentNode(){
		var node = tree.getSelectedNode();
		var parentNode = tree.getParentNode(node);
	    tree.loadNode(parentNode);
	    tree.selectNode(parentNode);
	    refreshTab(parentNode);
		
	}
	
	function onDrop(e){
		var tree = e.sender;
		var node = e.dragNode;              //被拖拽的节点
		var targetNode = e.dropNode;  //目标投放节点
		
		var json = nui.encode({"category":{"id":node.realId,"parentId":targetNode.realId}});
		console.log(json);
		$.ajax({
            url: "com.cms.content.CategoryService.updateCategory.biz.ext",
            type: 'POST',
            data: json,
            cache: false,
            contentType:'text/json',
            success: function (text) {
            	tree.loadNode(targetNode);
            },
            error: function () {
            }
        });
	}
	
	//新增
	function addCategory() {
		var node = tree.getSelectedNode();
		var parentId = node.realId;
		nui.open({
			url : "<%=request.getContextPath()%>/content/category/category_add.jsp?parentId="+parentId,
			title : "新增记录",
			width : 700,
			height : 290,
			onload : function() {
			},
			ondestroy : function(action) {//弹出页面关闭前
				if (action == "saveSuccess") {
                	var node = tree.getSelectedNode();
                	tree.selectNode(node);
                	refreshTab(node);
                	refresh();
				}
			}
		});
	}
	
	//编辑
	function editCategory() {
		nui.open({
			url : "<%=request.getContextPath()%>/content/category/category_update.jsp",
			title : "编辑数据",
			width : 700,
			height : 290,
			onload : function() {
                var node = tree.getSelectedNode();
           		var data = {id:node.realId};
				var iframe = this.getIFrameEl();
				//直接从页面获取，不用去后台获取
				iframe.contentWindow.setData(data);
			},
			ondestroy : function(action) {
				if (action == "saveSuccess") {
                	refreshParentNode();
				}
			}
		});
	}
	//应用功能树右键菜单
	function onBeforeOpen(e) {
	    var obj = e.sender;
	    var node = null;
		var cell = tree._getCellByEvent(e.htmlEvent);
		if(cell) {
			node = cell[0];
		}
		if(!node) {
			node = tree.getSelectedNode();
		}
	    if (!node) {
	        e.cancel = true;
	        return;
	    }
	    if(node.type=="root"){
	    	var array = [{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refreshParentNode"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);			
	    }
	    if(node.type=="site"){
	    	var array = [{id: "addcategory", text: "新增子栏目", iconCls:"icon-add", onclick:"addCategory"},
						{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refresh"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);			
	    }
	    if(node.type=="category"){
	    	var array = [{id: "addcategory", text: "新增子栏目", iconCls:"icon-add", onclick:"addCategory"},
						{id: "editcategory", text: "修改栏目", iconCls:"icon-edit", onclick:"editCategory"},
						{id: "refresh", text: "刷新", iconCls:"icon-reload", onclick:"refresh"}];
			e.htmlEvent.preventDefault();
			obj.loadList(array);			
	    }
	}
</script>
</body>
</html>