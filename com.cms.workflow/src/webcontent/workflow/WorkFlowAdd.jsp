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
				<input id="workflow.id" name="workflow.id" class="nui-hidden" />
				<input id="workflow.stepNum" name="workflow.stepNum" class="nui-hidden" />
				<input id="workflow.workType" name="workflow.workType" class="nui-hidden" value="1"/>
				<input id="steps" name="steps" class="nui-hidden" />
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">工作流名称：</th>
		                <td>    
		                    <input name="workflow.workName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">描述：</th>
		                <td>    
		                    <input name="workflow.workRemark" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">步骤：</th>
		                <td>    
		                    <a class="nui-button" iconCls="icon-add" onclick="addStep()">增加步骤 </a>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label"></th>
		                <td>    
		                    <table id="stepHtml"></table>
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
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var stepName_array = [];
		        $("input[name='stepName']").each(function(){
		            stepName_array.push($(this).val());
		        });
		        var stepRole_array = [];
		        $("select[name='stepRole']").each(function(){
		            stepRole_array.push($(this).val());
		        });
		        var steps_json = "[";
		        for(var i=0;i<stepName_array.length;i++){
		        	if(i>0){
		        		steps_json += ',{"stepName":"'+stepName_array[i]+'","stepRole":"'+stepRole_array[i]+'","stepSort":"'+(i+1)+'"}';
		        	}else{
		        		steps_json += '{"stepName":"'+stepName_array[i]+'","stepRole":"'+stepRole_array[i]+'","stepSort":"'+(i+1)+'"}';
		        	}
		        }
		        steps_json+="]";
		        data.steps = JSON.parse(steps_json);
		        data.workflow.stepNum = stepRole_array.length;
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.workflow.WorkFlowService.addWorkFlow.biz.ext",
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
	        
	        var stepNum = 1;
	        function addStep(){
	        	var _html = "<tr id='step_"+stepNum+"'>"+ 
	        	"<td name='stepIndex' width='45' style='padding-right:0px;'>第"+stepNum+"步：</td>"+
	        	"<td><input name='stepName' class='nui-textbox nui-form-input' value='步骤名称'/></td>"+
	        	"<td><select name='stepRole'></select></td>"+
	        	"<td><a class='nui-button icon-remove' onclick='removeStep("+stepNum+")' style='padding-left:20px;'>删除</a></td>"+
		        "</tr>";
	        	$("#stepHtml").append(_html);
	        	$.ajax({
	                url: "org.gocom.components.coframe.rights.RoleManager.queryAuthorizedRole.biz.ext",
	                type: 'POST',
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {
	                    $("select[name='stepRole']").each(function(index){
	                    	if(index==$("select[name='stepRole']").length-1){
		                    	for(var i=0;i<text.data.length;i++){
									$(this).append("<option value='"+text.data[i].roleId+"'>"+text.data[i].roleName+"</option>");
		                    	}
	                    	}
						});
	                }
	            });
	        	stepNum++;
	        }
	        function removeStep(step){
	        	$("#step_"+step).remove();
	        	$("td[name='stepIndex']").each(function(index){
					$(this).html("第"+(index+1)+"步：");
				});
	        	stepNum = stepNum-1;
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