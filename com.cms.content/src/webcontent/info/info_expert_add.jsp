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
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.min.js" type="text/javascript"></script>
		<style type="text/css">
			.mini-radiobuttonlist-table{width:300px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="info.id" name="info.id" class="nui-hidden" />
				<input id="info.catId" name="info.catId" class="nui-hidden" value="<%=catId %>" />
				<input id="info.modelId" name="info.modelId" class="nui-hidden" value="<%=modelId %>" />
				<input id="info.inputUser" name="info.inputUser" class="nui-hidden" value="<%=userObject.getUserId() %>" />
				<input id="info.orgId" name="info.orgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>" />
				<input id="info.orgName" name="info.orgName" class="nui-hidden" value="<%=userObject.getUserOrgName() %>" />
				<input id="leader.ldzw" name="leader.ldzw" class="nui-hidden"/>
				<input id="leader.grjl" name="leader.grjl" class="nui-hidden"/>
				<input id="leader.zrfg" name="leader.zrfg" class="nui-hidden"/>
				<input id="leader.kycg" name="leader.kycg" class="nui-hidden"/>
		        <input id="info.infoStatus" name="info.infoStatus" class="nui-hidden"/>
            	<input name="wflogs.busId" class="nui-hidden"/>
            	<input name="wflogs.busUrl" class="nui-hidden"/>
            	<input name="wflogs.wfOptUser" class="nui-hidden" value="<%=userObject.getUserName() %>"/>
            	<input name="wflogs.wfStepId" class="nui-hidden" value="1"/>
            	<input name="wflogs.wfOptTime" class="nui-hidden"/>
            	<input name="wflogs.wfId" class="nui-hidden"/>
            	<input name="wflogs.wfOptType" class="nui-hidden" value="4"/>
            	<input name="wflogs.wfOptDesc" class="nui-hidden" value="信息报送"/>
            	<%
            		if(!group.equals("manager")){
            	%>
            		<input name="info.weight" value="60" class="nui-hidden"/>
            		<input name="info.hits" value="0" class="nui-hidden"/>
            		<input name="info.isTuijian" value="2" class="nui-hidden"/>
            		<input name="info.isTop" value="2" class="nui-hidden"/>
            	<%
            		}
	            %>
		        <table style="width:100%;table-layout:fixed;float:left;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label" style="width:120px;">所属栏目：</th>
		                <td style="width:100px;">    
		                    <span name="categoryName"><span>
		                </td>
		                <th class="nui-form-label" style="width:70px;">文章分类：</th>
		                <td style="width:100px;">    
		                    <input name="info.infoType" class="nui-combobox" textField="typeName" valueField="id"  style="width:100px;"
						    url="com.cms.basics.InfoTypeService.queryInfoTypeAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		                <th class="nui-form-label" style="width:70px;">同时发布：</th>
		                <td style="width:150px;">    
		                    <input name="infoCat.catId" class="nui-buttonedit nui-form-input" onbuttonclick="onButtonEdit" allowInput="false"/>
		                </td>
		                <td></td>
		            </tr>       
		            <tr>
		                <th class="nui-form-label">专家姓名：</th>
		                <td colspan="5">    
		                    <input name="info.infoTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">来源：</th>
		                <td colspan = 3>    
		                	<input id="infoSource" name="info.source" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                	<div id="infoSourceCombobox" class="nui-combobox" style="width:100px;" popupWidth="400" textField="sourceName" valueField="sourceName"
							    url="com.cms.basics.SourceService.querySourceAll.biz.ext" dataField="data" onvaluechanged="setInfoSource()">
							</div>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">来源地址：</th>
		                <td colspan="4">    
		                    <input name="info.sourceUrl" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		           	<tr>
		                <th class="nui-form-label">作者：</th>
		                <td colspan = 3>    
		                	<input id="infoAuthor" name="info.author" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                	<div id="infoAuthorCombobox" class="nui-combobox" style="width:100px;" popupWidth="400" textField="authorName" valueField="authorName"
							    url="com.cms.basics.AuthorService.queryAuthorAll.biz.ext" dataField="data" onvaluechanged="setInfoAuthor()">
							</div>
		                </td>
		            </tr>
		           	<tr>
		                <th class="nui-form-label">网络编辑：</th>
		                <td colspan = "2">    
		                    <input name="info.editor" class="nui-textbox nui-form-input" value="<%=userObject.getUserName() %>"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">关键词：</th>
		                <td colspan="3">    
		                    <input name="info.keywords" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">发布时间：</th>
		                <td>    
		                    <input name="info.releasedDtime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" dateFormat="yyyy-MM-dd HH:mm:ss" value="<%=curTime %>" showTime="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">摘要：</th>
		                <td colspan="5">    
		                   <textarea name="info.description" class="nui-textarea" style="width:100%;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">专家照片：</th>
		                <td colspan="4">    
		                   <script type="text/plain" id="upload_ue"></script>
		                   <input name="info.thumbUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upImage();">上传图片 </a>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">发布状态：</th>
		                <td colspan="5">    
		                	<span id="draft"><input type="radio" name="infoStatus" value="1"/> 草稿</span>
		                	<span id="pending"><input type="radio" name="infoStatus" value="2"/> 待审</span>
		                	<span id="publish"><input type="radio" name="infoStatus" value="3"/> 发布</span>
		                </td>
		            </tr>
		            <%
		            	if(group.equals("manager")){
		            %>
			            <tr>
			                <th class="nui-form-label">权重：</th>
			                <td>    
			                	<input name="info.weight" value="60" class="nui-spinner"  minValue="0" maxValue="99"/>
			                </td>
			                <th class="nui-form-label">点击数：</th>
			                <td>    
			                	<input name="info.hits" value="0" class="nui-spinner" minValue="0" maxValue="99999"/>
			                </td>
			            </tr>
			            <tr>
			                <th class="nui-form-label">是否推荐：</th>
			                <td>    
			                	<div name="info.isTuijian" class="nui-radiobuttonlist"
								    textField="text" dataField="yesNo" valueField="id" value="2"
								    url="<%=request.getContextPath()%>/content/info/yesNo.txt" >
								</div>
			                </td>
			                <th class="nui-form-label">是否置顶：</th>
			                <td>    
			                	<div name="info.isTop" class="nui-radiobuttonlist"
								    textField="text" dataField="yesNo" valueField="id" value="2"
								    url="<%=request.getContextPath()%>/content/info/yesNo.txt" >
								</div>
			                </td>
			            </tr>
		            <%
		            	}
		            %>
		            <tr>
		                <th class="nui-form-label">专家职务：</th>
		                <td colspan="6">
		                   	<textarea id="ldzw" style="height:300px;width:98%;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">个人履历：</th>
		                <td colspan="6">
		                   	<textarea id="grjl" style="height:300px;width:98%;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">研究方向：</th>
		                <td colspan="6">
		                   	<textarea id="zrfg" style="height:300px;width:98%;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">科研成果：</th>
		                <td colspan="6">
		                   	<textarea id="kycg" style="height:300px;width:98%;"></textarea>
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
		    function onButtonEdit(){
	   			var btnEdit = this;
		    	nui.open({
	                url: "<%=request.getContextPath() %>/content/info/category_select.jsp",
	                title: "选择同时发布栏目",
					width: 500, 
	                height: 700,
	                allowResize:false,
	                onload : function() {
						var iframe = this.getIFrameEl();
	                   	iframe.contentWindow.setCheckedNodes(btnEdit.getValue(),<%=catId %>);
					},
	                ondestroy: function (action) {
	                   if (action == "ok") {
                            btnEdit.setValue("");
                            btnEdit.setText("");
	                        var iframe = this.getIFrameEl();
	                        var data = iframe.contentWindow.getCheckedNodes();
	                        data = nui.clone(data);//必须
	                        if (data) {
	                            btnEdit.setValue(data.id);
	                            btnEdit.setText(data.name);
	                        }
	                    } 
	                }
	            });
		    }
		   	function setInfoSource(){
		   		var source = nui.get("infoSourceCombobox").getValue();
		   		var infoSource = nui.get("infoSource");
		   		if(infoSource.getValue()==""||infoSource.getValue().length==0){
		   			infoSource.setValue(source);
		   		}else{
		   			infoSource.setValue(infoSource.getValue()+","+source);
		   		}
		   	}
		    
		   	function setInfoAuthor(){
		   		var author = nui.get("infoAuthorCombobox").getValue();
		   		var infoAuthor = nui.get("infoAuthor");
		   		if(infoAuthor.getValue()==""||infoAuthor.getValue().length==0){
		   			infoAuthor.setValue(author);
		   		}else{
		   			infoAuthor.setValue(infoAuthor.getValue()+","+author);
		   		}
		   	}
		    
	        var form = new nui.Form("form1");
	        var ldzw = UE.getEditor('ldzw');
	        var grjl = UE.getEditor('grjl');
	        var zrfg = UE.getEditor('zrfg');
	        var kycg = UE.getEditor('kycg');
	        var upload_ue = UE.getEditor('upload_ue');
			upload_ue.ready(function () {
				//设置编辑器不可用
				//upload_ue.setDisabled();
				//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
				upload_ue.hide();
				//侦听图片上传
				upload_ue.addListener('beforeInsertImage', function (t, arg) {
					$("input[name='info.thumbUrl']").val(arg[0].src);
				});
			});
			//弹出图片上传的对话框
			function upImage() {
				var myImage = upload_ue.getDialog("insertimage");
				myImage.open();
			}
	        
	        setCatgory();
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
						$("span[name=categoryName]").html(obj.category.chName);
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
								}else{
									$("#pending input[name='infoStatus']").attr("checked",true);
									$("input[name='wflogs.wfId']").val(obj.category.workflowId);
								}
								if(!b){
									$("#publish").remove();
								}else{
									$("#pending").remove();
									$("#publish input[name='infoStatus']").attr("checked",true);
								}
								if(!b && obj.category.workflowId==null){
									$("#draft input[name='infoStatus']").attr("checked",true);
								}
					         }
			          	});
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.info.thumbUrl = $("input[name='info.thumbUrl']").val();
		        data.leader.ldzw = ldzw.getContent();
		        data.leader.grjl = grjl.getContent();
		        data.leader.zrfg = zrfg.getContent();
		        data.leader.kycg = kycg.getContent();
		        data.info.infoStatus = $("input[name='infoStatus']:checked").val();
		        data.wflogs.wfId = $("input[name='wflogs.wfId']").val();
		        var json = nui.encode(data);
		        json = json.substring(0,json.indexOf("infoCat")-2);
		        var catId = data.infoCat.catId;
		        if(catId!=undefined && catId.length>0){
		        	var json_1 = ',"infoCat":[';
			        var catIdArray = catId.split(",");
			        for(var i=0;i<catIdArray.length;i++){
			        	json_1 = json_1 + '{"catId":'+'"'+catIdArray[i]+'"},';
			        }
			        json_1 = json_1.substring(0, json_1.length-1)+"]";
			        json = json+json_1;
		        }
        		json = json + "}";
	            $.ajax({
	                url: "com.cms.content.ContentService.addLeader.biz.ext",
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