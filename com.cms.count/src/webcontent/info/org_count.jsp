<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String catId = request.getParameter("catId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>信息统计</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/icons/icon.css"/>
		<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/count/echarts/echarts.min.js" type="text/javascript"></script>
	</head>
	<body style="width: 98%; height: 95%;">
		<input id="combobox3" class="mini-combobox" style="width:150px;" textField="text" valueField="id" dataField="data"
		    url="<%=request.getContextPath()%>/count/info/orgType.txt" value="41" required="true"
		    onvaluechanged="refresh"/>  
		<div id="datagrid1" dataField="data" ajaxData="setRoleId" class="nui-datagrid" style="width: 100%; height: 100%;margin-top:10px;" showPager = "false"
			url="com.cms.count.vo.InfoCountService.infoCountByOrg.biz.ext" multiSelect="true" allowSortColumn="false" allowAlternating="true">
			<div property="columns">
				<div field="orgName" width="auto" headerAlign="center" allowSort="true">机构名称</div>
				<div field="count" width="100" headerAlign="center" allowSort="true">信息总数</div>
				<div field="publisCount" width="100" headerAlign="center" allowSort="true">采用总数</div>
				<div field="upMonthCount" width="100" headerAlign="center" allowSort="true">上月采用</div>
				<div field="yearCount" width="100" headerAlign="center" allowSort="true">全年采用</div>
				<div field="proportion" width="100" headerAlign="center" allowSort="true">采用率</div>
			</div>
		</div>
		<div id="main" style="width:100%;height:400px;"></div>
		<script type="text/javascript">
	   		nui.parse();
	   		var grid = nui.get("datagrid1");
	   		grid.load();
			
			
			//重新刷新页面
			function refresh() {
				grid.load();
				loadData();
			}
			
			function openCountList(orgId,infoStatus) {
				var url = "<%=request.getContextPath()%>/count/info/countInfoList.jsp?catId=<%=catId %>&inputUser=&infoStatus="+infoStatus+"&startTime=<%=startTime %>&endTime=<%=endTime %>&orgId="+orgId;
				nui.open({
					url : url,
					title : "内容详情",
					width : '80%',
					height : '80%',
					onload : function() {
					},
				});
			}
	   		
		    function setRoleId(){
		    	var orgPid = nui.get("combobox3").getValue();
				return {"orgPid":orgPid,"catId":"<%=catId %>","startTime":"<%=startTime %>","endTime":"<%=endTime %>"};
			}
			var myChart = echarts.init(document.getElementById('main'));
			loadData();
			function loadData(){
				var charText = [['product', '总数', '已采用', '上月采用', '全年采用']];
				var json =  nui.encode(setRoleId());
				$.ajax({
					url:"com.cms.count.vo.InfoCountService.infoCountByOrg.biz.ext",
					type:'POST',
			        data:json,
			        cache:false,
			        sync:false,
			        contentType:'text/json',
			        success:function(text){
			        	if(text.data.length>0){
			        		for(var i=0;i<text.data.length;i++){
		        				charText.push([''+text.data[i].orgName+'',text.data[i].count,text.data[i].publisCount,text.data[i].upMonthCount,text.data[i].yearCount]);
			        		}
			        		console.log(charText);
			        		var option = {
							    legend: {},
							    tooltip: {},
							    dataset: {
							        source: charText
							    },
							    xAxis: {type: 'category',axisTick:{interval:0},axisLabel:{interval:0,rotate:40}},
							    yAxis: {},
							    // Declare several bar series, each will be mapped
							    // to a column of dataset.source by default.
							    series: [
							        {type: 'bar'},
							        {type: 'bar'},
							        {type: 'bar'},
							        {type: 'bar'}
							    ]
							};
							myChart.setOption(option);
			        	}
			        }
	          	});
	        }
		</script>
	</body>
</html>
