<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	importCms("1079","404");//2
	importCms("1080","405");//1
	importCms("1081","406");//5
	importCms("1082","407");//31
	importCms("1083","408");//3
	importCms("1023","410");//3
	importCms("1024","411");//1
	importCms("1025","412");//3
	importCms("1026","413");//12
	importCms("1027","414");//6
	importCms("1028","415");//5
	importCms("1029","416");//4
	importCms("1101","418");//1
	importCms("1102","419");//5
	importCms("1103","420");//48
	importCms("1104","421");//1
	importCms("1111","423");//1
	importCms("1112","424");//16
	importCms("1124","426");//2
	importCms("1125","427");//55
	importCms("1126","428");//1
	importCms("1127","429");//1
	importCms("1148","431");//61
	importCms("1149","432");//28
	importCms("1150","433");//50
	importCms("1153","435");//24
	importCms("1154","436");//2
	importCms("1044","438");//1
	importCms("1045","439");//62
	importCms("1046","440");//10
	importCms("1047","441");//5
	importCms("1048","442");//1
	importCms("1088","472");//113
	importCms("1089","473");//264
	importCms("1090","474");//50
	importCms("1106","475");//8
	importCms("1115","476");//13
	importCms("1055","450");//5
	importCms("1056","451");//10
	importCms("1057","452");//18
	importCms("1059","453");//9
	importCms("808","455");//2
	importCms("809","456");//3
	importCms("991","458");//11
	importCms("992","459");//2
	importCms("993","460");//8
	importCms("994","461");//13
	importCms("995","462");//10
	importCms("624","463");//4
	importCms("626","464");//1
	importCms("957","465");//2
	importCms("968","466");//151
	importCms("969","612");//84
	importCms("984","477");//108
	importCms("653","478");//2
	importCms("654","479");//1
	importCms("897","480");//3
	importCms("858","481");//2
	importCms("878","482");//2
	importCms("806","483");//1
	importCms("1155","365");//147
	importCms("1151","484");//1
	importCms("1158","366");//33
	importCms("1163","364");//48
	importCms("1164","363");//29
	importCms("1224","485");//136
	importCms("1105","486");//280
	importCms("1107","487");//63
	importCms("1110","488");//1
	importCms("1095","489");//61
	importCms("1099","490");//9
	importCms("1049","491");//11
	importCms("1041","492");//30
	importCms("1042","493");//42
	importCms("1002","497");//4
	importCms("1003","498");//4
	importCms("1004","499");//2
	importCms("996","500");//1
	importCms("998","501");//1
	importCms("999","502");//3
	importCms("143","503");//1
	importCms("761","512");//159
	importCms("1017","507");//1
	importCms("1018","508");//1
	importCms("1019","509");//1
	importCms("1020","510");//1
	importCms("645","242");//1
	importCms("915","243");//10
	importCms("916","244");//11
	importCms("936","268");//2
	importCms("937","401");//51
	importCms("938","515");//29
	importCms("340","516");//36
	importCms("544","517");//3
	importCms("548","373");//25
	importCms("1008","267");//15
	importCms("1084","518");//44
	importCms("350","520");//2
	importCms("353","521");//1
	importCms("887","381");//53
	importCms("1091","522");//17
	importCms("1092","523");//93
	importCms("578","379");//44
	importCms("918","526");//1
	importCms("655","527");//2
	importCms("656","528");//2
	importCms("657","529");//1
	importCms("658","530");//2
	importCms("670","531");//2
	importCms("672","532");//1
	importCms("675","533");//4
	importCms("676","534");//3
	importCms("371","535");//1
	importCms("928","548");//20
	importCms("1161","283");//10
	importCms("1162","284");//7
	importCms("326","311");//2
	importCms("327","688");//11
	importCms("921","266");//79
	importCms("923","550");//50
	importCms("933","273");//15
	importCms("934","274");//19
	importCms("935","275");//8
	importCms("1086","536");//20
	importCms("1087","537");//13
	importCms("1108","538");//24
	importCms("1109","539");//7
	importCms("1128","540");//10
	importCms("1129","541");//32
	importCms("1159","542");//15
	importCms("1160","543");//27
	importCms("1225","544");//8
	importCms("1226","545");//48
	importCms("369","546");//8
	importCms("930","286");//25
	importCms("931","286");//27
	importCms("1121","357");//13
	importCms("1122","356");//1
	importCms("329","355");//8
	importCms("331","358");//27
	importCms("919","354");//17
	importCms("1167","555");//1
	importCms("1168","556");//2
	importCms("385","558");//92
	importCms("387","559");//6
	importCms("400","561");//179
	importCms("402","562");//30
	importCms("481","564");//224
	importCms("483","565");//3
	importCms("508","567");//134
	importCms("512","568");//44
	importCms("514","569");//24
	importCms("392","570");//13
	importCms("1132","572");//11
	importCms("490","574");//71
	importCms("492","575");//2
	importCms("418","577");//40
	importCms("420","578");//6
	importCms("421","579");//6
	importCms("423","581");//118
	importCms("432","583");//141
	importCms("434","584");//14
	importCms("446","586");//45
	importCms("452","588");//85
	importCms("454","589");//4
	importCms("388","590");//12
	importCms("458","592");//147
	importCms("460","593");//11
	importCms("468","595");//65
	importCms("470","596");//1
	importCms("471","597");//1
	importCms("477","598");//6
	importCms("391","590");//2
	importCms("474","599");//1
	importCms("476","600");//2
	importCms("494","603");//16
	importCms("495","604");//5
	importCms("496","605");//19
	importCms("505","607");//35
	importCms("506","608");//24
	importCms("631","611");//2
	importCms("380","221");//1500
	importCms("382","613");//6500
	importCms("521","572");//1
	importCms("525","615");//1
	importCms("948","614");//124
	importCms("1166","556");//4
	importCms("940","622");//180
	importCms("942","623");//46
	importCms("943","624");//12
	importCms("944","616");//28
	importCms("945","617");//39
	importCms("946","618");//17
	importCms("947","619");//15
	importCms("1077","620");//30
	importCms("830","522");//2
	importCms("832","521");//2
	importCms("324","687");//1
	importCms("593","241");//597
	importCms("620","686");//2
	importCms("644","28");//4780
	importCms("758","362");//65
	importCms("794","27");//3680
	importCms("813","685");//41
	importCms("814","25");//4
	importCms("816","684");//5
	importCms("906","24");//1657
	importCms("907","27");//3021
	importCms("908","683");//6
	//importCms("1030","25");//8299
	importCms("1093","681");//1149
	importCms("1094","682");//1556
	importCms("1134","383");//2
	importCms("1135","384");//5
	importCms("1133","382");//
	importCms("1136","385");//
	importCms("1138","386");//3
	importCms("1139","387");//83
	importCms("1140","388");//156
	importCms("1141","389");//2
	importCms("1142","390");//1
	importCms("1143","391");//2
	importCms("1145","395");//
	importCms("1144","394");//3
	importCms("1146","395");//1
	importCms("41","628");//563
	importCms("42","629");//620
	importCms("43","625");//70
	importCms("44","626");//4
	importCms("303","522");//2
	importCms("304","626");//1
	importCms("305","521");//2
	importCms("64","637");//1
	importCms("1062","631");//1
	importCms("1063","632");//1
	importCms("1064","633");//4
	importCms("1065","634");//1
	importCms("1066","635");//13
	importCms("1073","636");//9
	importCms("1074","638");//9
	importCms("1075","640");//17
	importCms("357","641");//4
	importCms("358","642");//11
	importCms("360","643");//1
	importCms("361","644");//3
	importCms("362","645");//3
	importCms("365","646");//4
	importCms("335","647");//1
	importCms("411","648");//1
	importCms("413","649");//1
	importCms("414","650");//1
	importCms("487","651");//4
	importCms("953","652");//4
	importCms("955","653");//11
	importCms("1156","654");//5
	importCms("1116","655");//27
	importCms("1117","656");//9
	importCms("1118","657");//66
	importCms("1119","658");//43
	importCms("949","659");//42
	importCms("561","660");//1
	importCms("404","661");//4
	importCms("405","662");//4
	importCms("408","663");//15
	importCms("789","664");//24
	importCms("643","665");//2
	importCms("1032","667");//2
	importCms("1033","668");//2
	importCms("1035","669");//2
	importCms("1038","670");//2
	importCms("1039","671");//2
	importCms("1040","672");//6
	importCms("373","674");//3
	importCms("374","675");//1
	importCms("375","676");//3
	importCms("376","677");//7
	importCms("981","678");//2
	importCms("982","679");//1
	importCms("767","680");//159
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
			String sql = "select a.id, a.title, a.subname, a.archieved_time,a.picsummary, a.source_url, a.fulltext, a.origin, a.scan, a.updatetime, a.operator_id from Article_Catalog as c inner join Article as a on c.aid = a.id where a.isDisplay= 'y' and a.State= 1 and c.cid='"+oldCat+"' order by a.archieved_time desc";
			String sqlCount = "select count(*) as totle from Article_Catalog as c inner join Article as a on c.aid = a.id where a.isDisplay= 'y' and a.State= 1 and c.cid='"+oldCat+"'";
			
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
				GkIndexVo indexVo = GkIndexUtils.getGkIndex();
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