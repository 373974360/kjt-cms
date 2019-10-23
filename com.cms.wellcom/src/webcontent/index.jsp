<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	UserObject userObject = (UserObject) request.getSession().getAttribute("userObject");
%>
<html>
	<head>
		<title>Title</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<div class="nui-panel" title="待办信息" iconCls="icon-tip" style="width: 50%;height: 80px;margin-top:10px;float:left;" showToolbar="false" showFooter="true">
			 我的待审信息：<span id="myAgencyCount"></span> 条
			<a href="<%=request.getContextPath()%>/wellcom/wellcome/pending_list.jsp">去处理>></a>；
			<span id="count_sq">
				未处理领导信箱来信：<span id="sqNoReplyCount"></span> 条
				<a href="<%=request.getContextPath()%>/commonality/sq/SqList.jsp?model_id=1">去处理>></a>；
			</span>
			<span id="count_sq_zxzx">
				未处理在线咨询来信：<span id="sqNoReplyCount_2"></span> 条
				<a href="<%=request.getContextPath()%>/commonality/sq/SqList.jsp?model_id=2">去处理>></a>；
			</span>
			<span id="count_ysqgk">
				未处理依申请公开：<span id="ysqgkNoReplyCount"></span> 条
				<a href="<%=request.getContextPath()%>/commonality/ysqgk/YsqgkList.jsp">去处理>></a>；
			</span>
		</div>
		<div class="nui-panel" title="今日数据汇总" iconCls="icon-print" style="width: 49%;height: 80px;margin-top:10px;float:right;" showToolbar="false" showFooter="true">
			信息录入：<span id="infoInputCount"></span>条； 
			信息发布：<span id="infoPublishCount"></span>条； 
			群众来信：<span id="sqInputCount"></span>条；
			依申请公开：<span id="ysqgkInputCount"></span>条； 
		</div>
		<div style="clear: both;"></div>
		<div class="nui-panel" title="快捷操作" iconCls="icon-find" style="width: 100%; height: 80px;margin-top:10px;" showToolbar="false" showFooter="true">
			<a class="nui-button" id="submitted" iconCls="icon-upload" href="<%=request.getContextPath()%>/wellcom/info/info_manager.jsp">信息报送 </a>
			<a class="nui-button" id="sq" iconCls="icon-new" href="<%=request.getContextPath()%>/commonality/sq/SqList.jsp?model_id=1">领导信箱 </a>
			<a class="nui-button" id="sq_zxzx" iconCls="icon-new" href="<%=request.getContextPath()%>/commonality/sq/SqList.jsp?model_id=2">在线咨询 </a>
			<a class="nui-button" id="survey" iconCls="icon-edit" href="<%=request.getContextPath()%>/commonality/survey/SurveyList.jsp">问卷调查 </a>
			<a class="nui-button" id="interview" iconCls="icon-goto" href="<%=request.getContextPath()%>/commonality/interview/InterviewList.jsp">领导访谈 </a>
			<a class="nui-button" id="info" iconCls="icon-addfolder" href="<%=request.getContextPath()%>/content/info/info_manager.jsp">内容管理 </a>
			<a class="nui-button" id="ysqgk" iconCls="icon-zoomin" href="<%=request.getContextPath()%>/commonality/ysqgk/YsqgkList.jsp">依申请公开 </a>
		</div>
	</body>
	<script type="text/javascript">
		getCount();
		function getCount() {
	        var json = nui.encode({"params/userId":"<%=userObject.getUserId() %>"});
            $.ajax({
                url: "com.cms.wellcom.WellComeService.getCount.biz.ext",
                type: 'POST',
                data: json,
                cache: false,
                contentType:'text/json',
                success: function (text) {
                	$("#myAgencyCount").html(text.dsData[0].TOTLE);
                	$("#sqNoReplyCount").html(text.sqNoReplyData[0].TOTLE);
                	$("#sqNoReplyCount_2").html(text.sqNoReplyData_2[0].TOTLE);
                	$("#ysqgkNoReplyCount").html(text.noYsqgkReplyData[0].TOTLE);
                	$("#infoInputCount").html(text.infoInputData[0].TOTLE);
                	$("#infoPublishCount").html(text.infoPublishData[0].TOTLE);
                	$("#sqInputCount").html(text.sqInputData[0].TOTLE);
                	$("#ysqgkInputCount").html(text.ysqgkInputData[0].TOTLE);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }
        setAuthBtn();
        function setAuthBtn(){
         		var btn = ["sq","sq_zxzx","ysqgk","submitted","survey","info","interview"];
         		var json = nui.encode({params:{userId:<%=userObject.getUserId() %>,funId:null}});
				$.ajax({
					url:"com.cms.content.ContentService.queryBtnAuth.biz.ext",
					type:'POST',
			         data:json,
			         cache:false,
			         contentType:'text/json',
			         success:function(text){
						for(var i=0;i<btn.length;i++){
							if(text.data.length>0){
								var b = false;
								for(var j=0;j<text.data.length;j++){
									if(btn[i] == text.data[j].RESID){
										b = true;
									}
								}
								if(!b){
									$("#"+btn[i]).remove();
									$("#count_"+btn[i]).remove();
								}
							}else{
								$("#"+btn[i]).remove();
								$("#count_"+btn[i]).remove();
							}
						}
			         }
	          	});
         	}
        
	</script>
</html>