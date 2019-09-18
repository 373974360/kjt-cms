<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	/*importCms("1030","25");
	importCms("906","24");
	importCms("794","27");
	importCms("907","27");
	importCms("644","28");
	importCms("758","362");
	importCms("380","221");
	importCms("593","241");
	importCms("645","242");
	importCms("915","243");
	importCms("916","244");
	importCms("327","342");
	importCms("919","354");
	importCms("329","355");
	importCms("1121","357");
	importCms("1122","356");
	importCms("331","358");
	importCms("326","311");
	importCms("1091","750");
	importCms("1092","751");
	importCms("578","379");
	importCms("887","381");
	importCms("921","266");
	importCms("923","753");
	importCms("933","273");
	importCms("934","274");
	importCms("935","275");
	importCms("1084","754");
	importCms("1086","536");
	importCms("1087","537");
	importCms("1108","538");
	importCms("1109","539");
	importCms("1129","541");
	importCms("1128","540");
	importCms("1160","543");
	importCms("1159","542");
	importCms("1225","544");
	importCms("1226","545");
	importCms("938","755");
	importCms("1008","267");
	importCms("1161","283");
	importCms("1162","284");
	importCms("928","757");
	importCms("930","286");
	importCms("931","286");
	importCms("937","401");
	importCms("936","268");
	importCms("340","758");
	importCms("948","760");
	importCms("490","777");
	importCms("492","778");
	importCms("494","783");
	importCms("495","784");
	importCms("496","785");
	importCms("497","780");
	importCms("501","781");
	importCms("505","786");
	importCms("506","787");
	importCms("392","788");
	importCms("508","789");
	importCms("512","790");
	importCms("514","791");
	importCms("385","792");
	importCms("387","793");
	importCms("400","794");
	importCms("402","795");
	importCms("468","796");
	importCms("470","797");
	importCms("631","800");
	importCms("610","801");
	importCms("477","799");
	importCms("418","802");
	importCms("420","803");
	importCms("421","804");
	importCms("432","805");
	importCms("434","806");
	importCms("452","807");
	importCms("454","808");
	importCms("391","809");
	importCms("446","810");
	importCms("458","811");
	importCms("460","812");
	importCms("481","813");
	importCms("483","814");
	importCms("1167","815");
	importCms("1168","816");
	importCms("423","817");
	importCms("1132","818");
	importCms("525","776");
	importCms("1077","620");
	importCms("940","622");
	importCms("944","616");
	importCms("945","617");
	importCms("946","618");
	importCms("947","619");
	importCms("942","623");
	importCms("943","624");
	importCms("382","613");
	importCms("1133","382");
	importCms("1134","383");
	importCms("1135","384");
	importCms("1136","385");
	importCms("1138","386");
	importCms("1139","387");
	importCms("1140","388");
	importCms("1141","389");
	importCms("1142","390");
	importCms("1143","391");
	importCms("1144","394");
	importCms("1145","395");
	importCms("1146","742");*/
	importCms("1224","485");
	importCms("1164","363");
	importCms("1163","364");
	importCms("1155","365");
	importCms("1158","366");
	importCms("1124","426");
	importCms("1125","427");
	importCms("1126","1126");
	importCms("1127","1127");
	importCms("1153","435");
	importCms("1154","436");
	importCms("1148","431");
	importCms("1149","432");
	importCms("1150","433");
	importCms("1107","487");
	importCms("1110","488");
	importCms("1112","424");
	importCms("1101","418");
	importCms("1102","419");
	importCms("1103","420");
	importCms("1104","421");
	importCms("1105","486");
	importCms("1079","404");
	importCms("1080","405");
	importCms("1081","406");
	importCms("1082","407");
	importCms("1083","408");
	importCms("1099","490");
	importCms("1055","450");
	importCms("1056","451");
	importCms("1057","452");
	importCms("1059","453");
	importCms("1095","489");
	importCms("984","477");
	importCms("1088","472");
	importCms("1089","473");
	importCms("1090","474");
	importCms("1106","475");
	importCms("1115","476");
	importCms("1044","438");
	importCms("1045","439");
	importCms("1046","440");
	importCms("1047","441");
	importCms("1048","442");
	importCms("1042","493");
	importCms("1041","492");
	importCms("1023","410");
	importCms("1024","411");
	importCms("1025","412");
	importCms("1026","413");
	importCms("1027","414");
	importCms("1028","415");
	importCms("1029","416");
	importCms("983","941");
	importCms("969","612");
	importCms("974","832");
	importCms("971","833");
	importCms("972","834");
	importCms("957","465");
	importCms("968","466");
	importCms("878","482");
	importCms("878","481");
	importCms("854","822");
	importCms("897","480");
	importCms("912","823");
	importCms("621","824");
	importCms("622","825");
	importCms("623","503");
	importCms("624","463");
	importCms("625","826");
	importCms("626","464");
	importCms("635","827");
	importCms("653","478");
	importCms("654","503");
	importCms("688","828");
	importCms("807","829");
	importCms("808","455");
	importCms("809","456");
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
			String sql = "select a.id, a.title, a.subname, a.archieved_time,a.picsummary, a.source_url, a.fulltext, a.origin, a.scan, a.updatetime, a.operator_id from Article_Catalog as c inner join Article as a on c.aid = a.id where a.State= 1 and c.cid='"+oldCat+"' order by a.archieved_time desc";
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
				info.setString("infoStatus","3");
				info.setString("modelId","article");
				GkIndexVo indexVo = GkIndexUtils.getGkIndex(inputDtime.substring(0,4));
				info.setString("gkIndex", indexVo.getIndex());
				info.setString("gkYear", indexVo.getYear());
				info.setString("gkNum", indexVo.getNum());
				DatabaseExt.getPrimaryKey(info);
				String infoId = info.getString("id");
				
				infoContent.setString("infoId",infoId);
				infoContent.setString("infoContent",rs.getString("fulltext"));
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