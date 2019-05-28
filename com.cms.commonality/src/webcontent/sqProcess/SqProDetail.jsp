<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<%
	String sqProId = request.getParameter("sqProId");
 %>
<html>
<!-- 
  - Author(s): @maxiaoqiang
  - Date: 2019-05-27 10:30:41
  - Description:
-->
<head>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
</head>
<body>
	<div class="nui-fit" style="padding-top:5px">
		<div id="form1" method="post">
			<input id="sqPro.id" name="sqPro.id" class="nui-hidden" />
	        <table style="width:100%; table-layout:fixed;" class="nui-form-table">
	        	 <tr>
	             <!--   <th class="nui-form-label">处理内容：</th>-->
	                <td colspan="5">    
	                	<span id="remark"></span>
                	</td>		                			                            
            	</tr> 	
	        </table>
	    </div>
	</div>
	<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">	
		 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">关闭</a>
	</div>
</body>
<script type="text/javascript">
	 	nui.parse();
		var form = new nui.Form("form1");

		function setData(data) {
			data = nui.clone(data);
			var json = nui.encode({
				sqPro : data
			});
			$.ajax({
					url : "com.cms.commonality.SqProcess.getSqPro.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						obj = nui.decode(text);
						$("span[id=remark]").html(obj.sqPro.remark);					
						form.setData(obj);
						form.setChanged(false);
					}
				});
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