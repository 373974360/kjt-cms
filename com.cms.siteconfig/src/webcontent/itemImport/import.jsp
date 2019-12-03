<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
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
    	<script src="<%=request.getContextPath()%>/content/ueditor/ueditor.all.js" type="text/javascript"></script>
		<style type="text/css">
			.mini-radiobuttonlist-table{width:300px;}
		</style>
	</head>
<body>  
<div id="layout1" class="nui-layout" style="width:100%;height:100%;">
    <div title="center" region="center" style="border:0;padding-left:5px;">
    	<div class="nui-panel" title="科技项目导入" iconCls="icon-add" style="width: 100%; height: 100%;" showToolbar="false" showFooter="true">
			<div id="queryform" class="nui-form" align="center" style="height: 100%">
				<table id="table1" class="table" style="float:left;">
					<tr>
		                <th class="nui-form-label">样表下载：</th>
		                <td colspan="2">
		                   <a href="<%=request.getContextPath()%>/siteconfig/itemImport/科技项目导入样表.xlsx" target="_blank">点击下载 </a>
		                </td>
		            </tr>
					<tr>
		                <th class="nui-form-label">文件地址：</th>
		                <td>    
		                   <script type="text/plain" id="upload_ue"></script>
		                   <input id="filePath" name="filePath" class="nui-textbox nui-form-input"/>
		                </td>
		                <td>
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upFiles();">上传文件 </a>
		                </td>
		            </tr>
					<tr>
		                <th class="nui-form-label"></th>
		                <td colspan="2">
		                   <a class="nui-button" style="width:100px;" iconCls="icon-ok" onclick="onOk()">开始导入</a>
		                </td>
		            </tr>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	nui.parse();
    var upload_ue = UE.getEditor('upload_ue');
	upload_ue.ready(function () {
		//设置编辑器不可用
		//upload_ue.setDisabled();
		//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
		upload_ue.hide();
		//侦听文件上传，取上传文件列表中第一个上传的文件的路径
	     upload_ue.addListener('afterUpfile', function (t, arg) {
	         nui.get("filePath").setValue(arg[0].url);
	     })
	});
	//弹出图片上传的对话框
	function upFiles() {
		var myFiles = upload_ue.getDialog("attachment");
		myFiles.open();
	}
	//开始导入
	function onOk() {
		var json = nui.encode({filePath:nui.get("filePath").getValue()});
		nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据导入中，请稍等 ...'
        });
		$.ajax({
			url : "com.cms.siteconfig.ImportExeclService.toImportExcel.biz.ext",
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				alert("导入完成！");
				nui.unmask(document.body);
			}
		});
	}
</script>
</body>
</html>