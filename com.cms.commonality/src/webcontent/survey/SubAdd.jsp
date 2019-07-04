<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String surveyId = request.getParameter("surveyId");
 %>
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
				<input id="sub.surveyId" name="sub.surveyId" class="nui-hidden" value="<%=surveyId %>"/>
				<input id="sub.id" name="sub.id" class="nui-hidden"/>
				<input id="items" name="items" class="nui-hidden" />
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">题目：</th>
		                <td>    
		                    <input name="sub.subTitle" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">题目类型：</th>
		                <td>  
		                  	<input id="subType" name="sub.subType" class="mini-radiobuttonlist" 
		                    dataField="subType" textField="text" valueField="id" 
							url="<%=request.getContextPath()%>/commonality/survey/subType.txt"  
							repeatItems="1" repeatLayout="li" repeatDirection="vertical" value="1" onvaluechanged="subTypeClick"/> 
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">是否必填：</th>
		                <td>    
		                  	<input name="sub.isRequired" class="mini-radiobuttonlist"
		                    dataField="isRequired" textField="text" valueField="id" 
							url="<%=request.getContextPath()%>/commonality/survey/isRequired.txt"  
							repeatItems="1" repeatLayout="li" repeatDirection="vertical" value="1"/> 
		                </td>
		                <td></td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">排序：</th>
		                <td>    
		                    <input name="sub.sort" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label">题目选项：</th>
		                <td>    
		                    <a id="itemAdd" class="nui-button" iconCls="icon-add" onclick="addItem()">增加选项 </a>
		                </td>
		                <td></td>
		            </tr>
		            <tr>
		                <th class="nui-form-label"></th>
		                <td colspan="2">    
		                    <table id="itemHtml" style="width:100%"></table>
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
	        var form1 = new nui.Form("form1");
	        
	        var itemNum = 1;
	        function addItem(){
	        	var _html = "<tr id='item_"+itemNum+"'>"+ 
	        	"<td name='itemIndex' width='45' style='padding-right:0px;'>选项"+itemNum+"：</td>"+
	        	"<td><input name='itemName' class='nui-textbox nui-form-input'/></td>"+
	        	"<td width='60'><a class='nui-button icon-remove' onclick='removeItem("+itemNum+")' style='padding-left:20px;'>删除</a></td>"+
		        "</tr>";
	        	$("#itemHtml").append(_html);
	        	itemNum++;
	        }
	        function removeItem(item){
	        	$("#item_"+item).remove();
	        	$("td[name='itemIndex']").each(function(index){
					$(this).html("选项"+(index+1)+"：");
				});
	        	itemNum = itemNum-1;
	        }
	        
	        function SaveData() {
	           	form1.validate();
		        if(form1.isValid()==false) return;
		        var data1 = form1.getData(false,true);
		        var item_array = [];
		        $("input[name='itemName']").each(function(){
		            item_array.push($(this).val());
		        });
		        var items_json = "[";
		        for(var i=0;i<item_array.length;i++){
		        	if(i>0){
		        		items_json += ',{"itemName":"'+item_array[i]+'","sort":"'+(i+1)+'","surveyId":"<%=surveyId %>"}';
		        	}else{
		        		items_json += '{"itemName":"'+item_array[i]+'","sort":"'+(i+1)+'","surveyId":"<%=surveyId %>"}';
		        	}
		        }
		        items_json+="]";
		        data1.items = JSON.parse(items_json);
		        var json1 = nui.encode(data1);
	           	$.ajax({
	                url: "com.cms.commonality.SubService.addSub.biz.ext",
	                type: 'POST',
	                data: json1,
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
	        
	        function subTypeClick(){
	        	if(nui.get("subType").getValue()==3){
	        		nui.get("itemAdd").disable();
	        		$("#itemHtml").empty();
	        	}else{
	        		nui.get("itemAdd").enable();
	        	}
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