<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.UUID,com.eos.foundation.common.utils.StringUtil"%>
<%@page import="com.cms.view.data.InfoDataUtil,commonj.sdo.DataObject,com.cms.view.velocity.TurnPageBean"%>
<%@page import="com.cms.view.data.CategoryUtil"%>
<%
	String actionType = request.getParameter("actionType");
	String result = "";
	if(actionType.equals("getToken")){
		result = getToken(request);
	}
	if(actionType.equals("getInfoList")){
		result = getInfoList(request);
	}
	if(actionType.equals("getInfoContent")){
		result = getInfoContent(request);
	}
	if(actionType.equals("getTreeNode")){
		result = getTreeNode(request);
	}
	String callback = request.getParameter("callback");
	if(callback != null && !"".equals(callback)){
	    out.println(callback + "(" + result + ")");
	}else{
		out.println(result);
	}
%>
<%!
	public String getToken(HttpServletRequest request){
		HttpSession session = request.getSession();
		String token = UUID.randomUUID().toString().replace("-", "");
		session.setAttribute("token",token);
		return "{\"code\":200,\"tokenKey\":\"" + token + "\"}";
	}
	
	public String getTreeNode(HttpServletRequest request){
		String json = "";
		String catId = request.getParameter("catId");
		String token = request.getParameter("token");
		HttpSession session = request.getSession();
		if(StringUtil.isBlank(token) || !token.equals("d7824dde1afa40c495fec50d50d1b969")){
			return "{\"code\":405,\"message\":\"token 验证失败\"}";
		}
		if(StringUtil.isBlank(catId)){
			return "{\"code\":400,\"message\":\"catId 参数不能为空\"}";
		}
		DataObject[] infoList = CategoryUtil.getCategoryChildById(catId);
		if(infoList != null && infoList.length > 0){
			for(DataObject info : infoList){
				String id = info.getString("id");
				String parentId = info.getString("parentId");
				String chName = info.getString("chName");
				json += ",{\"id\":\""+id+"\",\"parentId\":\""+parentId+"\",\"chName\":\""+chName+"\"}";
			}
			json = json.substring(1);
		}
		return "{\"code\":200,\"data\": ["+json+"]}";
	}
	
	public String getInfoList(HttpServletRequest request){
		String json = "";
		String catId = request.getParameter("catId");
		String size = request.getParameter("size");
		String page = request.getParameter("page");
		String token = request.getParameter("token");
		HttpSession session = request.getSession();
		if(StringUtil.isBlank(token) || !token.equals("d7824dde1afa40c495fec50d50d1b969")){
			return "{\"code\":405,\"message\":\"token 验证失败\"}";
		}
		if(StringUtil.isBlank(catId)){
			return "{\"code\":400,\"message\":\"catId 参数不能为空\"}";
		}
		if(StringUtil.isBlank(page)){
			page = "1";
		}
		if(StringUtil.isBlank(size)){
			page = "20";
		}
		String params = "cat_id="+catId+";size="+size+";cur_page="+page+";orderby=i.released_dtime desc;";
		DataObject[] infoList = InfoDataUtil.getInfoList(params);
		TurnPageBean pageBean = InfoDataUtil.getInfoCount(params);
		if(infoList != null && infoList.length > 0){
			for(DataObject info : infoList){
				String id = info.getString("id");
				String title = info.getString("infoTitle");
				String contentUrl = info.getString("contentUrl");
				if(!StringUtil.isBlank(contentUrl) && contentUrl.length()>5){
					if(!contentUrl.substring(0,4).equals("http")){
						contentUrl = "http://kjt.shaanxi.gov.cn"+contentUrl;
					}
				}
				String description = info.getString("description");
				if(!StringUtil.isBlank(description)){
					description = description.replaceAll("\r|\n", "");
					description = description.replaceAll(" ", "");
					description = description.replaceAll("&nbsp;", "");
				}
				String thumbUrl = info.getString("thumbUrl");
				if(!StringUtil.isBlank(thumbUrl) && thumbUrl.length()>5){
					if(!thumbUrl.substring(0,4).equals("http")){
						thumbUrl = "http://kjt.shaanxi.gov.cn"+thumbUrl;
					}
				}
				String source = info.getString("source");
				String releasedDtime = info.getString("releasedDtime");
				String hits = info.getString("hits");
				String modelId = info.getString("modelId");
				json += ",{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"thumbUrl\":\""+thumbUrl+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\"}";
			}
			json = json.substring(1);
		}
		return "{\"code\":200,\"totle\": "+pageBean.getCount()+",\"pageNum\": "+pageBean.getPage_count()+",\"currPage\": "+pageBean.getCur_page()+",\"data\": ["+json+"]}";
	}
	
	public String getInfoContent(HttpServletRequest request){
		String json = "";
		String infoId = request.getParameter("infoId");
		String token = request.getParameter("token");
		HttpSession session = request.getSession();
		if(StringUtil.isBlank(token) || !token.equals("d7824dde1afa40c495fec50d50d1b969")){
			return "{\"code\":405,\"message\":\"token 验证失败\"}";
		}
		if(StringUtil.isBlank(infoId)){
			return "{\"code\":400,\"message\":\"infoId 参数不能为空\"}";
		}
		DataObject infoContent = InfoDataUtil.getInfoData(infoId);
		if(infoContent != null){
				String id = infoContent.getString("id");
				String title = infoContent.getString("infoTitle");
				String contentUrl = infoContent.getString("contentUrl");
				if(!StringUtil.isBlank(contentUrl) && contentUrl.length()>5){
					if(!contentUrl.substring(0,4).equals("http")){
						contentUrl = "http://kjt.shaanxi.gov.cn"+contentUrl;
					}
				}
				String description = infoContent.getString("description");
				if(!StringUtil.isBlank(description)){
					description = description.replaceAll("\r|\n", "");
					description = description.replaceAll(" ", "");
					description = description.replaceAll("&nbsp;", "");
				}
				String thumbUrl = infoContent.getString("thumbUrl");
				if(!StringUtil.isBlank(thumbUrl) && thumbUrl.length()>5){
					if(!thumbUrl.substring(0,4).equals("http")){
						thumbUrl = "http://kjt.shaanxi.gov.cn"+thumbUrl;
					}
				}
				String source = infoContent.getString("source");
				String author = infoContent.getString("author");
				String releasedDtime = infoContent.getString("releasedDtime");
				String hits = infoContent.getString("hits");
				String modelId = infoContent.getString("modelId");
				if(modelId.equals("article")){
					String content = infoContent.getString("infoContent");
					if(!StringUtil.isBlank(content)){
						content = content.replace("http://kjt.shaanxi.gov.cn/default/upload/", "/default/upload/");
						content = content.replace("/default/upload/", "/upload/");
						content = content.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						content = content.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					json = "{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"thumbUrl\":\""+thumbUrl+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"content\":\""+replaceStr(content)+"\"}";
				}
				if(modelId.equals("doc")){
					String content = infoContent.getString("infoContent");
					String gkIndex = infoContent.getString("gkIndex");
					String gkNo = infoContent.getString("gkNo");
					String gkCwrq = infoContent.getString("gkCwrq");
					String gkFwrq = infoContent.getString("gkFwrq");
					String gkDept = infoContent.getString("gkDept");
					String gkWjyxx = infoContent.getString("gkWjyxx");
					String thumbRemark = infoContent.getString("thumbRemark");
					if(!StringUtil.isBlank(content)){
						content = content.replace("/default/upload/", "/upload/");
						content = content.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						content = content.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					json = "{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"gkIndex\":\""+gkIndex+"\",\"thumbRemark\":\""+thumbRemark+"\",\"gkNo\":\""+gkNo+"\",\"gkCwrq\":\""+gkCwrq+"\",\"gkFwrq\":\""+gkFwrq+"\",\"gkDept\":\""+gkDept+"\",\"gkWjyxx\":\""+gkWjyxx+"\",\"thumbUrl\":\""+thumbUrl+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"content\":\""+replaceStr(content)+"\"}";
				}
				if(modelId.equals("pic")){
					String picContent = infoContent.getString("picContent");
					String content = infoContent.getString("infoContent");
					if(!StringUtil.isBlank(picContent)){
						picContent = picContent.replace("/default/upload/", "/upload/");
						picContent = picContent.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						picContent = picContent.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					if(!StringUtil.isBlank(content)){
						content = content.replace("/default/upload/", "/upload/");
						content = content.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						content = content.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					json = "{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"thumbUrl\":\""+thumbUrl+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"picContent\":"+picContent+",\"content\":\""+replaceStr(content)+"\"}";
				}
				if(modelId.equals("video")){
					String videoPath = infoContent.getString("videoPath");
					String content = infoContent.getString("infoContent");
					if(!StringUtil.isBlank(videoPath) && videoPath.length()>5){
						if(!videoPath.substring(0,4).equals("http")){
							videoPath = "http://kjt.shaanxi.gov.cn"+videoPath;
						}
					}
					if(!StringUtil.isBlank(content)){
						content = content.replace("/default/upload/", "/upload/");
						content = content.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						content = content.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					json = "{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"thumbUrl\":\""+thumbUrl+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"videoPath\":\""+videoPath+"\",\"content\":\""+replaceStr(content)+"\"}";
				}
				if(modelId.equals("expert")||modelId.equals("leader")){
					String ldzw = infoContent.getString("ldzw");
					String grjl = infoContent.getString("grjl");
					String zrfg = infoContent.getString("zrfg");
					if(!StringUtil.isBlank(ldzw)){
						ldzw = ldzw.replace("/default/upload/", "/upload/");
						ldzw = ldzw.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						ldzw = ldzw.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					if(!StringUtil.isBlank(grjl)){
						grjl = grjl.replace("/default/upload/", "/upload/");
						grjl = grjl.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						grjl = grjl.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					if(!StringUtil.isBlank(zrfg)){
						zrfg = zrfg.replace("/default/upload/", "/upload/");
						zrfg = zrfg.replace("/upload/", "http://kjt.shaanxi.gov.cn/upload/");
						zrfg = zrfg.replace("/oldUpload/", "http://kjt.shaanxi.gov.cn/oldUpload/");
					}
					json = "{\"infoId\":\""+id+"\",\"modelId\":\""+modelId+"\",\"thumbUrl\":\""+thumbUrl+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"ldzw\":\""+replaceStr(ldzw)+"\",\"grjl\":\""+replaceStr(grjl)+"\",\"zrfg\":\""+replaceStr(zrfg)+"\"}";
				}
				
		}
		return "{\"code\":200,\"data\": "+json+"}";
	}
	public static String replaceStr(String str){
		return str.replaceAll("\"","'").replaceAll("\r|\n|\r\n","").replaceAll("<p\\+.*?[^>]>|</p\\+.*?[^>]>", "<p>");
	}
%>