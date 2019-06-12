<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String interviewId = request.getParameter("interviewId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
				<input id="guest.id" name="guest.id" class="nui-hidden" />
				<input id="guest.interId" name="guest.interId" class="nui-hidden" value="<%=interviewId %>"/>
               	<script type="text/plain" id="upload_ue"></script>
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">嘉宾姓名：</th>
		                <td>    
		                    <input name="guest.username" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">照片：</th>
		                <td>    
		                   <input name="guest.photo" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upImage();">上传照片 </a>
		                </td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">职务：</th>
		                <td>    
		                    <input name="guest.zw" class="nui-textbox nui-form-input"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">工作单位：</th>
		                <td>    
		                    <input name="guest.work" class="nui-textbox nui-form-input"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">排序：</th>
		                <td>    
		                    <input name="guest.sort" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">简介：</th>
		                <td colspan="2">    
		                	<textarea name="guest.remark" class="nui-textarea" style="width:100%;height:100px;"></textarea>
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
	        var upload_ue = UE.getEditor('upload_ue');
			upload_ue.ready(function () {
				//设置编辑器不可用
				//upload_ue.setDisabled();
				//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
				upload_ue.hide();
				//侦听图片上传
				upload_ue.addListener('beforeInsertImage', function (t, arg) {
					$("input[name='guest.photo']").val(arg[0].src);
				});
			});
			//弹出图片上传的对话框
			function upImage() {
				var myImage = upload_ue.getDialog("insertimage");
				myImage.open();
			}
	        
	        var form = new nui.Form("form1");
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.guest.photo = $("input[name='guest.photo']").val();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.GuestService.addGuest.biz.ext",
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