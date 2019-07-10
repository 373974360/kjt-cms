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
    <div class="nui-fit"style="padding:5px">
        <ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
			url="com.cms.content.ContentService.queryInfoEditorCategoryTreeNode.biz.ext"
			idField="id" textField="text" parentField="pid" resultAsTree="false" ajaxData="setRoleId" value="id"
			showTreeIcon="true" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" showFolderCheckBox="false">
		</ul>
    </div>  
    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
    </div>
    <script type="text/javascript">
	    nui.parse();
		var funcTree = nui.get("funcTree");
		funcTree.expandLevel(0);
		function getCheckedNodes() {
			var ids = funcTree.getValue(false);
			var names = funcTree.getText(false);
			var data = {id:ids,name:names};
		    return data;
		}
		function setCheckedNodes(ids,catId){
			var node = funcTree.getNode(catId+"");
			funcTree.setValue(ids);
			funcTree.removeNode(node);
		}
	
		function setRoleId(){
			return {"userId":"<%=userObject.getUserId() %>"};
		}
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	
	    function onOk() {
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	</script>
</body>
</html>
