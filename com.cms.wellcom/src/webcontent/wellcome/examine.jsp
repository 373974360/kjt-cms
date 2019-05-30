<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String itemId = request.getParameter("itemId");
	String infoId = request.getParameter("infoId");
	String wfId = request.getParameter("wfId");
	String stepSort = request.getParameter("stepSort");
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="params.itemId" name="params.itemId" class="nui-hidden" value="<%=itemId %>"/>
				<input id="params.busId" name="params.busId" class="nui-hidden" value="<%=infoId %>"/>
				<input id="params.wfId" name="params.wfId" class="nui-hidden" value="<%=wfId %>"/>
				<input id="params.stepSort" name="params.stepSort" class="nui-hidden" value="<%=stepSort %>"/>
				<input id="params.wfOptType" name="params.stepSort" class="nui-hidden" value="<%=stepSort %>"/>
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">是否通过：</th>
		                <td>    
		                    <span id="tongguo"><input type="radio" name="wfOptType" value="1"/> 通过</span>
		                    <span id="bohui"><input type="radio" name="wfOptType" value="2"/> 驳回</span>
		                    <span id="fabu"><input type="radio" name="wfOptType" value="3"/> 发布</span>
		                </td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">处理意见：</th>
		                <td>    
		                   <textarea name="params.wfOptDesc" class="nui-textarea" style="width:100%;"></textarea>
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
	</body>
	<script type="text/javascript">
			nui.parse();
	        var form = new nui.Form("form1");
	        setData();
	        function setData(){
	        	var json = nui.encode({params:{userId:<%=userObject.getUserId() %>,wfId:<%=wfId %>}});
				$.ajax({
					url:"com.cms.content.WellComeService.checkUserStepNum.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
			            if(text.num==1){
			            	$("span[id='tongguo']").remove();
			            	$("span[id='fabu'] input").attr("checked",true);
			            }else{
			            	$("span[id='tongguo'] input").attr("checked",true);
			            	$("span[id='fabu']").remove();
			            }
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.params.wfOptType = $("input[name='wfOptType']:checked").val();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.content.WellComeService.examine.biz.ext",
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
</html>