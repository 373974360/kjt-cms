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
		        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
		            <tr>
		                <th class="nui-form-label">姓名：</th>
		                <td>    
		                    <input name="jyxc.userName" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		                <th class="nui-form-label">电话：</th>
		                <td>    
		                    <input name="jyxc.tel" class="nui-textbox nui-form-input" required="true"/>
		                </td>
		            </tr>
		            <tr class="odd">
		                <th class="nui-form-label">工作单位：</th>
		                <td>    
		                    <input name="jyxc.orgNaem" class="nui-textbox nui-form-input"/>
		                </td>
		                <th class="nui-form-label">职务：</th>
		                <td>    
		                    <input name="jyxc.workPost" class="nui-textbox nui-form-input"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">1.你认为“十三五”陕西科技工作取得哪些成效：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtA" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">2.面对新形势我省科技工作还存在哪些突出问题：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtB" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">3.面向2035年我省科技发展思路建议：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtC" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">4.面向2035年我省重点研发方向建议：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtD" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">5.面向2035年科技体制改革和政策措施建议：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtE" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		            <tr>
		                <th class="nui-form-label" colspan="4" style="text-align:left;">6.科技与经济社会深度融合，有力支撑引领高质量发展建议：</th>
		            </tr>
		            <tr class="odd">
		                <td colspan="4">    
		                    <input name="jyxc.txtF" class="nui-textarea" style="width:100%"/>
		                </td>
		            </tr>
		        </table>    
		    </div>    
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">关闭</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
	        var form = new nui.Form("form1");
	        
	        function setData(data){
	        	data = nui.clone(data);
	        	var json = nui.decode({jyxc:data});
	            form.setData(json);
	            form.setChanged(false);
	        }
			function CloseWindow(action){
				if(action=="close"){

				}else if(window.CloseOwnerWindow)
					return window.CloseOwnerWindow(action);
				else
              	return window.close();
            }
	        function onCancel(e) {
	            CloseWindow("cancel");
	        }
	    </script>
	</body>
</html>