<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): liuzn (mailto:liuzn@primeton.com)
  - Date: 2013-03-01 13:51:37
  - Description:
-->
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="/coframe/tools/skins/common.jsp" %>
<title>角色功能授权</title>
</head>
<body>
<div class="nui-fit" style="padding:10px;">
<div id="panel1" class="nui-panel" style="width:100%;height:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                	<a class="nui-button" iconCls="icon-save" onclick="saveTree" title="保存"></a>
                	<span class="separator"></span>
			        <a class="nui-button" iconCls="icon-expand" onclick="expandAll()" title="全部展开"></a>
					<a class="nui-button" iconCls="icon-collapse" onclick="collapseAll()" title="全部折叠"></a>
                </td>
                <td style="white-space:nowrap;">
                	应用功能名：
                	<input id="key" class="nui-textbox" style="width:100px;" onenter="onKeyEnter" emptyText="请输入查询条件" />
					<a class="nui-button" style="width:60px;" iconCls="icon-search" onclick="search()">查询</a>
                </td>
            </tr>
        </table> 
    </div>
    <!--body-->
 	<div class="nui-fit" style="padding:0px 10px 10px 10px;">
		<ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
			url="com.cms.content.CategoryService.queryAuthCategoryTreeNode.biz.ext"
			idField="id" textField="text" parentField="pid" resultAsTree="false"
			showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="false" autoCheckParent="true">
		</ul>
	</div>

</div>
</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var funcTree = nui.get("funcTree");
	funcTree.expandLevel(0);

	function setRoleId(){
		return {"userId":"<%= request.getParameter("userId")%>"};
	}

	function saveTree(e){
		var userId = <%= request.getParameter("userId")%>
		var tree = mini.get("funcTree");
        var value = tree.getValue(true);
        var array = value.split(",");
        var json = '{"datas":[';
        for(var i=0;i<array.length;i++){
        	if(i>0){
        		json+=',{"userId":"'+userId+'","catId":"'+array[i]+'"}';
        	}else{
        		json+='{"userId":"'+userId+'","catId":"'+array[i]+'"}';
        	}
        }
        json+='],"params":{"userId":"'+userId+'"}}';
        $.ajax({
            url: "com.cms.content.CategoryService.setAuthUserCategory.biz.ext",
            type: 'POST',
            data: json,
            cache: false,
            contentType:'text/json',
            success: function (text) {
                CloseWindow("saveSuccess");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
                CloseWindow();
            }
        });
	}

	function search(){
		var filtedNodes = [];
		var key = nui.get("key").getValue();
		if(key == ""){
			funcTree.clearFilter();
		}else{
			var rootNode = funcTree.getRootNode();
			funcTree.cascadeChild(
				rootNode,
				function(node){
					var pNode = funcTree.getParentNode(node);
					var nofind = true;
					for(i = 0; i < filtedNodes.length; i++){
						if(filtedNodes[i] == pNode.id){
							filtedNodes.push(node.id);
							nofind = false;
							break;
						}
					}
					if(nofind){
						var text = node.text ? node.text.toLowerCase() : "";
						if(text.indexOf(key) != -1){
							filtedNodes.push(node.id);
						}
					}
				}
			);
			funcTree.filter(function(node){
				for(i = 0; i < filtedNodes.length; i++){
					if(filtedNodes[i] == node.id){
						return true;
					}
				}
			});
		}
	}

	function expandAll(){
		funcTree.expandAll();
	}

	function collapseAll(){
		funcTree.collapseAll();
	}
	function CloseWindow(action){
		if(action=="close"){

		}else if(window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			return window.close();
		}
</script>