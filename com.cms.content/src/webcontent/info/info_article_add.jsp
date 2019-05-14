<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String catId = request.getParameter("catId");
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
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="info.id" name="info.id" class="nui-hidden" />
				<input id="info.catId" name="info.catId" class="nui-hidden" value="<%=catId %>" />
		        <table style="width:100%;table-layout:fixed;float:left;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label" style="width:120px;">所属栏目：</th>
		                <td style="width:100px;">    
		                    <span name="categoryName"><span>
		                </td>
		                <th class="nui-form-label" style="width:70px;">文章分类：</th>
		                <td style="width:100px;">    
		                    <input name="infoType" class="nui-combobox" textField="typeName" valueField="id"  style="width:100px;"
						    url="com.cms.basics.InfoTypeService.queryInfoTypeAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		                <th class="nui-form-label" style="width:70px;">同时发布：</th>
		                <td style="width:150px;">    
		                    <input id="select1" class="nui-treeselect" style="width:150px;" url="com.cms.content.ContentService.queryInfoCategoryTreeNode.biz.ext"
							    textField="text" dataField="data" valueField="id" parentField="pid" onbeforeload="onBeforeTreeLoad"/>
		                </td>
		                <td></td>
		            </tr>       
		            <tr>
		                <th class="nui-form-label">信息标题：</th>
		                <td colspan="4">    
		                    <input name="article.infoTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">来源：</th>
		                <td>    
		                    <input name="infoType" class="nui-combobox" style="width:100px;" textField="sourceName" valueField="id"
						    url="com.cms.basics.SourceService.querySourceAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		                <th class="nui-form-label">作者：</th>
		                <td>    
		                    <input name="infoType" class="nui-combobox" style="width:100px;" textField="authorName" valueField="id"
						    url="com.cms.basics.AuthorService.queryAuthorAll.biz.ext" dataField="data" showNullItem="true" />
		                </td>
		                <th class="nui-form-label">网络编辑：</th>
		                <td>    
		                    <input name="article.infoTitle" class="nui-textbox nui-form-input" value="<%=userObject.getUserName() %>"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">关键词：</th>
		                <td colspan="3">    
		                    <input name="article.infoTitle" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">发布时间：</th>
		                <td>    
		                    <input name="article.infoTitle" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" showTime="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">摘要：</th>
		                <td colspan="5">    
		                   <textarea class="nui-textarea" style="width:560px;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">正文内容：</th>
		                <td colspan="6">    
		                   <textarea id="content" name="content" style="height:300px;width:98%;"></textarea>
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
		    var tree = nui.get("select1");
		    function onBeforeTreeLoad(e) {
				e.params.nodeType = e.node.type;
				e.params.nodeId = e.node.realId;
		    }
	        var form = new nui.Form("form1");
	        
	        var ue = UE.getEditor('content');
	        function getContent() {
		        var arr = ue.getContent();
		        alert(arr);
		    };
		    function setContent() {
		        ue.setContent('MiniUI - 专业WebUI控件库');
		    };
	        
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
						console.log(obj);
						console.log(obj.category.chName);
						$("span[name=categoryName]").html(obj.category.chName);
			         }
	          	});
	        }
	        
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.content.CategoryService.addCategory.biz.ext",
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