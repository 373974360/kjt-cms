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
            	<input name="content.infoContent" class="nui-hidden"/>
            	<input name="content.picContent" class="nui-hidden"/>
           		<script type="text/plain" id="upload_ue"></script>
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
		                    <input name="infoCat.catId" id="select1" class="nui-treeselect" style="width:150px;" url="com.cms.content.ContentService.queryInfoCategoryTreeNode.biz.ext"
							    textField="text" dataField="data" valueField="realId" parentField="pid" onbeforeload="onBeforeTreeLoad" multiSelect="true"/>
		                </td>
		                <td></td>
		            </tr>       
		            <tr>
		                <th class="nui-form-label">列表标题：</th>
		                <td colspan="5">    
		                    <input name="info.topTitle" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>       
		            <tr>
		                <th class="nui-form-label">信息标题：</th>
		                <td colspan="5">    
		                    <input name="info.infoTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">简短标题：</th>
		                <td colspan="5">    
		                    <input name="info.subTitle" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>  
		            <tr>
		                <th class="nui-form-label">来源：</th>
		                <td>    
		                	<div name="info.source" class="nui-combobox" style="width:100px;" popupWidth="400" textField="sourceName" valueField="sourceName"
							    url="com.cms.basics.SourceService.querySourceAll.biz.ext" dataField="data" multiSelect="true"  >
							</div>
		                </td>
		                <th class="nui-form-label">作者：</th>
		                <td>    
		                	<div name="info.author" class="nui-combobox" style="width:100px;" popupWidth="400" textField="authorName" valueField="authorName"
							    url="com.cms.basics.AuthorService.queryAuthorAll.biz.ext" dataField="data" multiSelect="true"  >
							</div>
		                </td>
		                <th class="nui-form-label">网络编辑：</th>
		                <td>    
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
		                   <textarea name="info.description" class="nui-textarea" style="width:560px;"></textarea>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">标题图片：</th>
		                <td colspan="5">    
		                   <input name="info.thumbUrl" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">发布状态：</th>
		                <td colspan="5">    
			                <div name="info.infoStatus" class="nui-radiobuttonlist"
							    textField="text" dataField="infoStatus" valueField="id" value="3"
							    url="<%=request.getContextPath()%>/content/info/infoStatus.txt">
							</div>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">权重：</th>
		                <td>    
		                	<input name="info.weight" value="60" class="nui-spinner"  minValue="0" maxValue="99"/>
		                </td>
		                <th class="nui-form-label">点击数：</th>
		                <td>    
		                	<input name="info.hits" value="0" class="nui-spinner"  minValue="0" maxValue="99"/>
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
		            <tr>
		                <th class="nui-form-label">组图内容：</th>
		                <td colspan="5" id="picArray"></td>
		                <td valign="top">
		                   <a id="update" class="nui-button" iconCls="icon-upload" onclick="upImage();">上传组图 </a>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">文字内容：</th>
		                <td colspan="6">
		                   	<textarea id="content" style="height:300px;width:98%;"></textarea>
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
	        var upload_ue = UE.getEditor('upload_ue');
			upload_ue.ready(function () {
				//设置编辑器不可用
				//upload_ue.setDisabled();
				//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
				upload_ue.hide();
				//侦听图片上传
				upload_ue.addListener('beforeInsertImage', function (t, arg) {
					var _html = "<table>";
					if(arg.length>0){
						for(var i=0;i<arg.length;i++){
							_html+="<tr id='picArray_"+i+"'><td><img src='"+arg[i].src+"' width='200' height='120'/><input type='hidden' name='picUrl' value='"+arg[i].src+"'/></td>";
							_html+="<td valign='top'><div>标题：<input type='text' name='picTitle' class='nui-textbox nui-form-input' value='"+arg[i].alt+"'/></div><div>描述：<textarea name='picRemark' style='height:60px;width:100%;font-size:14px;'></textarea></div></td>";
							_html+="<td><a class='icon-remove' onclick='removePic("+i+")' style='padding-left:20px;cursor:pointer'>移除</a><br/><a class='icon-add' onclick=setThumbUrl('"+arg[i].src+"') style='padding-left:20px;cursor:pointer'>设为标题图</a></td></tr>";
						}
					}
					_html+="</table>";
					$("#picArray").html(_html);
				});
			});
			function removePic(index){
				$("#picArray_"+index).remove();
			}
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
			         }
	          	});
	        }
	        
	        function SaveData() {
		        form.validate();
		        if(form.isValid()==false) return;
		        var data = form.getData(false,true);
		        data.info.thumbUrl = $("input[name='info.thumbUrl']").val();
		        data.content.infoContent = ue.getContent();
		        data.content.picContent = getPicContent();
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
	                url: "com.cms.content.ContentService.addInfo.biz.ext",
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
	        
	        function getPicContent(){
		        var picTitles = [];
		        $("input[name='picTitle']").each(function(){
	            	picTitles.push($(this).val());
		        });
		        var picUrls = [];
		        $("input[name='picUrl']").each(function(){
	            	picUrls.push($(this).val());
		        });
		        var picRemarks = [];
		        $("textarea[name='picRemark']").each(function(){
	            	picRemarks.push($(this).val());
		        });
		        var picArray = '{"picArray": [';
		        if(picTitles.length>0){
		        	for(var i=0;i<picTitles.length;i++){
		        		if(i>0){
		        			picArray+=",";
		        		}
		        		picArray+='{"src":"'+picUrls[i]+'","title":"'+picTitles[i]+'","remark":"'+picRemarks[i]+'"}';
		        	}
		        }
		        picArray+="]}";
		        return picArray;
	        }
	        function setThumbUrl(picUrl){
	        	console.log(picUrl);
	        	$("input[name='info.thumbUrl']").val(picUrl);
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