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
		<div id="datagrid1" dataField="data" ajaxData="setRoleId" class="nui-datagrid" style="width: 100%; height: 100%;" showPager = "false"
			url="com.cms.count.vo.InfoCountService.infoCountByUser.biz.ext" multiSelect="true" allowSortColumn="false" allowAlternating="true"
			showSummaryRow="true" ondrawsummarycell="onDrawSummaryCell" ondrawcell="onDrawCell">
			<div property="columns">
				<div field="userName" width="auto" headerAlign="center" allowSort="true">姓名</div>
				<div field="count" width="100" headerAlign="center" allowSort="true">信息总数</div>
				<div field="publisCount" width="100" headerAlign="center" allowSort="true">采用总数</div>
				<div field="proportion" width="100" headerAlign="center" allowSort="true">采用率</div>
				<div field="total" width="150" headerAlign="center" allowSort="true">总计</div>
			</div>
		</div>
		<div id="main" style="width:100%;height:400px;"></div>
		<script type="text/javascript">
	   		nui.parse();
	   		var grid = nui.get("datagrid1");
	   		grid.load();
			
			function onDrawCell(e) {
	            var record = e.record;
	            if (e.field == "total") {
	                var count = record.count;
	                var publisCount = record.publisCount;
	                e.cellHtml = publisCount;
	            }
	        }
	   		grid.on("drawcell", function (e) {
			    var field = e.field,
			        value = e.value,
			        row = e.row;
			    if (field == "publisCount") {
		      		e.cellHtml = row.publisCount+"<a style='cursor:pointer;padding-left:10px;' href='javascript:openCountList("+row.empId+",3)'>查看详情</a>";
			    }
			});
        
	        function onDrawSummaryCell(e) {
	            var result = e.result;
	            var grid = e.sender;
	            var rows = e.data;
	            if (e.field == "total") {
	                var count = 0;
	                var publisCount = 0;
	                for (var i = 0, l = rows.length; i < l; i++) {
	                    var row = rows[i];
	                    var t = row.count;
	                    if (isNaN(t)) continue;
	                    count += t;
	                }
	                for (var i = 0, l = rows.length; i < l; i++) {
	                    var row = rows[i];
	                    var t = row.publisCount;
	                    if (isNaN(t)) continue;
	                    publisCount += t;
	                }
	                e.cellHtml = "总计: " + count+";已发布: "+publisCount;
	            }
        	}
			
			function openCountList(inputUser,infoStatus) {
				var url = "<%=request.getContextPath()%>/count/info/countInfoList.jsp?catId=<%=catId %>&orgId=&infoStatus="+infoStatus+"&startTime=<%=startTime %>&endTime=<%=endTime %>&inputUser="+inputUser;
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
				return {"catId":"<%=catId %>","startTime":"<%=startTime %>","endTime":"<%=endTime %>"};
			}
			
			var myChart = echarts.init(document.getElementById('main'));
			var charText = [['product', '总数', '已采用']];
			loadData();
			function loadData(){
				var json =  nui.encode(setRoleId());
				$.ajax({
					url:"com.cms.count.vo.InfoCountService.infoCountByUser.biz.ext",
					type:'POST',
			        data:json,
			        cache:false,
			        sync:false,
			        contentType:'text/json',
			        success:function(text){
			        	if(text.data.length>0){
			        		for(var i=0;i<text.data.length;i++){
		        				charText.push([''+text.data[i].userName+'',text.data[i].count,text.data[i].publisCount]);
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
