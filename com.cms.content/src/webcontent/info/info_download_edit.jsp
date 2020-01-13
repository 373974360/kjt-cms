<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("catId");
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
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
				<input id="info.inputUser" name="info.inputUser" class="nui-hidden" value="<%=userObject.getUserId() %>" />
				<input id="info.orgId" name="info.orgId" class="nui-hidden" value="<%=userObject.getUserOrgId() %>" />
				<input id="info.orgName" name="info.orgName" class="nui-hidden" value="<%=userObject.getUserOrgName() %>" />
            	<input name="content.id" class="nui-hidden"/>
            	<input name="info.modelId" class="nui-hidden"/>
            	<input name="info.catId" class="nui-hidden"/>
		        <input id="info.infoStatus" name="info.infoStatus" class="nui-hidden"/>
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
		            <jsp:include page="incloud_header.jsp"/>
		            <tr>
		                <th class="nui-form-label">标题图片：</th>
		                <td colspan="4">    
		                   <script type="text/plain" id="upload_ue"></script>
		                   <input id="thumbUrl" name="info.thumbUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upImage();">上传图片 </a>
		                </td>
		            </tr>
					<tr>
					    <th class="nui-form-label">图片说明：</th>
					    <td colspan="5">    
					       <textarea name="info.thumbRemark" class="nui-textarea" style="width:100%;"></textarea>
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
		                <th class="nui-form-label">附件：</th>
		                <td colspan="4">    
		                   <input id="contentUrl" name="info.contentUrl" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upFiles();">上传附件 </a>
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
		    var btnEdit = nui.get("infoCatId");
	        function beforenodeselect(e) {
	            //禁止选中父节点
	            if (e.isLeaf == false) e.cancel = true;
	        }
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
		    
		    function getTitleTags() {
		    	var title = nui.get("infoTitle").getValue();
		    	if(title!=null&&title!=""){
		            $.ajax({
		                url: "<%=request.getContextPath() %>/content/info/getTitleTags.jsp?title="+title,
		                type: 'GET',
		                cache: false,
		                contentType:'text/json',
		                success: function (text) {
		                	if(text!=""&&text!=null){
			                	var json = JSON.parse(text);
			                	var keyword = "";
			                	for(var i=0;i<json.items.length;i++){
			                		keyword+=","+json.items[i].item;
			                	}
			                	nui.get("keywords").setValue(keyword.substring(1));
		                	}
		                }
		            });
		    	}
	        }
		    function removeSource(){
		    	var infoSource = nui.get("infoSource");
		    	infoSource.setValue(infoSource.getValue().split(",")[0]);
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
	        var upload_ue = UE.getEditor('upload_ue');
			upload_ue.ready(function () {
				//设置编辑器不可用
				//upload_ue.setDisabled();
				//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
				upload_ue.hide();
				//侦听图片上传
				upload_ue.addListener('beforeInsertImage', function (t, arg) {
		        	nui.get("thumbUrl").setValue(arg[0].src);
				});
		        //侦听文件上传，取上传文件列表中第一个上传的文件的路径
		        upload_ue.addListener('afterUpfile', function (t, arg) {
		        	nui.get("contentUrl").setValue(arg[0].url);
		        });
			});
			//弹出图片上传的对话框
			function upImage() {
				var myImage = upload_ue.getDialog("insertimage");
				myImage.open();
			}
		    //弹出文件上传的对话框
		    function upFiles() {
		        var myFiles = upload_ue.getDialog("attachment");
		        myFiles.open();
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
			         }
	          	});
	        }
	        
	        function setData(data){
	        	data = nui.clone(data);
	        	var json = nui.encode({info:data});
				$.ajax({
					url:"com.cms.content.ContentService.getInfoLink.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						obj = nui.decode(text);
			            form.setData(obj);
						if(obj.infoCats.length>0){
							var ids = "";
							var texts = "";
							for(var i=0;i<obj.infoCats.length;i++){
								if(i>0){
									ids += ","+obj.infoCats[i].REALID;
									texts += ","+obj.infoCats[i].TEXT;
								}else{
									ids += obj.infoCats[i].REALID;
									texts += obj.infoCats[i].TEXT;
								}
							}
							btnEdit.setValue(ids);
            				btnEdit.setText(texts);
						}
			            form.setChanged(false);
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        if(data.info.isShemi == 1){
		        	alert("请检查内容是否涉密");
		        	return false;
		        }
		        data.info.thumbUrl = $("input[name='info.thumbUrl']").val();
		        data.info.contentUrl = $("input[name='info.contentUrl']").val();
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
	                url: "com.cms.content.ContentService.updateLink.biz.ext",
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