<%@page import="com.cms.view.CmsInfoCategoryViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String catId = request.getParameter("catId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
	</head>
	<body>
		<div class="nui-fit" style="padding:5px">
			  <div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%" ajaxData="setRoleId" 
			  url="com.cms.count.vo.InfoViewService.infoViewCategory.biz.ext" multiSelect="true" allowSortColumn="false" showPager = "false">
		        <div property="columns">
		            <div field="date" name="date" width="130" align="center" headeralign="center">日期</div>
		            <div field="orgName" name="orgName" width="200" align="left" headeralign="center">单位</div>
		            <div field="userName" name="userName" width="100" headeralign="center" align="center">编辑</div>
		            <div field="" align="center" headeralign="center" width="160">详情
		                <div property="columns" align="center">
	                        <div field="id" name="id" width="50" headeralign="center" allowsort="true" align="center">ID</div>
	                        <div field="catName" name="catName" width="100" headeralign="center" allowsort="true" align="center">栏目</div>
	                        <div field="infoTitle" width="auto" headeralign="center" allowsort="true" align="left">标题</div>
	                        <div field="replayUser" name="replayUser" width="80" headeralign="center" allowsort="true" align="center">发布人</div>
	                        <div field="source" name="source" width="80" headeralign="center" allowsort="true" align="center">来源</div>
	                        <div field="infoStatus" name="infoStatus" width="80" headeralign="center" allowsort="true" align="center">状态</div>
	                        <div field="releasedDtime" width="120" headeralign="center" allowsort="true" align="center" dateFormat="yyyy-MM-dd HH:mm">发布时间</div>
	                    </div>
		            </div>
		        </div>
		    </div>
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="exportInfo()">导出</a>
			 <span style="display:inline-block;width:25px;"></span>
			 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">关闭</a>
		</div>
		<div id="form1">
			<input name="catId" value="<%=catId %>" class="nui-hidden" />
			<input name="startTime" value="<%=startTime %>" class="nui-hidden" />
			<input name="endTime" value="<%=endTime %>" class="nui-hidden" />
		</div>
	    <script type="text/javascript">
		    mini.parse();
	        var grid = mini.get("datagrid1");
	        grid.on("load", function () {
	            grid.mergeColumns(["date"]);
	        });
	        function exportInfo() {        
		       	var form = new nui.Form("form1");
		        var data = form.getData(false,true);
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.excel.ExcelService.exportCategory.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {
	                    location.href="<%=request.getContextPath()%>/"+text.downloadFile;
	                }
	            });
		    }
	        grid.load();
	        function setRoleId(){
				return {"catId":"<%=catId %>","startTime":"<%=startTime %>","endTime":"<%=endTime %>"};
			}
			grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value;
			    if (field == "infoStatus") {
		      		if (value == 1){
			        	e.cellHtml = "草稿箱";
			        }
			        if (value == 2){
			        	e.cellHtml = "待审核";
			        }
			        if (value == 3){
			        	e.cellHtml = "已采用";
			        }
			        if (value == 4){
			        	e.cellHtml = "已撤稿";
			        }
			        if (value == 5){
			        	e.cellHtml = "已删除";
			        }
			        if (value == 6){
			        	e.cellHtml = "已退回";
			        }
			    }
			});
			function CloseWindow(action){
				if(action=="close"){

				}else if(window.CloseOwnerWindow)
					return window.CloseOwnerWindow(action);
				else
              	return window.close();
            }
	        function onCancel(e) {
	            CloseWindow("cancel");
	        }
	    </script>
	</body>
</html>