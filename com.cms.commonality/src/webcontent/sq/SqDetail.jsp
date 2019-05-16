<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
			<div id="form1" method="post"  readonly="readonly">
				<input id="sq.id" name="sq.id" class="nui-hidden"/>
		        <table style="width:100%; table-layout:fixed;" class="nui-form-table">
		            <tr>
		                <th class="nui-form-label">来信标题：</th>
		                <td colspan="2">    
		                    <input name="sq.title" class="nui-textbox nui-form-input" readonly="readonly"/> 
		                </td>
		                <th class="nui-form-label">来信人姓名：</th>
		                <td colspan="2">    
		                    <input name="sq.username" class="nui-textbox nui-form-input" readonly="readonly"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">联系地址：</th>
		                <td colspan="2">    
		                    <input name="sq.address" class="nui-textbox nui-form-input" readonly="readonly"/>
		                </td>
		                <th class="nui-form-label">联系电话：</th>
		                <td colspan="2">    
		                    <input name="sq.phone" class="nui-textbox nui-form-input" vtype="float" readonly="readonly"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">电子邮箱：</th>
		                <td colspan="2">    
		                    <input name="sq.email" class="nui-textbox nui-form-input" vtype="email;rangeLength:5,20;" readonly="readonly"/>
		                </td>		               
		            </tr>
		            <tr>
		            	<th class="nui-form-label">受理部门：</th>
		                <td colspan="2">
		                	<input name="sq.subOrgName" class="nui-combobox nui-form-input" style="width:150px;" textField="orgName" valueField="orgCode"
								url="com.cms.commonality.OrganizationService.queryOrgName.biz.ext" dataField="data" showNullItem="true" readonly="readonly"/>	    		                 
		                </td>
		            	<th class="nui-form-label">回复部门：</th>
		                <td colspan="2"> 
		                	<input name="sq.replyOrgName" class="nui-combobox nui-form-input" style="width:150px;" textField="orgName" valueField="orgCode"
								url="com.cms.commonality.OrganizationService.queryOrgName.biz.ext" dataField="data" showNullItem="true" readonly="readonly"/>   		                    
		                </td>
		            </tr>
		            <tr>
		            	<th class="nui-form-label">来信目的：</th>
		                <td colspan="2"> 
		                	<input name="sq.mdId" class="nui-combobox nui-form-input" style="width:150px;" textField="mdName" valueField="id"
								url="com.cms.basics.LxmdService.queryLxmdName.biz.ext" dataField="data" showNullItem="true" readonly="readonly"/>		                    
		                </td>
		                <th class="nui-form-label">是否回复：</th>
		                <td colspan="2">    
		                    <input name="sq.isReply" class="nui-dictcombobox nui-form-input" dictTypeId="CMS_YESORNO" readonly="readonly"/>
		                </td>		              
		            </tr>
		            <tr>
		                <th class="nui-form-label">是否公开：</th>
		                <td colspan="2">    
		                    <input name="sq.isOpen" class="nui-dictcombobox nui-form-input" dictTypeId="CMS_YESORNO" readonly="readonly"/>
		                </td>
		                <th class="nui-form-label">是否发布：</th>
		                <td colspan="2">    
		                    <input name="sq.isPublish" class="nui-dictcombobox nui-form-input" dictTypeId="CMS_YESORNO" readonly="readonly"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">提交时间：</th>
		                <td colspan="2">    
		                    <input name="sq.createTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" showTime="true" readonly="readonly"/>
		                </td>	
		                <th class="nui-form-label">回复时间：</th>
		                <td colspan="2">    
		                    <input name="sq.replyTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" showTime="true" readonly="readonly"/>
		                </td>                
		            </tr>
		            <tr>
		                <th class="nui-form-label">来信内容：</th>
		                <td colspan="6">    
		                	<span id="content"></span>
		                </td>		                			                            
		            </tr>
		            <!--<tr>
			            <th class="nui-form-label">回复内容：</th>
		                <td colspan="6">
		              
		                	<span id="replyContent"></span> 
		                  
		                </td> 
		            </tr>	  -->       
		        </table>    
		    </div>    
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-close" onclick="onClose()">关闭</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
	        var form = new nui.Form("form1");
  	       
			function setData(data) {
				data = nui.clone(data);
				var json = nui.encode({
					sq : data
				});
				$.ajax({
						url : "com.cms.commonality.SqService.getSq.biz.ext",
						type : 'POST',
						data : json,
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							obj = nui.decode(text);						
							$("span[id=content]").html(obj.sq.content);						
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
			
			function onClose(e) {
				CloseWindow("cancel");
			}
		</script>
	</body>
</html>