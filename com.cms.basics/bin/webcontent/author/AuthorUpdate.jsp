<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>作者录入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_skin" rel="stylesheet" type="text/css"
	href="/default/coframe/tools/skins/skin1/css/style.css" />
<link id="css_icon" rel="stylesheet" type="text/css"
	href="/default/coframe/tools/icons/icon.css" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="nui-fit" style="padding-top: 5px">
		<div id="dataform1">
			<!-- hidden域 -->
			<input class="nui-hidden" name="author.id" id="author.id" />
			<table style="width: 100%; table-layout: fixed;"
				class="nui-form-table">
				<tr>
					<th class="nui-form-label"><label
						for="appfunction.funcname$text"> 作者姓名: </label></th>
					<td><input class="nui-textbox nui-form-input"
						name="author.authorName" /></td>
				</tr>
				<tr>
					<th class="nui-form-label"><label
						for="appfunction.funcname$text"> 博客地址: </label></th>
					<td><input class="nui-textbox nui-form-input"
						name="author.authorUrl" /></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar"
		style="text-align: center; padding-top: 5px; padding-bottom: 5px;"
		borderStyle="border:0;">
		<a class="nui-button" style="width: 60px;" iconCls="icon-save"
			onclick="onOk()">保存</a> <span
			style="display: inline-block; width: 25px;"></span> <a
			class="nui-button" style="width: 60px;" iconCls="icon-cancel"
			onclick="onCancel()">取消</a>
	</div>
	<script type="text/javascript">
		nui.parse();
		var form = new nui.Form("#dataform1");
		var tab = nui.get("tab");
		form.setChanged(false);

		function onOk() {
			saveData();
		}
		function setData(data) {
			data = nui.clone(data);
			var json = nui.encode({
				author : data
			});
			$.ajax({
				url : "com.cms.basics.AuthorService.getAuthor.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					obj = nui.decode(text);
					form.setData(obj);
					form.setChanged(false);
				}
			});
		}

		function saveData() {
			form.validate();
			if (form.isValid() == false)
				return;
			var data = form.getData(false, true);
			var json = nui.encode(data);

			$.ajax({
				url : "com.cms.basics.AuthorService.updateAuthor.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						CloseWindow("saveSuccess");
					} else {
						nui.alert("保存失败", "系统提示", function(action) {
							if (action == "ok" || action == "close") {
								//CloseWindow("saveFailed");
							}
						});
					}
				}
			});
		}

		function onReset() {
			form.reset();
			form.setChanged(false);
		}

		function onCancel() {
			CloseWindow("cancel");
		}

		function CloseWindow(action) {

			if (action == "close") {

			} else if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
	</script>
</body>
</html>
