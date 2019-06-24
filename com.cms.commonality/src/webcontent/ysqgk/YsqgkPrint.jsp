<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-06 09:54:36
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
			<input id="ysqgk.id" name="ysqgk.id" class="nui-hidden" />
			<div>
		        <table id="table1" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">
	        	 	<tr>
	             		<th colspan="6" align="center" style="font-size: 23">申请内容</th>	                			                            
	        		</tr>
	        		<tr>
						<th >申请编号</th>
		                <td colspan="5">    
		                    <input name="ysqgk.ysqCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:none" /> 
		                </td>
	            	</tr>
	        	</table> 
	        	<table id="table2" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">
					<tr>
		                <th>申请人姓名</th>
		                <td colspan="5">    
		                    <input name="ysqgk.name" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0" /> 
		                </td>
		            </tr>
		        </table>
		        <table id="table3" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">
		        	<tr>
		                <th>组织机构代码</th>
		                <td colspan="5">    
		                    <input name="ysqgk.orgCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>
		            </tr>
		        </table>
	        	<table id="table4" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">
					<tr>
						<th >是否申请减免费用</th>
    					<td colspan="5">
    						<input name="ysqgk.isDerate" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOrNot" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOrNot.txt"
		    					showButton="false" readonly="readonly" />
    					</td>
					</tr>  
					<tr>
						<th >信息指定提供方式</th>
    					<td colspan="5">
    						<input name="ysqgk.offerType" class="nui-checkboxlist" textField="text" 
		    					dataField="offerType" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/offerType.txt" readonly="readonly"/>							
    					</td>
					</tr> 
					<tr>
						<th >获取信息方式</th>
    					<td colspan="5">
    						<input name="ysqgk.getMethod" class="nui-checkboxlist" textField="text" 
		    					dataField="getMethod" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/getMethod.txt" readonly="readonly"/>						
    					</td>
					</tr> 
					<tr>
						<th >是否接受其他方式</th>
    					<td colspan="5">
    						<input name="ysqgk.isOther" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOrNot" valueField="id" value="1" 
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOrNot.txt" readonly="readonly"/>					
    					</td>
					</tr> 			        	
	            	<tr>
	            		<th >提交时间</th>
		                <td colspan="5"> 
		                    <input id="createDtime" name="ysqgk.createDtime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" 
		                     showButton="false" readonly="readonly" borderStyle="border:0"/> 
		                </td>            	
	            	</tr>
	            	<tr>
	            		<th >所需内容</th>
		                <td colspan="5">    
		                	<span id="Content"></span>
	                	</td>
	            	</tr>  
	            	<tr>
	            		<th >用途描述</th>
		                <td colspan="5">    
		                	<span id="description"></span>
	                	</td>
	            	</tr>          	
		        </table>
	        </div>
	        <br />
	        <div>
		        <table id="table2" border="1" style="width:98%; table-layout:fixed;" align="center" class="nui-form-table">        	
	            	<tr>
	            		<th colspan="6" style="float:center;font-size: 23">回复内容</th>	               
	            	</tr>	            	
	            	<tr>
	            		<th >回复时间</th>
		            	<td colspan="5">
		            		<input id="replyDtime" name="ysqgk.replyDtime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" 
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
	        </div>	        	        	       
	    </div>    
	</div>
	<div id="nobtn1" class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;">	
		<a class="nui-button" style="width:60px;" iconCls="icon-print" onclick="onPrint()">打印</a>
		<span style="display:inline-block;width:25px;"></span>
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
					url : "com.cms.commonality.YsqgkService.getYsqgk.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						obj = nui.decode(text);
						onSelected(obj.ysqgk.ysqType);	
						$("span[id=Content]").html(obj.ysqgk.content);	
						$("span[id=description]").html(obj.ysqgk.description);	
						$("span[id=reContent]").html(obj.ysqgk.replyContent);			
						form.setData(obj);
						form.setChanged(false);
					}
				});
		}
		//单击打印按钮
		function onPrint(){
			document.getElementById('nobtn1').style.display='none';//不需要打印的部分隐藏
			
			
			$('div').css({
			   'height' : 'auto', //高度自动
			   'overflow' : 'visible' //在打印之前把div的overflow改成全部显示
			});
			
	        window.print();
	        document.getElementById('nobtn1').style.display='block';//恢复打印前的页面
	       
	        onCancel();
	        return false;

		}
		
		//申请人类型不同时的页面展示处理
	        function onSelected(obj){	        	
	        	if(obj == 2){	        		
	        		$("#table2").hide();
	        		$("#table3").show();
	        	}else{
	        		$("#table2").show();
	        		$("#table3").hide();	
	        	}
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