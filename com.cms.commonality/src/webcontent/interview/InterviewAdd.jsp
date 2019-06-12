<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
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
				<input id="interview.id" name="interview.id" class="nui-hidden" />
				<input id="interview.inputUser" name="interview.inputUser" class="nui-hidden" value="<%=userObject.getUserName() %>" />
				<input id="interview.content" name="interview.content" class="nui-hidden" />
				<input id="interview.hits" name="interview.hits" class="nui-hidden" value="0"/>
				<input id="interview.status" name="interview.status" class="nui-hidden" value="1"/>
               	<script type="text/plain" id="upload_ue"></script>
		        <table style="width:100%;table-layout:fixed;float:left;" class="nui-form-table" >     
		            <tr>
		                <th class="nui-form-label">访谈主题：</th>
		                <td>    
		                    <input name="interview.title" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">开始时间：</th>
		                <td>    
		                    <input name="interview.startTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm" dateFormat="yyyy-MM-dd HH:mm" showTime="true" required="true" />
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">截止时间：</th>
		                <td>    
		                    <input name="interview.endTime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm" dateFormat="yyyy-MM-dd HH:mm" showTime="true" required="true" />
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">摘要：</th>
		                <td>    
		                   <textarea name="interview.description" class="nui-textarea" style="width:100%;"></textarea>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">封面图片：</th>
		                <td>    
		                   <input name="interview.imgUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upImage();">上传图片 </a>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">视频地址：</th>
		                <td>    
		                   <input name="interview.videoUrl" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upVideo();">上传视频 </a>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">新闻稿：</th>
		                <td colspan="2">
		                   	<textarea id="content" style="height:400px;width:98%;"></textarea>
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
	        var ue = UE.getEditor('content');
	        var upload_ue = UE.getEditor('upload_ue');
			upload_ue.ready(function () {
				//设置编辑器不可用
				//upload_ue.setDisabled();
				//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
				upload_ue.hide();
				//侦听图片上传
				upload_ue.addListener('beforeInsertImage', function (t, arg) {
					$("input[name='interview.imgUrl']").val(arg[0].src);
				});
				//侦听视频上传，取上传视频列表中第一个上传的视频的路径
		        upload_ue.addListener('afterUpvideo', function (t, arg) {
		        	$("input[name='interview.videoUrl']").val(arg[0].url);
		        });
			});
			//弹出图片上传的对话框
			function upImage() {
				var myImage = upload_ue.getDialog("insertimage");
				myImage.open();
			}
			//弹出图片上传的对话框
			function upVideo() {
				var myVideo = upload_ue.getDialog("insertvideo");
				myVideo.open();
			}
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.interview.imgUrl = $("input[name='interview.imgUrl']").val();
		        data.interview.videoUrl = $("input[name='interview.videoUrl']").val();
		        data.interview.content = ue.getContent();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.commonality.InterviewService.addInterview.biz.ext",
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