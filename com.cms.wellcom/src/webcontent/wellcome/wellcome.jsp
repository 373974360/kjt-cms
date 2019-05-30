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
<!--Tabs-->
<div class="nui-panel" title="代办列表" iconCls="icon-add" style="width: 100%; height:100%;" showToolbar="false" showFooter="false">
   <div id="infotabs" class="nui-tabs bg-toolbar" activeIndex="0" style="width:100%;height:100%;border:0;">
	    <div name="info_list_tab_1" title="待审信息" visible="true" url="<%=request.getContextPath() %>/wellcom/wellcome/info_list.jsp"></div>
	</div>
</div>
</body>
</html>