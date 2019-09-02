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
								<a class="nui-button" onclick="doPublishPage()">重置索引码</a>
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
	//删除
	function doPublishPage() {
		var json = nui.encode({params:{startTime:mini.get("date2").getValue(),endTime:mini.get("date3").getValue()}});
		var startTime = new Date(mini.get("date2").getValue()).getTime();
    	var endTime = new Date(mini.get("date3").getValue()).getTime();
    	if(startTime>=endTime){
    		nui.alert("截止日期不能小于开始日期", "提示");
    		return;
    	}
		$.ajax({
			url : "com.cms.siteconfig.ResetGkIndexService.resetGkIndex.biz.ext",
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				console.log(text);
				var returnJson = nui.decode(text);
				if (returnJson.exception == null) {
					nui.alert("重置成功","系统提示",function(action) {
					});
				} else {
					nui.alert("重置失败","系统提示");
				}
			}
		});
	}
</script>
</body>
</html>