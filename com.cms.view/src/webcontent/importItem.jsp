<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,com.eos.foundation.data.DataObjectUtil,commonj.sdo.DataObject" %>
<%@page import="com.eos.common.connection.ConnectionHelper,com.cms.content.GkIndexVo,com.cms.content.GkIndexUtils,com.eos.foundation.database.DatabaseExt,com.eos.foundation.database.DatabaseUtil" %>
<%
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-农业科技创新与攻关","889");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-一般项目-科技扶贫专题","861");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-县域重点科技项目及区域科技综合能力建设计划","894");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-一般项目-社会发展领域","860");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-重大科技项目","876");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-一般项目-工业领域","858");
	importCms("政务信息-信息公开-科技项目-2017年前项目-重大科技创新专项资金项目","842");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点项目-社会发展领域","860");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省创新能力支撑计划-县域科技进步支撑计划","857");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省创新能力支撑计划-软科学研究计划","853");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划","843");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省创新能力支撑计划-平台基地类","854");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-重大科技专项计划（“十一五”期间）","884");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-科技培训计划","893");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-工业科技攻关","888");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-青年科技新星计划","899");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点项目-农业领域","863");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-社会发展科技攻关","890");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-科技产业园区计划（“十一五”期间）","885");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点项目-工业领域","862");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-重点新产品计划","908");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-重大科技产业化项目计划（“十一五”期间）","887");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-重大科技成果转化引导部分","874");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-工程技术研究中心计划（“十一五”期间）","886");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点产业创新链-工业领域","865");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-富民强县专项行动计划","895");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-科技惠民计划","902");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-资源主导型产业关键技术（链）项目","880");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-科技资源开放共亨平台项目","883");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-自然科学基础研究计划","904");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-国际科技合作与交流计划","897");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-特色产业创新链","878");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-农业科技创新计划","898");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-工程技术研究中心和重点实验室建设项目","882");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-星火计划","905");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省创新能力支撑计划-科技创新团队计划","856");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-科技扶贫计划","892");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省技术创新引导计划（基金）-科技企业培育计划","852");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-软科学计划","907");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-特色产业创新链-农业领域","869");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省自然科学基础研究计划-自然科学基础研究－一般项目 ","850");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点产业创新链-社会发展领域","867");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-协同创新计划","903");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-火炬计划","906");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-重点产业创新链","877");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-科技产业基地建设项目","879");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-国际科技合作与交流计划-重点项目","871");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-中药现代化部分","891");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-重点产业创新链-农业领域","866");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-特色产业创新链-工业领域","868");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划","841");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-科普与科技宣传计划","901");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-特色产业创新链-社会发展领域","870");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-科技创新团队计划","900");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-一般项目-农业领域","859");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科学技术研究发展计划-技术转移与重点科技成果推广计划","896");
	importCms("政务信息-信息公开-科技项目-2017年前项目-陕西省科技统筹创新工程计划-陕西省“13115”科技创新工程计划-战略性新兴产业重大产品（群）项目","881");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省重点研发计划-国际科技合作与交流计划-一般项目","872");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省创新能力支撑计划-青年科技新星计划","855");
	importCms("政务信息-信息公开-科技项目-2018年项目-陕西省自然科学基础研究计划-自然科学基础研究-重点项目","849");
%>
<%!
	private void importCms(String oldCat,String newCat){
		int counts = 0;
		int it = 0;
		String driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
		String userName = "sa";//登录用户名
		String userPasswd = "123456";//登录密码
		String dbName="scl_info";//数据库名	
		String url = "jdbc:sqlserver://10.211.55.6:1433;databaseName=" + dbName; 
		try {
			Class.forName(driverClassName);
			Connection conn = DriverManager.getConnection(url, userName, userPasswd);
			System.out.println("数据库连接成功");
			Statement stmt = conn.createStatement();
			String sql = "select id,cnname,achieveorg,begintime,endtime,projecttype,projectid,synergic from projectsarticle where begintime>='2017' and state=1 and catalogname='"+oldCat+"'";
			String sqlCount = "select count(*) as totle from projectsarticle where begintime>='2017' and state=1 and catalogname='"+oldCat+"'";
			
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
				info.setString("siteId", "21");
				info.setString("catId", newCat);
				info.setString("infoTitle",rs.getString("cnname"));
				info.setString("itemFzr",rs.getString("achieveorg"));
				info.setString("itemBegintime",rs.getString("begintime"));
				info.setString("itemEndtime",rs.getString("endtime"));
				info.setString("itemJhly",rs.getString("projecttype"));
				info.setString("itemNo",rs.getString("projectid"));
				info.setString("itemDept",rs.getString("synergic"));
				info.setString("weight", "60");
				info.setString("hits", "0");
				info.setString("isTop", "2");
				info.setString("isTuijian", "2");
				String releasedDtime = "2019-09-18 15:40:00";
				info.setString("releasedDtime", releasedDtime);
				info.setString("inputUser", "1");
				String inputDtime = "2019-08-29 17:04:00";
				info.setString("inputDtime",inputDtime);
				info.setString("sourceUrl","");
				info.setString("infoStatus","3");
				info.setString("modelId","item");
				GkIndexVo indexVo = GkIndexUtils.getGkIndex(inputDtime.substring(0,4));
				info.setString("gkIndex", indexVo.getIndex());
				info.setString("gkYear", indexVo.getYear());
				info.setString("gkNum", indexVo.getNum());
				DatabaseExt.getPrimaryKey(info);
				String infoId = info.getString("id");
				DatabaseUtil.insertEntity("default", info);
				it++;
				System.out.println("ID为："+rs.getString("id")+"的信息导入成功；信息总数："+counts+";当前第："+it+"条");
			}
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}
 %>