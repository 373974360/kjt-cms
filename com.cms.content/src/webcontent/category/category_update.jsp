<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js">
		</script><style type="text/css">
			#selectModel table{width:100%;}
			.mini-checkboxlist-td{width:20px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="category.id" name="category.id" class="nui-hidden" />
				<input id="category.parentId" name="category.parentId" class="nui-hidden" />
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">中文名称：</th>
		                <td>    
		                    <input name="category.chName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <th class="nui-form-label">英文名称：</th>
		                <td>    
		                    <input name="category.enName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">首页模板：</th>
		                <td>    
		                    <input name="category.indexTemplet" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">列表模板：</th>
		                <td>    
		                    <input name="category.listTemplet" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">跳转地址：</th>
		                <td>    
		                    <input name="category.linkUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">栏目排序：</th>
		                <td>    
		                    <input name="category.catSort" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">关联模型：</th>
		                <td colspan=3>    
		                    <div id="selectModel" class="nui-checkboxlist" name="categoryModels.modelId" repeatItems="3" repeatLayout="table" style="width:100%;"
							    textField="modelName" valueField="modelEnName" onload="onLoad"
							    url="com.cms.siteconfig.ModelService.queryModelAll.biz.ext" dataField="data"  >
							</div>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">备注：</th>
		                <td colspan="3">    
		                    <input name="category.remark" class="nui-textbox nui-form-input"/>
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
	        	var json = nui.encode({category:data});
				$.ajax({
					url:"com.cms.content.CategoryService.getCategory.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
						var json = nui.encode(obj);
						json = json.substring(0,json.indexOf("categoryModels")-2);
						var models = obj.categoryModels;
						if(models.length>0){
							var json_1 = ',"categoryModels":{"modelId":"';
							for(var i=0;i<models.length;i++){
								json_1 += models[i].modelId+","; 
							}
							json_1 = json_1.substring(0,json_1.length-1)+'"}';
							json = json+json_1;
						}
						json = json + "}";
			            form.setData(JSON.parse(json));
			            form.setChanged(false);
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var json = nui.encode(data);
		        json = json.substring(0,json.indexOf("categoryModels")-2);
		        var modelId = data.categoryModels.modelId;
		        if(modelId!=undefined && modelId.length>0){
		        	var json_1 = ',"categoryModels":[';
			        var modelArray = modelId.split(",");
			        for(var i=0;i<modelArray.length;i++){
			        	json_1 = json_1 + '{"modelId":'+'"'+modelArray[i]+'"},';
			        }
			        json_1 = json_1.substring(0, json_1.length-1)+"]";
			        json = json+json_1;
		        }
        		json = json + "}";
	            $.ajax({
	                url: "com.cms.content.CategoryService.updateCategory.biz.ext",
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