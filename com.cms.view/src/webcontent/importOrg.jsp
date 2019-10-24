<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	importOrg("pf_drugresearch_center","568");//创新药物研究中心
	importOrg("pf_clinical_medicine","567");//临床医学研究中心
	importOrg("pf_laboratory_room","565");//重点实验室
	importOrg("pf_colleges","562");//高等院校
	importOrg("pf_cientific_research_institutes","563");//科研院所
	importOrg("pf_engineering_research_center","566");//工程技术研究中心
	importOrg("pf_itri","564");//工业技术研究院
 %>
<%!
	private void importOrg(String tableName,String newCat){
		int counts = 0;
		int it = 0;
		String driverClassName = "com.mysql.jdbc.Driver"; 
		String userName = "root"; //登录用户名
		String userPasswd = "root"; //登录密码
		String dbName="psd";	//数据库名	
		String url = "jdbc:mysql://192.168.0.118:3306/"+dbName+"?user="+userName+"&password="+userPasswd;
		try {
			Class.forName(driverClassName);
			Connection conn = DriverManager.getConnection(url, userName, userPasswd);
			System.out.println("数据库连接成功");
			Statement stmt = conn.createStatement();
			String sql = "select * from "+tableName;
			String sqlCount = "select count(*) as totle from "+tableName;
			
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
				String title = "";
				String content = "";
				if(tableName.equals("pf_drugresearch_center")){
					title = rs.getString("center_name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_clinical_medicine")){
					title = rs.getString("center_name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_laboratory_room")){
					title = rs.getString("laboratory_name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_cientific_research_institutes")){
					title = rs.getString("name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_engineering_research_center")){
					title = rs.getString("center_name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_itri")){
					title = rs.getString("itri_name");
					content = rs.getString("synopsis");
				}
				if(tableName.equals("pf_colleges")){
					title = rs.getString("school_name");
					String history = rs.getString("history");
					String discipline_construction = rs.getString("discipline_construction");
					String scientific_research = rs.getString("scientific_research");
					String achievements = rs.getString("achievements");
					content += "<p style=\"text-align: left; text-indent: 2em;\"><strong>历史沿革</strong></p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\">"+history+"</p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\"><strong>学科建设</strong></p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\">"+discipline_construction+"</p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\"><strong>科研机构</strong></p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\">"+scientific_research+"</p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\"><strong>科研成果</strong></p>";
					content += "<p style=\"text-align: left; text-indent: 2em;\">"+achievements+"</p>";
				}
				info.setString("infoTitle",title);
				infoContent.setString("infoContent",content);
				info.setString("weight", "60");
				info.setString("hits", "0");
				info.setString("isTop", "2");
				info.setString("isTuijian", "2");
				info.setString("releasedDtime", "2019-10-24 09:32:00");
				info.setString("inputUser", "1");
				String inputDtime = "2019-10-24 09:32:00";
				info.setString("inputDtime",inputDtime);
				info.setString("infoStatus","3");
				info.setString("modelId","article");
				GkIndexVo indexVo = GkIndexUtils.getGkIndex(inputDtime.substring(0,4));
				info.setString("gkIndex", indexVo.getIndex());
				info.setString("gkYear", indexVo.getYear());
				info.setString("gkNum", indexVo.getNum());
				DatabaseExt.getPrimaryKey(info);
				String infoId = info.getString("id");
				infoContent.setString("infoId",infoId);
				DatabaseExt.getPrimaryKey(infoContent);
				DatabaseUtil.insertEntity("default", info);
				DatabaseUtil.insertEntity("default", infoContent);
				it++;
				System.out.println("ID为："+rs.getString("id")+"的信息导入成功；信息总数："+counts+";当前第："+it+"条");
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}
 %>