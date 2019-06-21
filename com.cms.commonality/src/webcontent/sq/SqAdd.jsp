<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String curTime = df.format(new Date());
	
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
%>
<style>
	#table1 .tit{
		height: 10px;
	    line-height: 10px;
	}
	#table1 td{
		height: 10px;
	    line-height: 10px;
	}
</style>
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
				<input id="sq.id" name="sq.id" class="nui-hidden" />
				<input id="sq.subOrgId" name="sq.subOrgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>">
		        <table id="table1" align="center" style="width:100%; table-layout:fixed;" class="nui-form-table">
		            <tr>
		                <th class="nui-form-label">来信标题：</th>
		                <td colspan="7">    
		                    <input name="sq.title" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/> 
		                </td>		                
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">来信人姓名：</th>
		                <td colspan="3">    
		                    <input name="sq.username" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/>
		                </td>
		                <th class="nui-form-label">联系电话：</th>
		                <td colspan="3">    
		                    <input name="sq.phone" class="nui-textbox nui-form-input" vtype="float" floatErrorText="请输入电话号码" required="true" requiredErrorText="不能为空"/>
		                </td>
		            </tr>
		            <tr>
		            	<th class="nui-form-label">联系地址：</th>
		                <td colspan="3">    
		                    <input name="sq.address" class="nui-textbox nui-form-input" required="true" requiredErrorText="不能为空"/>
		                </td>
		                <th class="nui-form-label">电子邮箱：</th>
		                <td colspan="3">    
		                    <input name="sq.email" class="nui-textbox nui-form-input" vtype="email;rangeLength:5,20;" emailErrorText="请输入邮箱格式" required="true"  requiredErrorText="不能为空"/>
		                </td>		               
		            </tr>
		            <tr class="odd">
		            	<th class="nui-form-label">受理部门：</th>
		                <td colspan="3" class="tit">
							<input name="sq.subOrgName" textName="orgname"  class="nui-buttonedit nui-form-input" 
							onbuttonclick="selectOrg" style="width:80%" allowinput="false" emptyText="请选择"/>	  		                 
		                </td>
		            	<th class="nui-form-label">回复部门：</th>
		                <td colspan="3" class="tit">
							<input name="sq.replyOrgName" textName="orgname" class="nui-buttonedit nui-form-input" 
							onbuttonclick="selectOrg" style="width:80%" allowinput="false" emptyText="请选择"/>				    		                 							
		                </td>
		            </tr>
		            <tr>
		            	<th class="nui-form-label">来信目的：</th>
		                <td colspan="3"> 
		                	<input name="sq.mdId" class="nui-combobox nui-form-input" style="width:150px;" textField="mdName" valueField="id"
								url="com.cms.basics.LxmdService.queryLxmdName.biz.ext" dataField="data" showNullItem="true" emptyText="请选择"/>		                    
		                </td>
		                <th class="nui-form-label">是否回复：</th>
		                <td colspan="3">    
		                    <input name="sq.isReply" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>
		                </td>		              
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">是否公开：</th>
		                <td colspan="3">    
		                     <input name="sq.isOpen" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>
		                </td>
		                <th class="nui-form-label">是否发布：</th>
		                <td colspan="3">    
		                    <input name="sq.isPublish" class="nui-combobox nui-form-input" showNullItem="true" emptyText="请选择" 
		                    textField="text" dataField="isOrNo" valueField="id" 
		    					url="<%=request.getContextPath()%>/commonality/sq/IsorNo.txt"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">提交时间：</th>
		                <td colspan="3">    
		                    <input name="sq.createTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" 
		                     allowinput="false" value="<%=curTime %>" showTime="true"/>
		                </td>	
		                <th class="nui-form-label">回复时间：</th>
		                <td colspan="3">    
		                    <input name="sq.replyTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss"
		                     allowinput="false" value="<%=curTime %>" showTime="true"/>
		                </td>                
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">来信内容：</th>
		                <td colspan="7">    
		                	<input name="sq.content" class="nui-hidden" />
		                   <textarea id="content1" style="height:300px;width:98%;"></textarea>
		                </td>		                			                            
		            </tr>
		            <tr>
			            <th class="nui-form-label">回复内容：</th>
		                <td colspan="7"> 
		                   <input name="sq.replyContent" class="nui-hidden" />
		                   <textarea id="content2" style="height:300px;width:98%;"></textarea>
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
	        
	        var ue = UE.getEditor('content1');
	        var ue2 = UE.getEditor('content2');
	      
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.sq.content = ue.getContent();
		        data.sq.replyContent = ue2.getContent();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.SqService.addSq.biz.ext",
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
		                    }
		                }
		            }
		        });            
		    }
	    </script>
	</body>
</html>