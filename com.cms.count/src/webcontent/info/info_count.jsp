<%@page import="com.cms.view.velocity.DateUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	String currTime = DateUtil.getCurrentDate();
	String startTime = currTime.substring(0,8)+"01";
%>
<html>
	<head>
		<title>信息统计</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
				<div class="nui-panel" title="统计条件设置" iconCls="icon-add" style="width: 100%; height: 15%;" showToolbar="false" showFooter="true">
					<div id="queryform" class="nui-form" align="center" style="height: 100%">
						<table id="table1" class="table" style="height: 100%;float:left;">
							<tr>
								<td class="form_label">统计方式：</td>
								<td colspan="1">
									<input id="countType" class="nui-combobox" style="width:150px;" textField="text" valueField="id"
			    					url="<%=request.getContextPath()%>/count/info/countType.txt" dataField="countType" value="1"/>
								</td>
								<td></td>
								<td class="form_label">时间段：</td>
								<td colspan="1">
									<input name="startTime" class="nui-datepicker" style="width:120px;" format="yyyy-MM-dd" value="<%=startTime %>"/>
									至
									<input name="endTime" class="nui-datepicker" style="width:120px;" format="yyyy-MM-dd" value="<%=currTime %>"/>
								</td>
								<td>
									<div property="footer" align="center">
										<a class="nui-button" onclick="toCount()">统计 </a>
										<a class="nui-button" onclick="viewExcel()">报表预览 </a>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="nui-panel" title="统计结果" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
					<iframe id="countFrame" src="" width="100%" height="100%" frameborder="0"></iframe>
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
			function toCount(){
				var countType = nui.get("countType").getValue();
				var startTime = $("input[name='startTime']").val();
				var endTime = $("input[name='endTime']").val();
				var catId = getCheckedNodes();
				if(catId==""){
					alert("请选择栏目");
					return false;
				}
				var url = "";
				if(countType==1){
					url = "category_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
				if(countType==2){
					url = "user_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
				if(countType==3){
					url = "org_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
				$("#countFrame").attr("src",url);
			}
			function viewExcel(){
				var countType = nui.get("countType").getValue();
				if(countType==1){
					url = "category_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
				if(countType==2){
					url = "user_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
				if(countType==3){
					url = "org_count.jsp?startTime="+startTime+"&endTime="+endTime+"&catId="+catId;
				}
			}
		</script>
	</body>
</html>
