<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("catId");
	String modelId = request.getParameter("modelId");
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curTime = df.format(new Date());
	String group = request.getParameter("group");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.config.js" type="text/javascript"></script>
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.min.js" type="text/javascript"></script>
		<style type="text/css">
			.mini-radiobuttonlist-table{width:300px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="info.id" name="info.id" class="nui-hidden" />
				<input id="info.catId" name="info.catId" class="nui-hidden" value="<%=catId %>" />
				<input id="info.modelId" name="info.modelId" class="nui-hidden" value="<%=modelId %>" />
				<input id="info.inputUser" name="info.inputUser" class="nui-hidden" value="<%=userObject.getUserId() %>" />
				<input id="info.orgId" name="info.orgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>" />
				<input id="info.orgName" name="info.orgName" class="nui-hidden" value="<%=userObject.getUserOrgName() %>" />
		        <input id="info.infoStatus" name="info.infoStatus" class="nui-hidden" value="3"/>
            	<input name="wflogs.busId" class="nui-hidden"/>
            	<input name="wflogs.busUrl" class="nui-hidden"/>
            	<input name="wflogs.wfOptUser" class="nui-hidden" value="<%=userObject.getUserName() %>"/>
            	<input name="wflogs.wfStepId" class="nui-hidden" value="1"/>
            	<input name="wflogs.wfOptTime" class="nui-hidden"/>
            	<input name="wflogs.wfId" class="nui-hidden"/>
            	<input name="wflogs.wfOptType" class="nui-hidden" value="4"/>
            	<input name="wflogs.wfOptDesc" class="nui-hidden" value="信息报送"/>
            	<input name="info.releasedDtime" class="nui-hidden" value="<%=curTime %>"/>
            	<input name="info.editor" class="nui-hidden" value="<%=userObject.getUserName() %>"/>
		        <table style="width:100%;table-layout:fixed;float:left;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label" style="width:120px;">所属栏目：</th>
		                <td colspan="5">    
		                    <span name="categoryName"><span>
		                </td>
		            </tr>        
		            <tr>
		                <th class="nui-form-label">项目名称：</th>
		                <td colspan="5">    
		                    <input name="info.infoTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">项目编号：</th>
		                <td colspan="5">    
		                    <input name="info.itemNo" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">承担单位：</th>
		                <td colspan="5">    
		                    <input name="info.itemDept" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">负责人：</th>
		                <td colspan="5">    
		                    <input name="info.itemFzr" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">年度：</th>
		                <td colspan="5">    
		                    <input name="info.itemYear" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		        </table>    
		    </div>    
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
			 <span style="display:inline-block;width:25px;"></span>
			 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
		    
	        var form = new nui.Form("form1");
	        
	        setCatgory();
	        function setCatgory(){
	        	var json = nui.encode({category:{id:<%=catId %>}});
				$.ajax({
					url:"com.cms.content.CategoryService.getCategory.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
						$("span[name=categoryName]").html(obj.category.chName);
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.info.thumbUrl = $("input[name='info.thumbUrl']").val();
		        data.wflogs.wfId = $("input[name='wflogs.wfId']").val();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.content.ContentService.addLink.biz.ext",
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
			function CloseWindow(action){
				if(action=="close"){

				}else if(window.CloseOwnerWindow)
					return window.CloseOwnerWindow(action);
				else
              	return window.close();
            }
	        function onOk(e) {
	            SaveData();
	        }
	        function onCancel(e) {
	            CloseWindow("cancel");
	        }
	    </script>
	</body>
</html>