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
				<input id="source.id" name="source.id" class="nui-hidden" />
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">来源名称：</th>
		                <td>    
		                    <input name="source.sourceName" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/>
		                </td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">来源地址：</th>
		                <td>    
		                    <input name="source.sourceUrl" class="nui-textbox nui-form-input"/>
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
	        	var json = nui.encode({source:data});
				$.ajax({
					url:"com.cms.basics.SourceService.getSource.biz.ext",
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
	                url: "com.cms.basics.SourceService.updateSource.biz.ext",
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