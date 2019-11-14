<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.UUID,com.eos.foundation.common.utils.StringUtil"%>
<%@page import="com.cms.view.data.InfoDataUtil,commonj.sdo.DataObject,com.cms.view.velocity.TurnPageBean"%>
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
	public String getInfoList(HttpServletRequest request){
		String json = "";
		String catId = request.getParameter("catId");
		String size = request.getParameter("size");
		String page = request.getParameter("page");
		String token = request.getParameter("token");
		HttpSession session = request.getSession();
		if(StringUtil.isBlank(token) || !token.equals(session.getAttribute("token"))){
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
						contentUrl = "http://10.0.252.39"+contentUrl;
					}
				}
				String description = info.getString("description");
				String thumbUrl = info.getString("thumbUrl");
				if(!StringUtil.isBlank(thumbUrl) && thumbUrl.length()>5){
					if(!thumbUrl.substring(0,4).equals("http")){
						thumbUrl = "http://10.0.252.39"+thumbUrl;
					}
				}
				String source = info.getString("source");
				String releasedDtime = info.getString("releasedDtime");
				String hits = info.getString("hits");
				json += ",{\"infoId\":\""+id+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"thumbUrl\":\""+thumbUrl+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\"}";
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
		if(StringUtil.isBlank(token) || !token.equals(session.getAttribute("token"))){
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
						contentUrl = "http://10.0.252.39"+contentUrl;
					}
				}
				String description = infoContent.getString("description");
				String source = infoContent.getString("source");
				String author = infoContent.getString("author");
				String releasedDtime = infoContent.getString("releasedDtime");
				String hits = infoContent.getString("hits");
				String picContent = infoContent.getString("picContent");
				String videoPath = infoContent.getString("videoPath");
				String content = infoContent.getString("infoContent");
				if(!StringUtil.isBlank(contentUrl)){
					picContent = picContent.replace("/upload/", "http://10.0.252.39/upload/");
					picContent = picContent.replace("/oldUpload/", "http://10.0.252.39/oldUpload/");
				}
				if(!StringUtil.isBlank(videoPath) && videoPath.length()>5){
					if(!videoPath.substring(0,4).equals("http")){
						videoPath = "http://10.0.252.39"+videoPath;
					}
				}
				if(!StringUtil.isBlank(content)){
					content = content.replace("/upload/", "http://10.0.252.39/upload/");
					content = content.replace("/oldUpload/", "http://10.0.252.39/oldUpload/");
				}
			json = "{\"infoId\":\""+id+"\",\"title\":\""+title+"\",\"contentUrl\":\""+contentUrl+"\",\"description\":\""+description+"\",\"source\":\""+source+"\",\"author\":\""+author+"\",\"releasedDtime\":\""+releasedDtime+"\",\"hits\":\""+hits+"\",\"picContent\":\""+picContent+"\",\"videoPath\":\""+videoPath+"\",\"content\":\""+replaceStr(content)+"\"}";
		}
		return "{\"code\":200,\"data\": "+json+"}";
	}
	public static String replaceStr(String str){
		return str.replaceAll("\"","'").replaceAll("\r|\n|\r\n","").replaceAll("<p\\+.*?[^>]>|</p\\+.*?[^>]>", "<p>");
	}
%>