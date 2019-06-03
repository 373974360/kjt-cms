<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): liuzn (mailto:liuzn@primeton.com)
  - Date: 2013-03-01 13:51:37
  - Description:
-->
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	String userId = request.getParameter("userId");
 %>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="/coframe/tools/skins/common.jsp" %>
<title>角色功能授权</title>
</head>
<body>
<div class="nui-fit" style="padding:10px;">
<div id="panel1" class="nui-panel" style="width:100%;height:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                	<a class="nui-button" iconCls="icon-save" onclick="SaveData" title="保存"></a>
                </td>
            </tr>
        </table> 
    </div>
    <!--body-->
 	<div class="nui-fit" style="padding:0px 10px 10px 10px;">
		<div id="form1" method="post">
			<input id="userdata.id" name="userdata.id" class="nui-hidden" />
			<input id="userdata.userId" name="userdata.userId" class="nui-hidden" value="<%=userId %>" />
	        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
	            <tr>
	                <th class="nui-form-label">新闻读取权限：</th>
	                <td>    
	                    <div name="userdata.infoData" class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
						    textField="text" valueField="id" dataField="infoRead"
						    url="<%=request.getContextPath()%>/content/category/infoRead.txt" >
						</div>
	                </td>
	            </tr>
	            <tr>
	                <th class="nui-form-label">群众来信读取权限：</th>
	                <td>    
	                    <div name="userdata.sqData" class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
						    textField="text" valueField="id" dataField="sqRead"
						    url="<%=request.getContextPath()%>/content/category/sqRead.txt" >
						</div>
	                </td>
	            </tr>        
	        </table>    
	    </div>     
	</div>
</div>
</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	
	var form = new nui.Form("form1");
	
	setData();
	function setData(){
		var json = nui.encode({params:{"userId":"<%=userId %>"}});
		$.ajax({
			url:"com.cms.content.CategoryService.getAuthUserData.biz.ext",
			type:'POST',
	         data:json,
	         cache:false,
	         contentType:'text/json',
	         success:function(text){
				obj = nui.decode(text);
				obj.userdata = obj.userdata[0];
	            form.setData(obj);
	            form.setChanged(false);
	         }
	  	});
	}
    function SaveData() {
       	form.validate();
        if(form.isValid()==false) return;
        var data = form.getData(false,true);
        data.userdata.userId = <%=userId %>
        var json = nui.encode(data);
        $.ajax({
            url: "com.cms.content.CategoryService.setAuthUserData.biz.ext",
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
</script>