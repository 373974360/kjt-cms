<%@page import="com.cms.view.velocity.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String currTime = DateUtil.getCurrentDate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.config.js" type="text/javascript"></script>
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.min.js" type="text/javascript"></script>
	</head>
	<body>
        <div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="survey.id" name="survey.id" class="nui-hidden" />
				<input id="survey.isPublish" name="survey.isPublish" class="nui-hidden" value="1"/>
                <input id="survey.content" name="survey.content" class="nui-hidden"/>
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">问卷标题：</th>
		                <td>    
		                    <input name="survey.title" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">开始时间：</th>
		                <td>    
		                    <input name="survey.startTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd"  required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">截止时间：</th>
		                <td>    
		                    <input name="survey.endTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">重复提交间隔：</th>
		                <td>    
		                    <input name="survey.submitDay" class="nui-textbox nui-form-input" value="0"/>
		                </td>
		                <td>单位：天;</td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">同IP重复提交次数：</th>
		                <td>    
		                    <input name="survey.submitNum" class="nui-textbox nui-form-input" value="1"/>
		                </td>
		                <td>注：输入0值不限制重复提交次数</td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">文字描述：</th>
		                <td colspan="2">    
		                	<textarea id="content" style="height:300px;width:98%;"></textarea>
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
	        var form1 = new nui.Form("form1");
	        var ue = UE.getEditor('content');
	        function SaveData() {
	           	form1.validate();
		        if(form1.isValid()==false) return;
		        var data1 = form1.getData(false,true);
		        data1.survey.content = ue.getContent();
		        
	        	var startTime = new Date(data1.survey.startTime).getTime();
	        	var endTime = new Date(data1.survey.endTime).getTime();
	        	if(startTime>=endTime){
	        		nui.alert("截止日期不能小于开始日期", "提示");
	        		return;
	        	}
	        	var currTime = new Date('<%=currTime %>').getTime();
	        	if(endTime>currTime){
	        		data1.survey.isEnd = 1;
	        	}else{
	        		data1.survey.isEnd = 0;
	        	}
		        var json1 = nui.encode(data1);
	           	$.ajax({
	                url: "com.cms.commonality.SurveyService.addSurvey.biz.ext",
	                type: 'POST',
	                data: json1,
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