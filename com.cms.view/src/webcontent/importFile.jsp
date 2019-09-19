<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	
	importCms("944","616");
	importCms("945","617");
	importCms("946","618");
	importCms("947","619");
	
 %>
<%!
	private void importCms(String oldCat,String newCat){
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
			String sql = "select a.id, a.title, a.subname, a.archieved_time,a.picsummary, a.source_url, a.fulltext, a.origin, a.scan, a.updatetime, a.operator_id,a.original_url from Article_Catalog as c inner join Article as a on c.aid = a.id where a.State= 1 and c.cid='"+oldCat+"' order by a.archieved_time desc";
			String sqlCount = "select count(*) as totle from Article_Catalog as c inner join Article as a on c.aid = a.id where a.State= 1 and c.cid='"+oldCat+"'";
			
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
				DataObject info = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
				DataObject infoContent = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfoContent");
				info.setString("siteId", "21");
				info.setString("catId", newCat);
				info.setString("infoTitle",rs.getString("title"));
				info.setString("subTitle",rs.getString("subname"));
				info.setString("thumbUrl",rs.getString("picsummary"));
				info.setString("source",rs.getString("origin"));
				info.setString("weight", "60");
				info.setString("hits", rs.getString("scan"));
				info.setString("isTop", "2");
				info.setString("isTuijian", "2");
				String releasedDtime = "2019-08-29 17:04:00";
				String time1 = rs.getString("archieved_time");
				if(StringUtils.isNotBlank(time1)&&time1.length()>20){
					time1 = time1.substring(0,20);
					releasedDtime = time1;
				}
				info.setString("releasedDtime", releasedDtime);
				info.setString("inputUser", rs.getString("operator_id"));
				
				
				String inputDtime = "2019-08-29 17:04:00";
				String time2 = rs.getString("updatetime");
				if(StringUtils.isNotBlank(time2)&&time2.length()>20){
					time2 = time2.substring(0,20);
					inputDtime = time2;
				}
				info.setString("inputDtime",inputDtime);
				info.setString("sourceUrl",rs.getString("source_url"));
				info.setString("contentUrl",rs.getString("original_url"));
				info.setString("infoStatus","3");
				info.setString("modelId","download");
				GkIndexVo indexVo = GkIndexUtils.getGkIndex(inputDtime.substring(0,4));
				info.setString("gkIndex", indexVo.getIndex());
				info.setString("gkYear", indexVo.getYear());
				info.setString("gkNum", indexVo.getNum());
				DatabaseExt.getPrimaryKey(info);
				DatabaseUtil.insertEntity("default", info);
				it++;
				System.out.println("ID为："+rs.getString("id")+"的信息导入成功；信息总数："+counts+";当前第："+it+"条");
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}
 %>