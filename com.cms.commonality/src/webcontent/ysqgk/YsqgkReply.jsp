<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<html>
<!-- 
  - Author(s): @maxiaoqiang
  - Date: 2019-06-05 16:11:31
  - Description:
-->
<%
	String ysqgkId = request.getParameter("ysqgkId");

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curTime = df.format(new Date());

 %>
<head>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
</head>
<body>
	<div class="nui-fit" style="padding-top:5px">
		<div id="form1" method="post">
			<input id="ysqgk.id" name="ysqgk.id" class="nui-hidden">
			<input id="ysqgk.isReply" name="ysqgk.isReply" class="nui-hidden" value="1">
	        <table style="width:100%; table-layout:fixed;" class="nui-form-table">
	        	<tr>			            	
		            <th class="nui-form-label">是否公开：</th>
	                <td > 
	                	<div name="ysqgk.isOpen" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOrNot" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOrNot.txt" >
						</div>   
	                </td>
	             <tr/>
	             <tr class="odd">
	                <th class="nui-form-label">是否发布：</th>
	                <td > 
	                	<div name="ysqgk.isPublish" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOrNot" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOrNot.txt" >
						</div>    	                	
                	</td>
            	</tr>
	            <tr>
	                <th class="nui-form-label">回复内容：</th>
	                <td colspan="1">    
	                  <input name="ysqgk.replyContent" class="nui-textarea" 
	                  required="true" requiredErrorText="不能为空" style="width:90%;height:100px"/>
	                </td>			              		                
	            </tr>
	            <tr class="odd">
	                <th class="nui-form-label">回复时间：</th>
	                <td colspan="1">    
	                    <input id="ysqgk.replyDtime" name="ysqgk.replyDtime" class="nui-datepicker " style="width:26%;" 
	                    format="yyyy-MM-dd HH:mm:ss" showTime="true" allowinput="false" 
	                    value="<%=curTime %>" required="true" requiredErrorText="请选择时间"/>
	                </td>		                
	            </tr>		     	
	        </table>
	    </div>
	</div>
	<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">	
		 <a class="nui-button" style="width:60px;" iconCls="icon-edit" onclick="onOk()">回复</a>
		 <span style="display:inline-block;width:25px;"></span>
		 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
	</div>
</body>
<script type="text/javascript">
	 	nui.parse();
		var form = new nui.Form("form1");

		function SaveData() {
			form.validate();
			if (form.isValid() == false)
				return;
			var data = form.getData(false, true);
			data.ysqgk.id = "<%=ysqgkId %>";				
			var json = nui.encode(data);
			$.ajax({
					url : "com.cms.commonality.YsqgkService.UpdateYsqgkWithReTime.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						CloseWindow("saveSuccess");
					},
					error : function(jqXHR, textStatus,
							errorThrown) {
						alert(jqXHR.responseText);
						CloseWindow();
					}
				});
		}
		
		function onOk(e) {
            SaveData();
        }
		
		function CloseWindow(action) {
			if (action == "close") {
			} else if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
		
		function onCancel(e) {
			CloseWindow("cancel");
		}

</script>
</html>