<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	String catId = request.getParameter("catId");
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-02-28 10:38:33
  - Description:应用功能管理入口
-->
<head>
		<link href="<%=request.getContextPath()%>/content/icons/icons.css" rel="stylesheet" type="text/css"/>
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
    <div class="nui-fit">
	    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
	    	<div id="region1" region="west" showHeader="true" class="sub-sidebar" 
				width="200" allowResize="false">
		        <ul id="tree1" class="nui-tree" url="com.cms.content.ContentService.queryInfoCategoryTreeNode.biz.ext" 
				style="width:98%;height:98%;padding:5px;" textField="text" idField="id" resultAsTree="false" 
				parentField="pid" onnodeclick="onNodeClick" showTreeLines="true"
				 onbeforeload="onBeforeTreeLoad" ajaxData="setNodeId" style="background:#fafafa;">
		    	</ul>
	    	</div>
	    	<div title="center" region="center" style="border:0;padding-left:5px;">
		    	<div class="nui-panel" title="信息查询" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
					<div id="queryform" class="nui-form" align="center">
						<table id="table1" class="table" style="height: 100%;float:left;">
							<tr>
								<td class="form_label">文章分类:</td>
								<td>
									<input class="nui-hidden" name="params/infoStatus" value="3"/>
									<input class="nui-hidden" name="params/userId" value="<%=userObject.getUserId() %>"/>
									<input class="nui-hidden" name="params/orgId" value="<%=userObject.getUserOrgId() %>"/>
									<input id="catId" class="nui-hidden" name="params/catId"/>
									<input name="params/infoType" class="nui-combobox" style="width:150px;" textField="typeName" valueField="id"
								    url="com.cms.basics.InfoTypeService.queryInfoTypeAll.biz.ext" dataField="data" showNullItem="true" />
								</td>
								<td class="form_label">标题:</td>
								<td>
									<input class="nui-textbox" name="params/searchKey" id="searchKey"/>
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
			      <div id="datagrid1" dataField="info" class="nui-datagrid" style="width: 100%; height: 100%;"
						url="com.cms.content.ContentService.queryInfoListSql.biz.ext" idField="id" pageSize="20" showPageInfo="true" 
						multiSelect="true" allowSortColumn="false" allowCellEdit="true" allowCellSelect="true" allowAlternating="true">
						<div property="columns">
							<div type="checkcolumn" width="40"></div>
							<div field="id" headerAlign="center" allowSort="true" visible="false">内容ID</div>
							<div field="title" width="auto" headerAlign="left" allowSort="true">标题</div>
							<div field="isTop" width="50" headerAlign="center" align="center" allowSort="true">置顶</div>
							<div field="isTuijian" width="50" headerAlign="center" align="center" allowSort="true">推荐</div>
							<div field="weight" width="50" headerAlign="center" align="center" allowSort="true">权重</div>
							<div field="editor" width="100" headerAlign="center" align="center" allowSort="true">编辑</div>
							<div field="releasedDtime" width="130" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">发布时间</div>
						</div>
					</div>
				</div>
			</div>
	    </div>  
   	</div>
    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
    </div>
    <script type="text/javascript">
	    nui.parse();
	    var grid = nui.get("datagrid1");
     	var formData = new nui.Form("#queryform").getData(false, false);
     	grid.load(formData);
	 	var tree = nui.get("tree1");
         	
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
		    if (field == "isTuijian") {
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
    
	    function setNodeId(){
			return {"userId":"<%=userObject.getUserId() %>","nodeId":0};
		}
	    
	    function onBeforeTreeLoad(e) {
			e.params.nodeType = e.node.type;
			e.params.nodeId = e.node.realId;
	    }
	    //树左键点击触发事件
		function onNodeClick(e){
			var node = e.node;
			nui.get("catId").setValue(node.realId);
			search();
		}
		//重新刷新页面
		function search() {
			var form = new nui.Form("#queryform");
			var json = form.getData(false, false);
			grid.load(json);//grid查询
		}
	
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	
	    function onOk() {
	    	var rows = grid.getSelecteds();
	    	if(rows.length>0){
	    		
	    		var json = '{infoCat:[';
	    		for(var i=0;i<rows.length;i++){
	    			if(i==0){
	    				json += '{"catId":<%=catId %>,"infoId":'+rows[i].id+'}';
	    			}else{
	    				json += ',{"catId":<%=catId %>,"infoId":'+rows[i].id+'}';
	    			}
	    		}
	    		json+="]}";
	    		$.ajax({
	                url: "com.cms.content.ContentService.getInfoAdd.biz.ext",
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
	    	}else{
	    		nui.alert("请至少选中一条记录", "提示");
	    	}
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	</script>
</body>
</html>
