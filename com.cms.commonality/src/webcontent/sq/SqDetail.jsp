<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String sqId = request.getParameter("sqId");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	// 机构条件查询
	String orgConditionQuery = ResourcesMessageUtil.getI18nResourceMessage("orgConditionQuery"); 
	// 机构代码
	String orgCode = ResourcesMessageUtil.getI18nResourceMessage("orgCode"); 
	// 机构名称
	String orgName = ResourcesMessageUtil.getI18nResourceMessage("orgName"); 
	// 机构类型
	String orgType = ResourcesMessageUtil.getI18nResourceMessage("orgType"); 
 	// 机构等级
	String orgLevel = ResourcesMessageUtil.getI18nResourceMessage("orgLevel"); 
 	// 机构层级
	String orgDegree = ResourcesMessageUtil.getI18nResourceMessage("orgDegree"); 
 	// 机构状态
	String orgStatus = ResourcesMessageUtil.getI18nResourceMessage("orgStatus"); 
%>
<style>
	#form1 input{
		border-style: 0;
	}
	#table1 td{
		height: 10px;
	    line-height: 10px;
	}
</style>
	<head>
	<%@include file="/coframe/tools/skins/common.jsp" %>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.config.js" type="text/javascript"></script>
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.min.js" type="text/javascript"></script>		
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<div id="panel1" class="nui-panel" title="来信人信息" iconCls="icon-add" style="width:100%;height:110px;" borderStyle="border:0"
    			showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
    				<input id="sq.id" name="sq.id" class="nui-hidden"/>
    				 <input name="sq.replyContent" class="nui-hidden" />
					<table id="table1" style="width:100%; table-layout:fixed;" class="nui-form-table">
						<tr>			                
			                <th class="nui-form-label">来信人姓名：</th>
			                <td colspan="1">    
			                    <input name="sq.username" class="nui-textbox nui-form-input " readonly="readonly" borderStyle="border:0" />
			                </td>
			                <th class="nui-form-label">联系地址：</th>
			                <td colspan="1">    
			                    <input name="sq.address" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/>
			                </td>			                
			            </tr>
			            <tr>
			                <th class="nui-form-label">联系电话：</th>
			                <td colspan="1">    
			                    <input name="sq.phone" class="nui-textbox nui-form-input" vtype="float" readonly="readonly" borderStyle="border:0"/>
			                </td>
			                <th class="nui-form-label">电子邮箱：</th>
			                <td colspan="1">    
			                    <input name="sq.email" class="nui-textbox nui-form-input" vtype="email;rangeLength:5,20;" readonly="readonly" borderStyle="border:0"/>
			                </td>		                
			            </tr>		           
					</table>
    			</div>
    			<div id="panel2" class="nui-panel" title="信件信息" iconCls="icon-add" style="width:100%;height:350;" 
    					showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">  				
					<table id="table2" style="width:100%; table-layout:fixed;" class="nui-form-table">
						<tr>
			                <th class="nui-form-label">来信标题：</th>
			                <td colspan="1">    
			                    <input name="sq.title" class="nui-textbox nui-form-input" readonly="readonly"  borderStyle="border:0"/> 
			                </td>
			                <th class="nui-form-label">来信目的：</th>
			                <td colspan="1"> 
			                	<input name="sq.mdId" class="nui-combobox nui-form-input" style="width:150px;" textField="mdName" valueField="id" borderStyle="border:none"
								url="com.cms.basics.LxmdService.queryLxmdName.biz.ext" dataField="data" showNullItem="true" showButton="false" readonly="readonly"/>		                    
			                </td>
			                <th class="nui-form-label">是否公开：</th>
			                <td >    
			                    <input name="sq.isOpen" class="nui-dictcombobox" style="width:50px;" dictTypeId="CMS_YESORNO" readonly="readonly" showButton="false" borderStyle="border:0"/>
			                </td>		               
		            	</tr>
			            <tr>			            	
			                <th class="nui-form-label">是否回复：</th>
			                <td >    
			                    <input name="sq.isReply" class="nui-dictcombobox "  style="width:50px;"dictTypeId="CMS_YESORNO" readonly="readonly" showButton="false" borderStyle="border:0"/>
			                </td>		              		                
			                <th class="nui-form-label">是否发布：</th>
			                <td >    
			                    <input name="sq.isPublish" class="nui-dictcombobox " style="width:50px;" dictTypeId="CMS_YESORNO" readonly="readonly" showButton="false" borderStyle="border:0"/>
			                </td>
		            	</tr>
		            	<tr>
			                <th class="nui-form-label">提交时间：</th>
			                <td colspan="1">    
			                    <input name="sq.createTime" class="nui-datepicker nui-form-input" style="width:200px;" format="yyyy-MM-dd HH:mm:ss" showTime="true" showButton="false" readonly="readonly" borderStyle="border:0"/>
			                </td>	
			                <th class="nui-form-label">回复时间：</th>
			                <td colspan="1">    
			                    <input name="sq.replyTime" class="nui-datepicker nui-form-input" style="width:200px;" format="yyyy-MM-dd HH:mm:ss" showTime="true" showButton="false" readonly="readonly" borderStyle="border:0"/>
			                </td>                
			            </tr>
			            <tr>
			                <th class="nui-form-label">来信内容：</th>
			                <td colspan="6">    
			                <span id="content"></span>
		                	</td>		                			                            
		            	</tr> 		            	        
					</table>
    			</div>    												        
		    </div>		      
		    <div id="panel3" class="nui-panel" title="处理记录" iconCls="icon-add" showToolbar="false" showFooter="false" 
		    	showCollapseButton="true" style="width: 100%; height: 48%;">	    	
				<div id="queryform" class="nui-form" align="center">
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cms.commonality.sqPro.CmsSqPro">
					<!-- 排序字段 -->
					<input class="nui-hidden" id="sqId" name="criteria/_expr[1]/sqId" value="<%=sqId %>">
					<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
				</div>		
    			<div class="nui-fit">
					<div id="datagrid1" dataField="sqProcess" class="nui-datagrid" style="width: 100%; height: 100%;" 
						url="com.cms.commonality.SqProcess.querySqProcess.biz.ext"
						pageSize="10" showPageInfo="true" multiSelect="true" allowSortColumn="false">
						<div property="columns">
							<div type="indexcolumn" width="20px">处理步骤</div>								
							<div field="id" headerAlign="center" align="center" allowSort="true" visible="false">ID</div>
							<div field="sqId" headerAlign="center" align="center" allowSort="true" visible="false">群众来信id</div>
							<div field="subOrgName" headerAlign="center" align="center" allowSort="true" renderer="onOrg">处理单位</div>
							<div field="toOrgName" headerAlign="center" align="center" allowSort="true" renderer="onOrg">转办单位</div>
							<div field="reType" headerAlign="center" align="center"allowSort="true" renderer="onReOrTo">处理类型</div>																									
							<div field="reTime" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">处理时间</div>								
						</div>
					</div>
				</div>
    		</div>		    		   
		    <div property="footer" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">		        
		        <a class="nui-button" style="width:80px;" onclick="onTo()">转办信件</a>
		        <span style="display:inline-block;width:25px;"></span>
		        <a class="nui-button" style="width:80px;" onclick="onReply()">回复信件</a>		        
			</div>
		    <div id="form3" class="nui-form" method="post">
		    	<div id="panel4" style="display:none;width: 100%; height: 100%" class="nui-panel" title="转办信件" iconCls="icon-add"  
	    			showCloseButton="true" showToolbar="false" showFooter="false">
    				<input id="sqPro.id" name="sqPro.id" class="nui-hidden"/>
    				<input id="sqPro.sqId" name="sqPro.sqId" class="nui-hidden"/>
    				<input id="sqPro.reType" name="sqPro.reType" class="nui-hidden" value = 1 />
					<table style="width:100%; table-layout:fixed;" class="nui-form-table">
						<tr>			                
			                <th class="nui-form-label">处理单位：</th>
			                <td >
								<input name="sqPro.subOrgName" textName="orgname"  class="nui-buttonedit " 
								onbuttonclick="selectOrg" allowinput="false"/>	  		                 
		                	</td>			                
			            </tr>
						<tr>			                
			                <th class="nui-form-label">转办单位：</th>
			                <td >
								<input name="sqPro.toOrgName" textName="orgname"  class="nui-buttonedit " 
								onbuttonclick="selectOrg" allowinput="false"/>	  		                 
		                	</td>			                		                
			            </tr>
			            <tr>
			                <th class="nui-form-label">转办意见：</th>
			                <td colspan="1">    
			                   	<input name="sqPro.remark" class="nui-hidden" />
		                   		<textarea id="remark1" style="height:300px;width:98%;"></textarea>
			                </td>			              		                
			            </tr>
			            <tr>
			                <th class="nui-form-label">回复时间：</th>
			                <td>    
			                    <input name="sqPro.reTime" class="nui-datepicker nui-input" style="width:15%;" format="yyyy-MM-dd HH:mm:ss" showTime="true"/>
			                </td>		                
			            </tr>		           
					</table>
					<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
						 <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
						 <span style="display:inline-block;width:25px;"></span>
						 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
					</div>
    			</div>	    		
    		</div> 
	    	<div id="form4" class="nui-form" method="post">
		    	<div id="panel5" style="display:none;width: 100%; height: 100%" class="nui-panel" title="回复信件" iconCls="icon-add"  
	    			showCloseButton="true" showToolbar="false" showFooter="false">
    				<input id="sqPro.id" name="sqPro.id" class="nui-hidden"/>
    				<input id="sqPro.reType" name="sqPro.reType" class="nui-hidden" value = 2 />
					<table style="width:100%; table-layout:fixed;" class="nui-form-table">
						<tr>			                
			                <th class="nui-form-label">处理单位：</th>			               
			                <td class="tit">
								<input name="sqPro.subOrgName" textName="orgname" class="nui-buttonedit " 
								onbuttonclick="selectOrg" allowinput="false"/>	  		                 
		                	</td>			                
			            </tr>
						<tr>			                
			                <th class="nui-form-label">回复单位：</th>
			                <td class="tit">
								<input name="sqPro.toOrgName" textName="orgname" class="nui-buttonedit " 
								onbuttonclick="selectOrg" allowinput="false" onshowButton="false"/>	  		                 
		                	</td>			                
			            </tr>
			            <tr>
			                <th class="nui-form-label">回复内容：</th>
			                <td colspan="1">    
			                   	<input name="sqPro.remark" class="nui-hidden" />
		                   		<textarea id="remark2" style="height:300px;width:98%;"></textarea>
			                </td>			              		                
			            </tr>
			            <tr>
			                <th class="nui-form-label">回复时间：</th>
			                <td colspan="1">    
			                    <input id="reTime" name="sqPro.reTime" class="nui-datepicker" style="width:15%;" format="yyyy-MM-dd HH:mm:ss" showTime="true"/>
			                </td>		                
			            </tr>		           
					</table>
					<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
						 <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOkRe()">保存</a>
						 <span style="display:inline-block;width:25px;"></span>
						 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
					</div>
    			</div>	    		
	    	</div> 	    	     
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-close" onclick="onClose()">关闭</a>
		</div>
	    <script type="text/javascript">
	    	nui.parse();
			var grid = nui.get("datagrid1");
			var formData = new nui.Form("#queryform").getData(false, false);
  	       	grid.load(formData);
	        var form = new nui.Form("form1");
	        var form3 = new nui.Form("form3");
	        var form4 = new nui.Form("form4");
			
			var data_;
			function setDataParams(data){
				data_ = nui.clone(data);
	  	       	setData();
			}  	       
			function setData() {
				var json = nui.encode({
					sq : data_
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
	    	
	    	var ue1 = UE.getEditor('remark2');
	    	var ue2 = UE.getEditor('remark1');	    	
	    	//回复信件
	    	function onReply(){
	    		$("#panel4").hide();
	    		$("#panel5").show();	    	
	    	}
	    	
			//转办信件
	    	function onTo(){
	    		$("#panel5").hide();
	    		$("#panel4").show();
	    		ue = UE.getEditor('remark1');	    		
	    	}
	    	
	    	//保存'转办记录'并刷新记录列表
	    	function SaveData() {
	           	form3.validate();
		        if(form.isValid()==false) return;
		        var data = form3.getData(false,true);
		        data.sqPro.remark = ue.getContent();
		        data.sqPro.sqId = <%=sqId %>;		        
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqProcess.addSqProcess.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {	                	
	                    onCancel();
	                    refresh();
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                    onCancel();
	                }
	            });
	        }
			
			function onOk(e) {
	            SaveData();
	        }
	    	//保存'回复记录'并更新sq表回复内容
	    	function SaveReData() {
	           	form4.validate();
		        if(form.isValid()==false) return;
		        var data = form4.getData(false,true);
		        data.sqPro.remark = ue.getContent();
		        data.sqPro.sqId = <%=sqId %>;		        
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqProcess.addSqProcess.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {	                	
	                    onCancel();
	                    refresh();
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                    onCancel();
	                }
	            });
	        }
	        //更新sq回复内容
	        function updateReData(){
	        	form.validate();
				if (form.isValid() == false)
					return;
				var data = form.getData(false, true);
				data.sq.id = <%=sqId %>;
				data.sq.replyContent = ue.getContent();
				//data.sq.replyTime = $("#reTime").val();				
				var json = nui.encode(data);
				$.ajax({
						url : "com.cms.commonality.SqService.updateSq.biz.ext",
						type : 'POST',
						data : json,
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							 onCancel();					
						},
						error : function(jqXHR, textStatus,
								errorThrown) {
							alert(jqXHR.responseText);
							onCancel();
						}
					});
	        }
			function onOkRe(){
				SaveReData();
				updateReData();
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
			
			function onCancel(){
				//表单清空
				form3.clear();
				form4.clear();
				ue1.execCommand('cleardoc');
				ue2.execCommand('cleardoc');
				$("#panel4").hide();				
				$("#panel5").hide();				
			}
			
			//处理类型字典
	    	function onReOrTo(e){
	    		return nui.getDictText('CMS_REORTO',e.value);
	    	}
	    				
			//重新刷新页面
			function refresh() {
				var form = new nui.Form("#queryform");
				var json = form.getData(false, false);
				grid.load(json);//grid查询
				nui.get("update").enable();
			}
			
			//选择机构
		    function selectOrg(e) {
		        var btnEdit = this;
		        nui.open({
		            url:  "<%=request.getContextPath() %>/coframe/org/employee/select_org_tree.jsp",
		            showMaxButton: false,
		            title: "选择机构",
		            width: 350,
		            height: 350,
		            ondestroy: function(action){
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.GetData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.orgname);
		                        btnEdit.setText(data.orgname);
		                    }
		                }
		            }
		        });            
		    }
		</script>
	</body>
</html>