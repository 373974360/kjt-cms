<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
				<input id="sq.id" name="sq.id" class="nui-hidden" />
		        <table style="width:100%; table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">来信标题：</th>
		                <td>    
		                    <input name="sq.title" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <th class="nui-form-label">来信人姓名：</th>
		                <td>    
		                    <input name="sq.username" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">联系地址：</th>
		                <td>    
		                    <input name="sq.address" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <th class="nui-form-label">联系电话：</th>
		                <td>    
		                    <input name="sq.phone" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">电子邮箱：</th>
		                <td>    
		                    <input name="sq.email" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		               	<th class="nui-form-label">受理部门：</th>
		                <td>    
		                    <input name="sq.subOrgName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">是否回复：</th>
		                <td>    
		                    <input name="sq.isReply" class="nui-dictcombobox" dictTypeId="CMS_REYESNO" required="true"/>
		                </td>
		                <th class="nui-form-label">回复部门：</th>
		                <td>    
		                    <input name="sq.replyOrgName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">是否公开：</th>
		                <td>    
		                    <input name="sq.isOpen" class="nui-dictcombobox" dictTypeId="CMS_OPENYESNO" required="true"/>
		                </td>
		                <th class="nui-form-label">是否发布：</th>
		                <td>    
		                    <input name="sq.isPublish" class="nui-dictcombobox" dictTypeId="CMS_PUBYESNO" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">提交时间：</th>
		                <td>    
		                    <input name="sq.createTime" class="nui-datepicker" format="yyyy-MM-dd HH:mm:ss" required="true"/>
		                </td>	
		                <th class="nui-form-label">回复时间：</th>
		                <td>    
		                    <input name="sq.replyTime" class="nui-datepicker" format="yyyy-MM-dd HH:mm:ss" required="true"/>
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
	        
	        function setData(data){
	        	data = nui.clone(data);
	        	var json = nui.encode({sq:data});
				$.ajax({
					url:"com.cms.commonality.SqService.getSq.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
			            form.setData(obj);
			            form.setChanged(false);
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqService.updateSq.biz.ext",
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