<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
  		
		<link rel="stylesheet" href="<%=request.getContextPath()%>/siteconfig/codemirror/codemirror.css"/>
		<script src="<%=request.getContextPath()%>/siteconfig/codemirror/codemirror.js"></script>
		<script src="<%=request.getContextPath()%>/siteconfig/codemirror/xml.js"></script>
		<script src="<%=request.getContextPath()%>/siteconfig/codemirror/css.js"></script>
		<script src="<%=request.getContextPath()%>/siteconfig/codemirror/javascript.js"></script>
		<script src="<%=request.getContextPath()%>/siteconfig/codemirror/htmlmixed.js"></script>
	  	<style>
	    	.CodeMirror {border: 1px solid #CCC;min-height:800px;}
	  	</style>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="templet.id" name="templet.id" class="nui-hidden" />
				<input id="templet.templetContent" name="templet.templetContent" class="nui-hidden" />
				<input id="templet.version" name="templet.version" class="nui-hidden" value="1"/>
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">模板名称：</th>
		                <td>    
		                    <input name="templet.templetName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">模板内容：</th>
		                <td colspan="2">    
		                	<div id="code-html" name="code-html"></div>
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
	        var te_html = document.getElementById("code-html");
	       	editorHtml = CodeMirror(te_html, {
			    mode: "text/html",
		        extraKeys: {"Ctrl-Space": "autocomplete"},
		        smartIndent : true,
		        indentUnit : 4,  // 缩进单位，默认2
		        lineNumbers : true,  // 是否显示行号
		        lineWrapping : true
		  	});
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.templet.templetContent = editorHtml.getValue();
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.siteconfig.TempletService.addTemplet.biz.ext",
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