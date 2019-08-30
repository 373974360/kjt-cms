<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject,com.cms.view.form.SqForm" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	importCms();
 %>
<%!
	private void importCms(){
		int counts = 0;
		int it = 0;
		String driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
		String userName = "sa"; //登录用户名
		String userPasswd = "123456"; //登录密码
		String dbName="scl_info";	//数据库名	
		String url = "jdbc:sqlserver://10.211.55.6:1433;databaseName=" + dbName; 
		try {
			Class.forName(driverClassName);
			Connection conn = DriverManager.getConnection(url, userName, userPasswd);
			System.out.println("数据库连接成功");
			Statement stmt = conn.createStatement();
			String sql = "select l.id,l.title,l.content,l.archievedtime,l.email,l.address,l.uname,l.phone,l.ip,l.type,h.content as replay,h.archievedtime as replaytime from Leave l left join LeaveHf h on l.id=h.gbId";
			String sqlCount = "select count(*) as totle from Leave l left join LeaveHf h on l.id=h.gbId";
			
			Statement stmtCount = conn.createStatement();
			ResultSet rsCount = stmtCount.executeQuery(sqlCount);
			while(rsCount.next()) {
				  String totleStr = rsCount.getString("totle");
				  if(totleStr != null && !"".equals(totleStr)) {
					  counts = Integer.parseInt(totleStr);
				  }
		  	}
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				DataObject sq = DataObjectUtil.createDataObject("com.cms.commonality.sq.CmsSq");
				DataObject sqPross = DataObjectUtil.createDataObject("com.cms.commonality.sqPro.CmsSqPro");
				DatabaseExt.getPrimaryKey(sq);
				sq.setString("title", rs.getString("title"));
				sq.setString("username", rs.getString("uname"));
				sq.setString("address", rs.getString("address"));
				sq.setString("phone", rs.getString("phone"));
				sq.setString("email", rs.getString("email"));
				sq.setString("isOpen", "1");
				sq.setString("content", rs.getString("content"));
				
				String createTime = "2019-08-29 17:04:00";
				String time1 = rs.getString("archievedtime");
				if(StringUtils.isNotBlank(time1)&&time1.length()>19){
					time1 = time1.substring(0,19);
					createTime = time1;
				}
				sq.setString("createTime", createTime);
				
				String replyTime = "2019-08-29 17:04:00";
				String time2 = rs.getString("replaytime");
				if(StringUtils.isNotBlank(time2)&&time2.length()>19){
					time2 = time2.substring(0,19);
					replyTime = time2;
				}
				sq.setString("replyTime",replyTime);
				String reply = rs.getString("replay");
				sq.setString("replyContent", rs.getString("replay"));
				if(StringUtils.isNotBlank(reply)){
					sq.setString("isPublish", "1");
					sq.setString("isReply", "1");
					
					DatabaseExt.getPrimaryKey(sqPross);
					sqPross.setString("sqId",sq.getString("id"));
					sqPross.setString("reType","2");
					sqPross.setString("reTime",replyTime);
					sqPross.setString("remark",reply);
					DatabaseUtil.insertEntity("default", sqPross);
				}else{
					sq.setString("isPublish", "2");
					sq.setString("isReply", "2");
				}
				sq.setString("searchCode", SqForm.getSearchCode());
				sq.setString("searchPwd", SqForm.getSearchPwd());
				
				DatabaseUtil.insertEntity("default", sq);
				it++;
				System.out.println("ID为："+rs.getString("id")+"的信息导入成功；信息总数："+counts+";当前第："+it+"条");
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}
 %>