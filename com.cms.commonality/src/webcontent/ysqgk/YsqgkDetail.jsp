<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	String ysqgkId = request.getParameter("ysqgkId");
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curTime = df.format(new Date());
	
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");

%>

<head>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>	
</head>
<body>
	<div class="nui-fit" style="padding-top:5px">
		<div id="form1" method="post">
			<div id="panel1" class="nui-panel" title="申请人信息" iconCls="icon-add" style="width:100%;height:250px;" 
			showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
				<input id="ysqgk.id" name="ysqgk.id" class="nui-hidden">
				<input name="ysqgk.createDtime" class="nui-hidden" />
				<input id="ysqType" name="ysqgk.ysqType" class="nui-hidden"/>
				<table id="table1" style="width:70%; table-layout:fixed;">
					<tr>
						<th class="nui-form-label">申请编号：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.ysqCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:none" /> 
		                </td>
		                <th class="nui-form-label">查询密码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.queryCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0" /> 
		                </td>
					</tr>  					    				
				</table>
				<table id="table2" style="width:70%; table-layout:fixed;">
					<tr>
		                <th class="nui-form-label">申请人姓名：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.name" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0" /> 
		                </td>	
		                <th class="nui-form-label">工作单位：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.orgName" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0" /> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">证件名称：</th>
		                <td colspan="2">                     
		                    <input name="ysqgk.cardName" class="nui-combobox nui-form-input" style="width:150px;" 
		                    dataField="cardName" textField="text" valueField="id" 
							url="<%=request.getContextPath()%>/commonality/ysqgk/cardName.txt"  
							showNullItem="true" allowInput="true" borderStyle="border:none"
							 showButton="false" readonly="readonly" /> 
		                </td>	
		                <th class="nui-form-label">证件号码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.cardCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
	            </table>
	            <table id="table3" style="width:70%; table-layout:fixed; display: none;">
	            	<tr>
		                <th class="nui-form-label">组织机构代码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.orgCode" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	
		                <th class="nui-form-label">营业执照代码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.licence" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">法人代表：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.legalperson" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	
		                <th class="nui-form-label">联系人：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.linkman" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
	            </table>
	            <table id="table4" style="width:70%; table-layout:fixed;">
	            	<tr>
		                <th class="nui-form-label">联系电话：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.tel" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	
		                <th class="nui-form-label">联系传真：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.telCz" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">手机号码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.mobile" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	
		                <th class="nui-form-label">电子邮箱：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.email" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">通讯地址：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.address" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	
		                <th class="nui-form-label">邮政编码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.yzbm" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/> 
		                </td>	                
	            	</tr>
				</table>
			</div>	
			<div id="panel2" class="nui-panel" title="所需信息情况" iconCls="icon-add" style="width:100%;height:350;" 	
    					showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
				<table id="table5" style="width:70%; table-layout:fixed;">
					<tr>
						<th class="nui-form-label">所需内容描述：</th>
						<td>
						<span id="content"></span>							
    					</td>
					</tr>   
					<tr>
						<th class="nui-form-label">用途描述：</th>
						<td>
						<span id="DesContent"></span>
    					</td>
					</tr>
					<tr>
						<th class="nui-form-label">是否申请减免费用：</th>
    					<td>
    						<input name="ysqgk.isDerate" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isDerate" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isDerate.txt"
		    					showButton="false" readonly="readonly" />
    					</td>
					</tr>  
					<tr>
						<th class="nui-form-label">信息指定提供方式：</th>
    					<td>
    						<input name="ysqgk.offerType" class="nui-radiobuttonlist" textField="text" 
		    					dataField="offerType" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/offerType.txt" readonly="readonly"/>							
    					</td>
					</tr> 
					<tr>
						<th class="nui-form-label">获取信息方式：</th>
    					<td>
    						<input name="ysqgk.getMethod" class="nui-radiobuttonlist" textField="text" 
		    					dataField="getMethod" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/getMethod.txt" readonly="readonly"/>						
    					</td>
					</tr> 
					<tr>
						<th class="nui-form-label">是否接受其他方式：</th>
    					<td>
    						<input name="ysqgk.isOther" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOther" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOther.txt" readonly="readonly"/>					
    					</td>
					</tr> 					    				
				</table>
			</div>
			<div property="footer" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">		        
		        <a class="nui-button" style="width:85px;" iconCls="icon-edit" onclick="onReply()">回复申请</a>
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-print" onclick="onPrint()">打印详情</a>		        
			</div>
		</div> 
	</div>
	<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">		 
		 <a class="nui-button" style="width:60px;" iconCls="icon-close" onclick="onCancel()">关闭</a>
	</div>
    <script type="text/javascript">
	        nui.parse();
	        var form = new nui.Form("form1");	        	      	
	     
			function setData(data) {
				data = nui.clone(data);				
				var json = nui.encode({
					ysqgk : data
				});
				$.ajax({
						url : "com.cms.commonality.YsqgkService.getYsqgk.biz.ext",
						type : 'POST',
						data : json,
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							obj = nui.decode(text);
							//区别申请人列表
							onSelected(obj.ysqgk.ysqType);	
							$("span[id=content]").html(obj.ysqgk.content);	
							$("span[id=DesContent]").html(obj.ysqgk.description);											
							form.setData(obj);
							form.setChanged(false);
						}
					});
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
	       	//回复申请弹出框	
	        function onReply(){
	        	nui.open({
						url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkReply.jsp?ysqgkId="+"<%=ysqgkId %>",
						title : "回复",
						width : '60%',
						height : '70%',
						onload : function() {						
						}
					});		
	        }    
	        //打印详页 
	        function onPrint(){
	        	var data = form.getData(false,true);
	        	nui.open({
						url : "<%=request.getContextPath()%>/commonality/ysqgk/YsqgkPrint.jsp",
						title : "打印",
						width : '80%',
						height : '100%',
						onload : function() {
							var iframe = this.getIFrameEl();						
							//直接从页面获取，不用去后台获取
							iframe.contentWindow.setData(data);							
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