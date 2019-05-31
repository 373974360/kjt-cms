<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-31 09:27:13
  - Description:
-->
<style type="text/css">
  @media print {
    .nui-button{
      display: none;
    }
  }
</style>
<head>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
</head>
<body>
	<div class="nui-fit" style="padding-top:5px">		
		<div id="form" method="post">
			<input id="sq.id" name="sq.id" class="nui-hidden" />
			<input name="sq.content" class="nui-hidden"/>
			<input name="sq.replyContent" class="nui-hidden"/>
			<!--startprint-->
	        <table id="table1" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">
        	 	<tr>
             		<th colspan="6" align="center" style="font-size: 23">信件内容</th>	                			                            
        		</tr> 
            	<tr>
            		<th >来信人姓名</th>
	                <td colspan="5"> 
	                    <input id="username" name="sq.username" class="nui-textbox" readonly="readonly" borderStyle="border:0" />
	                </td>
            	</tr>
            	<tr>
            		<th >来信标题</th>
	                <td colspan="5">    
	                    <input id="title" name="sq.title" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
	                </td>            	
            	</tr>
            	<tr>
            		<th >提交时间</th>
	                <td colspan="5">    
	                    <input id="createTime" name="sq.createTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" 
	                     showButton="false" readonly="readonly" borderStyle="border:0"/>
	                </td>
            	</tr>
            	<tr>
            		<th >来信内容</th>
	                <td colspan="5">    
	                	<span id="toContent"></span>
                	</td>
            	</tr>           	
	        </table>
	        <table id="table2" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">        	
            	<tr>
            		<th colspan="6" style="float:center;font-size: 23">回复内容</th>	               
            	</tr>
            	<tr>
            		<th >回复部门</th>
	            	<td colspan="5">
	            		<input id="replyOrgName" name="sq.replyOrgName" class="nui-textbox" readonly="readonly" borderStyle="border:0"/>
	            	</td>            		
            	</tr> 
            	<tr>
            		<th >回复时间</th>
	            	<td colspan="5">
	            		<input id="replyTime" name="sq.replyTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" 
	            		 showButton="false" readonly="readonly" borderStyle="border:0"/>
	            	</td>            		
            	</tr>
            	<tr>
            		<th >回复内容</th>
	                <td colspan="5">    
	                	<span id="reContent"></span>
                	</td>
            	</tr>             	   	
	        </table>
	        <!--endprint-->	        	        	       
	    </div>
	    <div align="center">
			<a id="nobtn1" class="nui-button" style="width:40px;" onclick="onPrint()">打印</a>
		</div>     
	</div>
	<div id="nobtn2" class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;">	
		 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">关闭</a>
	</div>
</body>
<script type="text/javascript">
	 	nui.parse();
		var form = new nui.Form("form");

		function setData(data) {
			data = nui.clone(data);
			var json = nui.encode(data);
			$.ajax({
					url : "com.cms.commonality.SqService.getSq.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						obj = nui.decode(text);
						$("span[id=toContent]").html(obj.sq.content);	
						$("span[id=reContent]").html(obj.sq.replyContent);				
						form.setData(obj);
						form.setChanged(false);
					}
				});
		}
		//单击打印按钮
		function onPrint(){
			document.getElementById('nobtn1').style.display='none';//不需要打印的部分隐藏
			document.getElementById('nobtn2').style.display='none';//不需要打印的部分隐藏
			
	        window.print();
	        document.getElementById('nobtn1').style.display='block';//恢复打印前的页面
	        document.getElementById('nobtn2').style.display='block';//恢复打印前的页面
	        onCancel();
	        return false;

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