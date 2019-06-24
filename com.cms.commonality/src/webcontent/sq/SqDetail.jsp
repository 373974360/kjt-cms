<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>

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
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String sqId = request.getParameter("sqId");
	String isPublish = request.getParameter("isPublish");
	String isOpen = request.getParameter("isOpen");
	Integer reType1 = 1;//处理类型-转办
	Integer reType2 = 2;//处理类型-回复
	
	Integer isReply = 1;//是否回复-是
	
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	
%>

	<head>		
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.config.js" type="text/javascript"></script>
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.min.js" type="text/javascript"></script>		
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<div id="panel1" class="nui-panel" title="来信人信息" iconCls="icon-add" style="width:100%;height:110px;" 
    			showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
    				<input id="sq.id" name="sq.id" class="nui-hidden"/>
    				<input name="sq.replyContent" class="nui-hidden"/>
    				<input name="sq.replyOrgId" class="nui-hidden"/>
    				<input name="sq.replyOrgName" class="nui-hidden"/>
    				<input name="sq.subOrgId" class="nui-hidden"/>
    				<input name="sq.subOrgName" class="nui-hidden"/>    				
					<table id="table1" align="center" style="width:90%; table-layout:fixed;" border="0">
						<tr>			                
			                <th class="nui-form-label">来信人姓名：</th>
			                <td >    
			                    <input name="sq.username" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0" />
			                </td>
			                <th class="nui-form-label">联系地址：</th>
			                <td>    
			                    <input name="sq.address" class="nui-textbox nui-form-input" readonly="readonly" borderStyle="border:0"/>
			                </td>			                
			            </tr>
			            <tr>
			                <th class="nui-form-label">联系电话：</th>
			                <td >    
			                    <input name="sq.phone" class="nui-textbox nui-form-input"  readonly="readonly" borderStyle="border:0"/>
			                </td>
			                <th class="nui-form-label">电子邮箱：</th>
			                <td >    
			                    <input name="sq.email" class="nui-textbox nui-form-input"  readonly="readonly" borderStyle="border:0"/>
			                </td>		                
			            </tr>		           
					</table>
    			</div>
    			<div id="panel2" class="nui-panel" title="信件信息" iconCls="icon-add" style="width:100%;height:350;" 
    					showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">  				
					<table id="table2" align="center" style="width:90%; table-layout:fixed;" border="0">
						<tr>
			                <th class="nui-form-label">来信标题：</th>
			                <td colspan="1">    
			                    <input name="sq.title" class="nui-textbox nui-form-input" readonly="readonly"  borderStyle="border:0"/> 
			                </td>
			                <th class="nui-form-label">来信目的：</th>
			                <td colspan="1"> 
			                	<input name="sq.mdId" class="nui-combobox nui-form-input" textField="mdName" valueField="id" borderStyle="border:none"
								url="com.cms.basics.LxmdService.queryLxmdName.biz.ext" dataField="data" showNullItem="true" showButton="false" readonly="readonly"/>		                    
			                </td>
			                <th class="nui-form-label">是否公开：</th>
			                <td >    
			                    <input name="sq.isOpen" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    	textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt" readonly="readonly" showButton="false" borderStyle="border:0"/>
			                </td>		               
		            	</tr>
			            <tr>			            	
			                <th class="nui-form-label">是否回复：</th>
			                <td >
			                	<input name="sq.isReply" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    	textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt" readonly="readonly" showButton="false" borderStyle="border:0"/> 
			                 
			                </td>		              		                
			                <th class="nui-form-label">是否发布：</th>
			                <td >    
			                    <input name="sq.isPublish" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    	textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt" readonly="readonly" showButton="false" borderStyle="border:0"/>
			                </td>
		            	</tr>
		            	<tr>
			                <th class="nui-form-label">提交时间：</th>
			                <td colspan="1">    
			                    <input name="sq.createTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" showTime="true" showButton="false" readonly="readonly" borderStyle="border:0"/>
			                </td>	
			                <th class="nui-form-label">回复时间：</th>
			                <td colspan="1">    
			                    <input name="sq.replyTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" showTime="true" showButton="false" readonly="readonly" borderStyle="border:0"/>
			                </td>                
			            </tr>
			            <tr>
			                <th class="nui-form-label">来信内容：</th>
			                <td colspan="5">    
			                <span id="content"></span>
		                	</td>		                			                            
		            	</tr> 		            	        
					</table>
    			</div>    												        
		    </div>		      
		    <div id="panel3" class="nui-panel" title="处理记录" iconCls="icon-add" showToolbar="false" showFooter="false" 
		    	showCollapseButton="true" collapseOnTitleClick="true" style="width: 100%; height: 48%;">	    	
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
						pageSize="10" showPageInfo="true" multiSelect="true" allowSortColumn="false" showEmptyText="true" emptyText="暂无处理数据">
						<div property="columns">
							<div type="indexcolumn" headerAlign="center" align="center">处理步骤</div>								
							<div field="id" headerAlign="center" align="center" allowSort="true" visible="false">ID</div>
							<div field="sqId" headerAlign="center" align="center" allowSort="true" visible="false">群众来信id</div>
							<div field="remark" headerAlign="center" align="center" allowSort="true" visible="false">处理内容</div>
							<div field="subOrgName" headerAlign="center" align="center" allowSort="true" renderer="onOrg">处理部门</div>
							<div field="reType" headerAlign="center" align="center"allowSort="true" renderer="onReOrTo">处理方式</div>	
							<div field="toOrgName" headerAlign="center" align="center" allowSort="true" renderer="onOrg">移交部门</div>																															
							<div field="reTime" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">处理时间</div>															
							<div name="action"  headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">处理内容</div>
						</div>
					</div>
				</div>
    		</div>		    		   
		    <div property="footer" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
		    	        
		        <a class="nui-button" style="width:85px;" iconCls="icon-goto" onclick="onTo()">信件转办</a>
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-edit" onclick="onReply()">信件回复</a>
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-print" onclick="onPrint()">信件打印</a>
		        
		    	<%
		    	if(isPublish.equals("1")){
		    	%>		
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-redo" onclick="onSetPublish(2,'撤销发布')">撤销发布</a>
	        	<%
	        	}
	         	%>
	         		
	         	<%
		    	if(isPublish.equals("2")){
		     	%>		        
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-ok" onclick="onSetPublish(1,'发布')">一键发布</a>
	        	<%
	        	}
	         	%>
	         	
	         	<%
		    	if(isOpen.equals("1")){
		    	%>		
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-redo" onclick="onSetOpen(2,'撤销公开')">撤销公开</a>
	        	<%
	        	}
	         	%>
	         		
	         	<%
		    	if(isOpen.equals("2")){
		     	%>		        
		        <span style="display:inline-block;width:20px;"></span>
		        <a class="nui-button" style="width:85px;" iconCls="icon-ok" onclick="onSetOpen(1,'发布')">一键公开</a>
	        	<%
	        	}
	         	%>	        
			</div>
			<div id="panel4" style="display:none;width: 100%; height: 100%" class="nui-panel" title="转办信件" iconCls="icon-add"  
	    			showCloseButton="true" showToolbar="false" showFooter="false">
		    	<div id="form3" class="nui-form" method="post">		    	
    				<input id="id" name="sqPro.id" class="nui-hidden"/>
    				<input id="sqId" name="sqPro.sqId" class="nui-hidden"/>
    				<input id="reType" name="sqPro.reType" class="nui-hidden"/>
    				<input id="subOrgId" name="sqPro.subOrgId" class="nui-hidden"/>
    				<input id ="subOrgName" name="sqPro.subOrgName" class="nui-hidden"/>
    				<input id="toOrgId" name="sqPro.toOrgId" class="nui-hidden"/>
					<table style="width:100%; table-layout:fixed;" class="nui-form-table">
						<tr>			                
			                <th class="nui-form-label">移交部门：</th>
			                <td >
								<input id="toOrgName" name="sqPro.toOrgName" textName="orgname" class="nui-buttonedit " 
								onbuttonclick="selectOrg" allowinput="false" style="width:15%;" 
								required="true" requiredErrorText="请选择部门"emptyText="请选择"/>	  		                 
		                	</td>			                		                
			            </tr>
			            <tr class="odd">
			                <th class="nui-form-label">转办意见：</th>
			                <td colspan="1">    
			                   	<input id="remark" name="sqPro.remark" class="nui-hidden" />
		                   		<textarea id="remark1" style="height:300px;width:98%;"></textarea>
			                </td>			              		                
			            </tr>
			            <tr>
			                <th class="nui-form-label">移交时间：</th>
			                <td>    
			                    <input id="reTime" name="sqPro.reTime" class="nui-datepicker nui-input" style="width:15%;" 
			                    format="yyyy-MM-dd HH:mm:ss" showTime="true" allowinput="false" emptyText="请选择"
			                    required="true" requiredErrorText="请选择时间"/>
			                </td>		                
			            </tr>		           
					</table>
					<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
						 <a class="nui-button" style="width:60px;" iconCls="icon-ok" onclick="onOkTo()">转办</a>
						 <span style="display:inline-block;width:25px;"></span>
						 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
					</div>
    			</div>	    		
    		</div> 
    		<div id="panel5" style="display:none;width: 100%; height: 100%" class="nui-panel" title="回复信件" iconCls="icon-add"  
	    			showCloseButton="true" showToolbar="false" showFooter="false">
	    		<div id="form4" class="nui-form" method="post">		    	
    				<input id="sqPro.id" name="sqPro.id" class="nui-hidden"/>
    				<input id="sqPro.reType" name="sqPro.reType" class="nui-hidden"/>
    				<input id="sqPro.subOrgId" name="sqPro.subOrgId" class="nui-hidden" />
    				<input id ="sqPro.subOrgName" name="sqPro.subOrgName" class="nui-hidden"/>    				
					<table style="width:100%; table-layout:fixed;" class="nui-form-table">					 
		                 <tr>			            	
				            <th class="nui-form-label">是否公开：</th>
			                <td >   
			                	<input name="sqPro.isOpen" class="nui-combobox" style="width:15%;" emptyText="请选择" 
		                    	textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt" required="true" requiredErrorText="不能为空"/>			                    
			                </td>
			             <tr/>
			             <tr class="odd">
			                <th class="nui-form-label">是否发布：</th>
			                <td > 
			                	<input name="sqPro.isPublish" class="nui-combobox" style="width:15%;" emptyText="请选择" 
		                    	textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt" required="true" requiredErrorText="不能为空"/>		   			                	
		                	</td>
		            	</tr>
			            <tr>
			                <th class="nui-form-label">回复内容：</th>
			                <td colspan="1">    
			                   	<input id="sqPro.remark" name="sqPro.remark" class="nui-hidden" />
		                   		<textarea id="remark2" style="height:300px;width:98%;" required="true"></textarea>
			                </td>			              		                
			            </tr>
			            <tr>
			                <th class="nui-form-label">回复时间：</th>
			                <td colspan="1">    
			                    <input id="sqPro.reTime" name="sqPro.reTime" class="nui-datepicker" style="width:15%;" 
			                    format="yyyy-MM-dd HH:mm:ss" showTime="true" allowinput="false" 
			                    emptyText="请选择" required="true" requiredErrorText="请选择时间"/>
			                </td>		                
			            </tr>		           
					</table>
					<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
						 <a class="nui-button" style="width:60px;" iconCls="icon-ok" onclick="onOkRe()">回复</a>
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
  	       	grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value;
			    if (field == "reType") {
			        if (value == 1){
			        	e.cellHtml = "转办";
			        }else{
			        	e.cellHtml = "回复";
			        }
			    }
			});
			
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
	    	  	
	    	var ue1 = UE.getEditor('remark1');	
	    	var ue2 = UE.getEditor('remark2');	    	    	
	    	//回复信件
	    	function onReply(){	
	    		form3.clear();  
	    		ue1.execCommand('cleardoc');  	
	    		$("#panel4").hide();
	    		$("#panel5").show();	    	
	    	}
	    	
			//转办信件
	    	function onTo(){
	    		form4.clear();  
	    		ue2.execCommand('cleardoc');  
	    		$("#panel5").hide();
	    		$("#panel4").show();    		 		
	    	}
	    	
	    	//保存'转办记录'并刷新记录列表
	    	function SaveData(toOrgId) {
	           	form3.validate();
		        if(form3.isValid()==false) return;
		        var data = form3.getData(false,true);		     
		        data.sqPro.reType = "<%=reType1 %>";
		        data.sqPro.remark = ue1.getContent();
		        data.sqPro.sqId = "<%=sqId %>";
		        data.sqPro.subOrgId = "<%=userObject.getUserOrgId() %>";
		        data.sqPro.subOrgName = "<%=userObject.getUserOrgName() %>";
		        data.sqPro.toOrgId = toOrgId;
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqProcess.addSqProcess.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {	                	
	                    refresh();
	                    onCancel();
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);	
	                    onCancel();              
	                }
	            });
	        }
	        //更新sq
	        function updateSqData(toOrgId){
	        	form3.validate();
		        if(form3.isValid()==false) return;
		        var data3 = form3.getData(false,true);	        
	        	form.validate();
				if (form.isValid() == false)
					return;
				var data = form.getData(false, true);
				data.sq.id = "<%=sqId %>";								
				data.sq.subOrgId = toOrgId;
				data.sq.subOrgName = data3.sqPro.toOrgName;															
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
	        
			
			function onOkTo(e) {
				var toOrgId = $("#toOrgId").val();				
	            SaveData(toOrgId);
	            updateSqData(toOrgId);
	        }
	    	//保存'回复记录'并更新sq表回复内容
	    	function SaveReData() {
	           	form4.validate();
		        if(form4.isValid()==false) return;
		        var data = form4.getData(false,true);		       
		        data.sqPro.reType = "<%=reType2 %>";
		        data.sqPro.remark = ue2.getContent();
		        data.sqPro.sqId = "<%=sqId %>";
		        data.sqPro.subOrgId = "<%=userObject.getUserOrgId() %>";
		        data.sqPro.subOrgName = "<%=userObject.getUserOrgName() %>";		        
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqProcess.addSqProcess.biz.ext",
	                type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
	                success: function (text) {	                	
	                    refresh();
	                    onCancel();
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                    onCancel();
	                }
	            });
	        }
	        //更新sq回复内容
	        function updateReData(){
	        	form4.validate();
		        if(form4.isValid()==false) return;
		        var data2 = form4.getData(false,true);
	        	form.validate();
				if (form.isValid() == false)
					return;
				var data = form.getData(false, true);
				data.sq.id = "<%=sqId %>";
				data.sq.replyContent = ue2.getContent();
				data.sq.replyOrgId = "<%=userObject.getUserOrgId() %>";
				data.sq.replyOrgName = "<%=userObject.getUserOrgName() %>";
				data.sq.subOrgId = "<%=userObject.getUserOrgId() %>";
				data.sq.subOrgName = "<%=userObject.getUserOrgName() %>";
				data.sq.replyTime = data2.sqPro.reTime;	
				data.sq.isReply = "<%=isReply %>";	
				data.sq.isOpen = data2.sqPro.isOpen;	
				data.sq.isPublish = data2.sqPro.isPublish;									
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
			function onOkRe(e){
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
			//关闭弹出框，此时（saveSuccess）传到父页面的回调函数，刷新父页面表单
			function onClose(e) {
				CloseWindow("saveSuccess");
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
	    				
			//重新刷新表单页面
			function refresh() {
				var form = new nui.Form("#queryform");
				var json = form.getData(false, false);
				grid.load(json);//grid查询	
										
			}
			
			//选择机构
		    function selectOrg(e) {
		        var btnEdit = this;
		        nui.open({
		            url:  "<%=request.getContextPath() %>/coframe/org/employee/select_org_tree.jsp",
		            showMaxButton: false,
		            title: "选择部门",
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
		                        //设置转办部门Id	
		                         $("#toOrgId").val(data.orgid);
		                             
		                    }
		                    
		                    
		                }
		            }
		        });            
		    }
		    
		    //单击展开详情按钮时发生
			function detailsRow(row_uid) {
				var row = grid.getRowByUID(row_uid);
					nui.open({
						url : "<%=request.getContextPath()%>/commonality/sqProcess/SqProDetail.jsp",
						title : "处理内容",
						width : '40%',
						height : '80%',
						onload : function() {
							var iframe = this.getIFrameEl();
							var data = row;
							//直接从页面获取，不用去后台获取
							iframe.contentWindow.setData(data);							
						},
						ondestroy : function(action) {
							if (action == "saveSuccess") {
								grid.reload();
							}
						}
					});				
			}			
			function onActionRenderer(e) {	            
	            var record = e.record;
	            var uid = record._uid;

	            var s = '<a class="Edit_Button" href="javascript:detailsRow(\'' + uid + '\')">点击查看详情</a>';
	                       
	            return s;
	        }
	        
	        //单击打印信件按钮时发生
	        function onPrint(){
	        	var data = form.getData(false,true);
	        	nui.open({
						url : "<%=request.getContextPath()%>/commonality/sq/SqPrint.jsp",
						title : "打印预览",
						width : '80%',
						height : '100%',
						onload : function() {
							var iframe = this.getIFrameEl();						
							//直接从页面获取，不用去后台获取
							iframe.contentWindow.setData(data);							
						}
					});			
	        }
	        //一键发布or撤销
	        function onSetPublish(isPublish,msg){
	        	data_.isPublish = isPublish;
	        	var json = nui.encode({
					sq : data_
				});
				nui.confirm("确定"+msg+"该来信吗？","系统提示",function(action) {
					if (action == "ok") {
						$.ajax({
								url : "com.cms.commonality.SqService.updateSq.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {										
										nui.alert(msg+"成功","系统提示",function(action) {
										});
										CloseWindow("saveSuccess");
									} else {
										grid.unmask();
										nui.alert(msg+"失败","系统提示");
										CloseWindow();
									}
								},								
						});
	        	 	}
	        	});
	        } 
	        
	        //一键公开or撤销
	        function onSetOpen(isOpen,msg){
	        	data_.isOpen = isOpen;
	        	var json = nui.encode({
					sq : data_
				});
				nui.confirm("确定"+msg+"该来信吗？","系统提示",function(action) {
					if (action == "ok") {
						$.ajax({
								url : "com.cms.commonality.SqService.updateSq.biz.ext",
								type : 'POST',
								data : json,
								cache : false,
								contentType : 'text/json',
								success : function(text) {
									var returnJson = nui.decode(text);
									if (returnJson.exception == null) {										
										nui.alert(msg+"成功","系统提示",function(action) {
										});
										CloseWindow("saveSuccess");
									} else {
										grid.unmask();
										nui.alert(msg+"失败","系统提示");
										CloseWindow();
									}
								},								
						});
	        	 	}
	        	});
	        
	        } 
		</script>
	</body>
</html>