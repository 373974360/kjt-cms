<%@page import="com.cms.view.survey.CmsSurveyItem"%>
<%@page import="com.cms.view.survey.CmsSurveyItemText"%>
<%@page import="com.cms.view.survey.CmsSurveySub"%>
<%@page import="com.cms.view.data.SurveyUtil"%>
<%@page import="com.cms.view.survey.CmsSurvey"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	CmsSurvey survey = SurveyUtil.getSurveyContent(request.getParameter("surveyId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script>
		<style type="text/css">
			.title{text-align:center;font-size:24px;line-height:50px;height:50px;}
			.banner{line-height:30px;height:30px;text-align:center;border-top:1px dashed #ccc;border-bottom:1px dashed #ccc;}
			li{padding-left:30px;}
		</style>
	</head>
	<body>
		<div class="nui-fit" style="padding:10px">
			<p class="title"><%=survey.getTitle() %></p>
			<p class="banner">
				开始时间：<%=survey.getStartTime() %>&nbsp;&nbsp;
				截止时间：<%=survey.getEndTime() %> &nbsp;
				参与人次： <%=survey.getPepoleNum() %>&nbsp;&nbsp;
				获得总票数：<%=survey.getNum() %>
			</p>
	        <%
        		for(CmsSurveySub sub:survey.getSubList()){
	        %>
	       <table>
	            <tr>
	                <td class="subTitle">
	                    <%=sub.getSort() %>:<%=sub.getSubTitle() %>
	                    <%
	                    	if(sub.getSubType()==3){
	                    %>
	                      	【留言数：<%=sub.getNum() %>条】
	                    <%	
	                    	}else{
	                   	%>
	                      	【总票数：<%=sub.getNum() %>票】
	                    <%
	                    	}
	                    %>
	                <td>
	            </tr>
	            <tr>
	                <td>
	                    <ul>
	                     	<%
		                    	if(sub.getSubType()==3){
		                    		for(CmsSurveyItemText itemText:sub.getItemTextlist()){
		                    		%>
		                    			<li><%=itemText.getItemText() %></li>
		                    		<%
		                    		}
		                    	}else{
		                   			for(CmsSurveyItem item:sub.getItemList()){
		                    		%>
		                    			<li><%=item.getItemName() %>【票数：<%=item.getNum() %>;百分比：<%=item.getProportion() %>】</li>
		                    		<%
		                    		}
		                    	}
		                    %>
	                    </ul>
	                </td>
	            </tr>
	        </table>
	        <%
        		}
	        %>
		</div>
		<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
			 <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">关闭</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
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