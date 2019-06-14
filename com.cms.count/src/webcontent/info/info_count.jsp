<%@page import="com.cms.view.velocity.DateUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	String currTime = DateUtil.getCurrentDate();
	String startTime = currTime.substring(0,8)+"01";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>信息统计</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
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
						<td></td>
						<td class="form_label">统计范围：</td>
						<td colspan="1">
							<input name="catId" class="nui-treeselect" url="com.cms.content.CategoryService.queryPublishPageCategoryTreeNode.biz.ext"
							    textField="text" dataField="data" valueField="id" parentField="pid" showNullItem="true"
							/>
						</td>
						<td>
							<div property="footer" align="center">
								<a class="nui-button" onclick="toCount()">统计 </a>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="nui-panel" title="统计结果" iconCls="icon-add" style="width: 100%; height: 85%;" showToolbar="false" showFooter="false">
			<iframe id="countFrame" src="" width="100%" height="100%" frameborder="0"></iframe>
		</div>
		<script type="text/javascript">
			nui.parse();
			var tree = nui.get("select1");
		    
		    function setRoleId(){
				return {"userId":"<%=userObject.getUserId() %>","nodeId":0};
			}
			
		    function onBeforeTreeLoad(e) {
				e.params.nodeType = e.node.type;
				e.params.nodeId = e.node.realId;
		    }
			function toCount(){
				var countType = nui.get("countType").getValue();
				var startTime = $("input[name='startTime']").val();
				var endTime = $("input[name='endTime']").val();
				var catId = $("input[name='catId']").val();
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
		</script>
	</body>
</html>
