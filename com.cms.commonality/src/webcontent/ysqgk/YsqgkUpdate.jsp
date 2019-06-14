<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	
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
			<div id="panel1" class="nui-panel" title="申请人信息" iconCls="icon-add" style="width:100%;height:260px;" 
			showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
				<input id="ysqgk.id" name="ysqgk.id" class="nui-hidden">
				<input name="ysqgk.createDtime" class="nui-hidden" />
				<input id="ysqType" name="ysqgk.ysqType" class="nui-hidden"/>
				<table id="table1" align="center" style="width:90%; table-layout:fixed;" class="nui-form-table">
					<tr>
						<th class="nui-form-label">申请编号：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.ysqCode" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空" onvalidation="onEnglishAndNumberValidation"/> 
		                </td>
		                <th class="nui-form-label">查询密码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.queryCode" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>
					</tr>  					    				
				</table>
				<table id="table2" align="center" style="width:90%; table-layout:fixed;" class="nui-form-table">
					<tr class="odd">
		                <th class="nui-form-label">申请人姓名：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.name" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	
		                <th class="nui-form-label">工作单位：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.orgName" class="nui-textbox nui-form-input"/> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">证件名称：</th>
		                <td colspan="2">                     
		                    <input name="ysqgk.cardName" class="nui-combobox nui-form-input" style="width:150px;" 
		                    dataField="cardName" textField="text" valueField="id" 
							url="<%=request.getContextPath()%>/commonality/ysqgk/cardName.txt"  
							showNullItem="true" allowInput="false"/> 
		                </td>	
		                <th class="nui-form-label">证件号码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.cardCode" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空" onvalidation="onIDCardsValidation"/> 
		                </td>	                
	            	</tr>
	            </table>
	            <table id="table3" align="center" style="width:90%; table-layout:fixed; display: none;" class="nui-form-table">
	            	<tr class="odd">
		                <th class="nui-form-label">组织机构代码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.orgCode" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	
		                <th class="nui-form-label">营业执照代码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.licence" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">法人代表：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.legalperson" class="nui-textbox nui-form-input" /> 
		                </td>	
		                <th class="nui-form-label">联系人：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.linkman" class="nui-textbox nui-form-input" /> 
		                </td>	                
	            	</tr>
	            </table>
	            <table id="table4" align="center" style="width:90%; table-layout:fixed;" class="nui-form-table">
	            	<tr class="odd">
		                <th class="nui-form-label">联系电话：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.tel" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	
		                <th class="nui-form-label">联系传真：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.telCz" class="nui-textbox nui-form-input" /> 
		                </td>	                
	            	</tr>
	            	<tr>
		                <th class="nui-form-label">手机号码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.mobile" class="nui-textbox nui-form-input" /> 
		                </td>	
		                <th class="nui-form-label">电子邮箱：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.email" class="nui-textbox nui-form-input" /> 
		                </td>	                
	            	</tr>
	            	<tr class="odd">
		                <th class="nui-form-label">通讯地址：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.address" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	
		                <th class="nui-form-label">邮政编码：</th>
		                <td colspan="2">    
		                    <input name="ysqgk.yzbm" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>	                
	            	</tr>
				</table>
			</div>	
			<div id="panel2" class="nui-panel" title="所需信息情况" iconCls="icon-add" style="width:100%;height:350;" 
			showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
				<table id="table5" align="center" style="width:90%; table-layout:fixed;" class="nui-form-table">
					<tr class="odd">
						<th class="nui-form-label">所需内容描述：</th>
						<td>
							<input name="ysqgk.content" class="nui-textarea" style="width:90%;height:80px"/>
    					</td>
					</tr>   
					<tr>
						<th class="nui-form-label">用途描述：</th>
						<td>
							<input name="ysqgk.description" class="nui-textarea" style="width:90%;height:80px"/>
    					</td>
					</tr>
					<tr class="odd">
						<th class="nui-form-label">是否申请减免费用：</th>
    					<td>
    						<div name="ysqgk.isDerate" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isDerate" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isDerate.txt" >
							</div>
    					</td>
					</tr>  
					<tr>
						<th class="nui-form-label">信息指定提供方式：</th>
    					<td>
    						<div name="ysqgk.offerType" class="nui-radiobuttonlist" textField="text" 
		    					dataField="offerType" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/offerType.txt" >
							</div>
    					</td>
					</tr> 
					<tr class="odd">
						<th class="nui-form-label">获取信息方式：</th>
    					<td>
    						<div name="ysqgk.getMethod" class="nui-radiobuttonlist" textField="text" 
		    					dataField="getMethod" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/getMethod.txt" >
							</div>
    					</td>
					</tr> 
					<tr>
						<th class="nui-form-label">是否接受其他方式：</th>
    					<td>
    						<div name="ysqgk.isOther" class="nui-radiobuttonlist" textField="text" 
		    					dataField="isOther" valueField="id" value="1"
		    					url="<%=request.getContextPath()%>/commonality/ysqgk/isOther.txt" >
							</div>
    					</td>
					</tr> 					    				
				</table>
			</div>
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
							form.setData(obj);
							form.setChanged(false);
						}
					});
			}

			function SaveData() {
				form.validate();
				if (form.isValid() == false)
					return;
				var data = form.getData(false, true);					
				var json = nui.encode(data);
				$.ajax({
						url : "com.cms.commonality.YsqgkService.updateYsqgk.biz.ext",
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
	        //身份证号验证
	        function onIDCardsValidation(e){
	        	if(e.isValid){
	        		if (e.value.length < 15 || e.value.length > 18 || isIdentity(e.value) == false) {		        		
		        			e.errorText = "请输入正确身份证号";
	                    	e.isValid = false;		        		
		        	}
	        	}
	        }	        
	        function isIdentity(v){	        	
		        	var re = new RegExp("^([0-9]){7,18}(x|X)?$");
	            	if (re.test(v)) {
	            		return true;
	            	}else{
	            		return false;
	            	}
	            		            
	        }
	        //申请编号验证
	        function onEnglishAndNumberValidation(e){
	        	if (e.isValid) {
	                if (isEnglishAndNumber(e.value) == false) {
	                    e.errorText = "请输入正确编号";
	                    e.isValid = false;
	                }
            	}
	        }
	         /* 是否英文+数字 */
        	function isEnglishAndNumber(v) {           
	            var re = new RegExp("^[0-9a-zA-Z\_]+$");
	            if (re.test(v)) return true;
	            return false;
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