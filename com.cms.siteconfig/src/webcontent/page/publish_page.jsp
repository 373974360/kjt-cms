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
	<div id="region1" region="west" title="栏目选择" showHeader="true" class="sub-sidebar" width="200" allowResize="false">
		<ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
			url="com.cms.content.CategoryService.queryPublishPageCategoryTreeNode.biz.ext"
			idField="id" textField="text" parentField="pid" resultAsTree="false"
			showTreeIcon="true" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="false" autoCheckParent="true">
		</ul>
    </div>
    <div title="center" region="center" style="border:0;padding-left:5px;">
    	<div class="nui-panel" title="条件设置" iconCls="icon-add" style="width: 100%; height: 100%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<table id="table1" class="table" style="float:left;">
					<tr>
						<td class="form_label">发布时间:</td>
						<td>
							<input id="date2" class="mini-datepicker" style="width:200px;"
        					format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="true" showOkButton="true" showClearButton="false"/>
        					至
							<input id="date3" class="mini-datepicker" style="width:200px;"
        					format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="true" showOkButton="true" showClearButton="false"/>
						</td>
						<td>
							<div property="footer" align="center">
								<a class="nui-button" onclick="doPublishPage()">生成 静态页</a>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	nui.parse();
	var funcTree = nui.get("funcTree");
	funcTree.expandLevel(0);
	function getCheckedNodes() {
	    return funcTree.getValue(false);
	}
	//删除
	function doPublishPage() {
		var catId = getCheckedNodes();
		var json = nui.encode({params:{catId : catId,startTime:mini.get("date2").getValue(),endTime:mini.get("date3").getValue()}});
		$.ajax({
			url : "com.cms.siteconfig.PageService.publishPage.biz.ext",
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				console.log(text);
				var returnJson = nui.decode(text);
				if (returnJson.exception == null) {
					nui.alert("发布成功","系统提示",function(action) {
					});
				} else {
					nui.alert("发布失败","系统提示");
				}
			}
		});
	}
</script>
</body>
</html>