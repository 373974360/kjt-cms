<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("catId");
	String modelId = request.getParameter("modelId");
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curTime = df.format(new Date());
	String group = request.getParameter("group");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.config.js" type="text/javascript"></script>
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.js" type="text/javascript"></script>
		<style type="text/css">
			.mini-radiobuttonlist-table{width:300px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="info.id" name="info.id" class="nui-hidden" />
				<input id="info.modelId" name="info.modelId" class="nui-hidden" value="<%=modelId %>" />
				<input id="info.inputUser" name="info.inputUser" class="nui-hidden" value="<%=userObject.getUserId() %>" />
				<input id="info.orgId" name="info.orgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>" />
				<input id="info.orgName" name="info.orgName" class="nui-hidden" value="<%=userObject.getUserOrgName() %>" />
		        <input id="info.infoStatus" name="info.infoStatus" class="nui-hidden" value="3"/>
            	<input name="wflogs.busId" class="nui-hidden"/>
            	<input name="wflogs.busUrl" class="nui-hidden"/>
            	<input name="wflogs.wfOptUser" class="nui-hidden" value="<%=userObject.getUserName() %>"/>
            	<input id="wfStepId" name="wflogs.wfStepId" class="nui-hidden" value="1"/>
            	<input name="wflogs.wfOptTime" class="nui-hidden"/>
            	<input id="wfId" name="wflogs.wfId" class="nui-hidden"/>
            	<input name="wflogs.wfOptType" class="nui-hidden" value="4"/>
            	<input name="wflogs.wfOptDesc" class="nui-hidden" value="信息报送"/>
            	<input name="info.releasedDtime" class="nui-hidden" value="<%=curTime %>"/>
            	<input name="info.editor" class="nui-hidden" value="<%=userObject.getUserName() %>"/>
		        <table style="width:100%;table-layout:fixed;float:left;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label" style="width:120px;">所属栏目：</th>
		                <td colspan="5">    
		                    <input id="catId" name="info.catId" style="width:555px;" class="mini-treeselect" url="com.cms.content.ContentService.queryInfoEditorCategoryTreeNode.biz.ext"
					    		ajaxData="{'userId':'<%=userObject.getUserId() %>'}" 
					    		multiSelect="false"  valueFromSelect="false"
					    		idField="id" textField="text" parentField="pid" onbeforenodeselect="beforenodeselect" allowInput="true"
						        showRadioButton="true" showFolderCheckBox="false" dataField="data"/>
		                </td>
		            </tr>        
		            <tr>
		                <th class="nui-form-label">项目名称：</th>
		                <td colspan="5">    
		                    <input name="info.infoTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">项目编号：</th>
		                <td colspan="5">    
		                    <input name="info.itemNo" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">承担单位：</th>
		                <td colspan="5">    
		                    <input name="info.itemDept" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">负责人：</th>
		                <td colspan="5">    
		                    <input name="info.itemFzr" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">开始年度：</th>
		                <td colspan="5">    
		                    <input name="info.itemBegintime" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">结束年度：</th>
		                <td colspan="5">    
		                    <input name="info.itemEndtime" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">计划领域：</th>
		                <td colspan="5">    
		                    <input name="info.itemJhly" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		        </table>    
		    </div>    
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:90px;" iconCls="icon-search" onclick="onView()">格式预览</a>
			 <a class="nui-button" style="width:100px;" iconCls="icon-edit" onclick="onOk(1)">保存为草稿</a>
			 <a class="nui-button" id="btn_pending" style="width:100px;" iconCls="icon-upload" onclick="onOk(2)">保存并送审</a>
			 <a class="nui-button" id="btn_publish" style="width:100px;" iconCls="icon-ok" onclick="onOk(3)">保存并发布</a>
			 <span style="display:inline-block;width:25px;"></span>
			 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
		    
	        nui.get("catId").setValue("<%=catId %>");
	        function beforenodeselect(e) {
	            //禁止选中父节点
	            if (e.isLeaf == false) e.cancel = true;
	        }
	        var form = new nui.Form("form1");
	        
	        function setCatgory(){
	        	var json = nui.encode({category:{id:<%=catId %>}});
				$.ajax({
					url:"com.cms.content.CategoryService.getCategory.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
						var json_auth = nui.encode({params:{userId:<%=userObject.getUserId() %>,funId:1021}});
						$.ajax({
							url:"com.cms.content.ContentService.queryBtnAuth.biz.ext",
							type:'POST',
					         data:json_auth,
					         cache:false,
					         contentType:'text/json',
					         success:function(text){
					         	var b = false;
								if(text.data.length>0){
									for(var j=0;j<text.data.length;j++){
										if(text.data[j].RESID=="info_publish"){
											b = true;
										}
									}
								}
								if(obj.category.workflowId==null){
									$("#pending").remove();
									$("#btn_pending").remove();
								}else{
									nui.get("wfId").setValue(obj.category.workflowId);
									var json_step = nui.encode({params:{userId:<%=userObject.getUserId() %>,workId:obj.category.workflowId}});
									$.ajax({
						                url: "com.cms.content.ContentService.queryStepIdByUser.biz.ext",
						                type: 'POST',
						                data: json_step,
						                cache: false,
						                contentType:'text/json',
						                success: function (text) {
						               		if(text!=null){
						               			console.log(text.data[0].STEP_SORT+1);
						               			nui.get("wfStepId").setValue(text.data[0].STEP_SORT+1);
						               		}
						                }
						             });
								}
								if(!b){
									$("#publish").remove();
									$("#btn_publish").remove();
								}else{
									$("#pending").remove();
									$("#btn_pending").remove();
								}
					         }
			          	});
			         }
	          	});
	        }
	        
	        function SaveData(e) {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
	        	data.info.infoStatus = e;
		        data.info.thumbUrl = $("input[name='info.thumbUrl']").val();
		        data.wflogs.wfId = $("input[name='wflogs.wfId']").val();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.content.ContentService.addLink.biz.ext",
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
	        function onView() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var json = nui.encode(data.info);
		        $.ajax({
	                url: "<%=request.getContextPath()%>/content/info/on_view.jsp",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {
	               		window.open("<%=request.getContextPath()%>/content/info/on_view_1.jsp");
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
	            SaveData(e);
	        }
	        function onCancel(e) {
	            CloseWindow("cancel");
	        }
	    </script>
	</body>
</html>