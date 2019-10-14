<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String skin="skin1";
	String contextPath=request.getContextPath();
	String parentId = request.getParameter("parentId");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
			
		<script>
			(function(){
				nui.context='<%=contextPath %>'
			})();
			
			var data={};
			nui.DataTree.prototype.dataField='data';//兼容改造
		</script>
		<style type="text/css">
			#selectModel table{width:100%;}
			.mini-checkboxlist-td{width:20px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="category.id" name="category.id" class="nui-hidden" />
				<input id="category.parentId" name="category.parentId" class="nui-hidden" value="<%=parentId %>" />
				<input id="categoryModels" name="categoryModels" class="nui-hidden"/>
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
		                    <input name="category.indexTemplet" style="width:100%" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		                <th class="nui-form-label">列表模板：</th>
		                <td>    
		                	<input name="category.listTemplet" style="width:100%" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">跳转地址：</th>
		                <td>    
		                    <input name="category.linkUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">栏目排序：</th>
		                <td>    
		                    <input name="category.catSort" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">流程绑定：</th>
		                <td>    
		                	<input name="category.workflowId" class="nui-combobox" style="width:100%" textField="workName" valueField="id" url="com.cms.workflow.WorkFlowService.queryWorkFlowAll.biz.ext" dataField="data" showNullItem="true"/>
		                </td>
		                <th class="nui-form-label">栏目类型：</th>
		                <td>    
		                	<input name="category.catClass" data="data" emptyText="请选择" valueField="dictName" textField="dictName" class="nui-dictcombobox" dictTypeId="CATEGORY_TYPE" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">关键字：</th>
		                <td>    
		                    <input name="category.keywords" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">前台显示：</th>
		                <td>    
		                	<div name="category.isView" class="nui-radiobuttonlist"
							    textField="text" dataField="data" valueField="id" value="1"
							    url="<%=request.getContextPath()%>/content/category/yesNo.txt" >
							</div>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">栏目描述：</th>
		                <td colspan="3">    
		                    <textarea name="category.description" class="mini-textarea" style="width:100%"></textarea>
		                </td>
		            </tr>	 
		            <tr>
		                <th class="nui-form-label">关联模型：</th>
		                <td colspan=3>    
		                    <table style="width:100%">
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="article"/> 文章</td>
		                    		<td><input style="width:100%" name="templetId_article" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="video"/> 视频</td>
		                    		<td><input style="width:100%" name="templetId_video" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="pic"/> 组图</td>
		                    		<td><input style="width:100%" name="templetId_pic" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="link"/> 链接</td>
		                    		<td><input name="templetId_link" id="templetId_link" class="nui-hidden" value="0"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="leader"/> 领导</td>
		                    		<td><input style="width:100%" name="templetId_leader" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="doc"/> 文件</td>
		                    		<td><input style="width:100%" name="templetId_doc" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="expert"/> 专家</td>
		                    		<td><input style="width:100%" name="templetId_expert" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="download"/> 下载</td>
		                    		<td><input name="templetId_download" id="templetId_download" class="nui-hidden" value="0"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td style="width:100px;"><input type="checkbox" name="modelId" value="item"/> 项目</td>
		                    		<td><input style="width:100%" name="templetId_item" class="nui-combobox" textField="templetName" valueField="id" url="com.cms.siteconfig.TempletService.queryTempletAll.biz.ext" dataField="data" showNullItem="true" /></td>
		                    	</tr>
		                    </table>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">备注：</th>
		                <td colspan="3">    
		                    <textarea name="category.remark" class="mini-textarea" style="width:100%"></textarea>
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
		        var modelId_array = [];
		        var templetId_array = [];
		        $("input[name='modelId']:checked").each(function(){
		            modelId_array.push($(this).val());
		            templetId_array.push($("input[name='templetId_"+$(this).val()+"']").val());
		        });
		        var model_json = "[";
		        for(var i=0;i<modelId_array.length;i++){
		        	var tempId = templetId_array[i];
		        	if(tempId=="undefined"||tempId==""){
		        		tempId = 0;
		        	}
		        	if(i>0){
		        		model_json += ',{"modelId":"'+modelId_array[i]+'","templetId":"'+tempId+'"}';
		        	}else{
		        		model_json += '{"modelId":"'+modelId_array[i]+'","templetId":"'+tempId+'"}';
		        	}
		        }
		        model_json+="]";
		        data.categoryModels = JSON.parse(model_json);
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.content.CategoryService.addCategory.biz.ext",
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