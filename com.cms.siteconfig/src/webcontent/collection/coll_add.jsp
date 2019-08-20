<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
	</head>
	<body>
		<div class="nui-fit" style="padding-top:5px">
			<div id="form1" method="post">
				<input id="collection.id" name="collection.id" class="nui-hidden" />
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">采集名称：</th>
		                <td>    
		                    <input name="collection.collName" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">内容模型：</th>
		                <td>    
		                	<input name="collection.modelType" class="mini-combobox" style="width:150px;" textField="text" valueField="id" dataField="model"
							    url="<%=request.getContextPath()%>/siteconfig/collection/model.txt" value="1" allowInput="true"
							/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">归属栏目：</th>
		                <td>    
		                    <input name="collection.catId" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">栏目名称：</th>
		                <td>    
		                    <input name="collection.catName" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">页面编码：</th>
		                <td> 
		                	<input name="collection.pageCharset" class="mini-combobox" style="width:150px;" textField="text" valueField="id" dataField="charSet"
							    url="<%=request.getContextPath()%>/siteconfig/collection/charSet.txt" value="utf-8" allowInput="true"
							/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">采集地址：</th>
		                <td colspan="5">    
		                    <input name="collection.collUrl" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">是否采集图片：</th>
		                <td> 
		                   	<div name="collection.collImages" class="nui-radiobuttonlist"
							    textField="text" dataField="yesNo" valueField="id" value="2"
							    url="<%=request.getContextPath()%>/siteconfig/collection/yesNo.txt" >
							</div>   
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">列表标记：</th>
		                <td colspan="2">    
		                	<textarea name="collection.listTagsStart" class="mini-textarea nui-form-input"></textarea>
		                </td>
		                <td>
		                	<textarea name="collection.listTagsEnd" class="mini-textarea nui-form-input"></textarea>
		                </td>
		            </tr>
		            <tr>
		            	<th class="nui-form-label" style="display:table-cell; vertical-align:middle">采集内容规则：</th>
		            	<td colspan="5">
		            		<table style="width:100%;table-layout:fixed;border-left:1px solid #CCC;" class="nui-form-table">
		            			<tr>
					                <th class="nui-form-label">标题标记：</th>
					                <td>    
		                				<textarea name="collection.titleTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.titleTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">内容标记：</th>
					                <td>    
		                				<textarea name="collection.contentTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.contentTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">作者标记：</th>
					                <td>    
		                				<textarea name="collection.authorTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.authorTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">文号标记：</th>
					                <td>    
		                				<textarea name="collection.docnoTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.docnoTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">时间标记：</th>
					                <td>    
		                				<textarea name="collection.dtimeTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.dtimeTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">来源标记：</th>
					                <td>    
		                				<textarea name="collection.sourceTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.sourceTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
					            <tr>
					                <th class="nui-form-label">关键词标记：</th>
					                <td>    
		                				<textarea name="collection.keywordsTagsStart" class="mini-textarea nui-form-input"></textarea>
					                </td>
					                <td>
		                				<textarea name="collection.keywordsTagsEnd" class="mini-textarea nui-form-input"></textarea>
					                </td>
					            </tr>
		            		</table>
		            	</td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">定时采集：</th>
		                <td>
		                   	<div name="collection.collInterval" class="nui-radiobuttonlist"
							    textField="text" dataField="yesNo" valueField="id" value="2"
							    url="<%=request.getContextPath()%>/siteconfig/collection/yesNo.txt" >
							</div>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">采集完成：</th>
		                <td>
		                   	<div name="collection.isStatus" class="nui-radiobuttonlist"
							    textField="text" dataField="status" valueField="id" value="2"
							    url="<%=request.getContextPath()%>/siteconfig/collection/status.txt" >
							</div>
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
	        function SaveData() {
	           	form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        var json = nui.encode(data);
	            $.ajax({
	                url: "com.cms.siteconfig.CollectionService.addCollection.biz.ext",
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