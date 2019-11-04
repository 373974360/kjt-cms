<%@page import="java.io.IOException"%>
<%@page import="java.util.*,com.eos.foundation.common.utils.StringUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	JSONObject obj = getRequestJsonObject(request);
	DataObject dtr = DataObjectUtil.createDataObject("com.cms.content.category.CmsInfo");
	Set keySet = obj.keySet();
	for (Object o : keySet) {
		if(obj.get(o)!=null){
			if(o.toString().equals("titleBrIndex")){
				String brIndex = obj.getString("titleBrIndex");
				String infoTitle = obj.getString("infoTitle");
				if(!StringUtil.isBlank(brIndex) && Integer.parseInt(brIndex)<infoTitle.length()){
					dtr.setString("infoTitle", "<p>"+infoTitle.substring(0,Integer.parseInt(brIndex))+"<p/><p>"+infoTitle.substring(Integer.parseInt(brIndex),infoTitle.length())+"<p/>");
				}else{
					dtr.setString("infoTitle", infoTitle);
				}
				continue;
			}
			if(o.toString().equals("releasedDtime")){
				String releasedDtime = obj.getString("releasedDtime");
				dtr.setString("releasedDtime", releasedDtime.replace("T"," "));
				continue;
			}
			dtr.setString(o.toString(),obj.getString(o.toString()));
		}
	}
	session.setAttribute("viewInfoData",dtr);
%>
<%!
	public static JSONObject getRequestJsonObject(HttpServletRequest request) throws IOException {
		String json = getRequestJsonString(request);
		return JSONObject.fromObject(json);
	}
	/**
     * 获取 request 中 json 字符串的内容
     * 
     * @param request
     * @return : <code>byte[]</code>
     * @throws IOException
     */
    public static String getRequestJsonString(HttpServletRequest request)
            throws IOException {
        String submitMehtod = request.getMethod();
        // GET
        if (submitMehtod.equals("GET")) {
            return new String(request.getQueryString().getBytes("iso-8859-1"),"utf-8").replaceAll("%22", "\"");
        // POST
        } else {
            return getRequestPostStr(request);
        }
    }
    
    /**      
     * 描述:获取 post 请求的 byte[] 数组
     * <pre>
     * 举例：
     * </pre>
     * @param request
     * @return
     * @throws IOException      
     */
    public static byte[] getRequestPostBytes(HttpServletRequest request)
            throws IOException {
        int contentLength = request.getContentLength();
        if(contentLength<0){
            return null;
        }
        byte buffer[] = new byte[contentLength];
        for (int i = 0; i < contentLength;) {
 
            int readlen = request.getInputStream().read(buffer, i,
                    contentLength - i);
            if (readlen == -1) {
                break;
            }
            i += readlen;
        }
        return buffer;
    }
    
    /**      
     * 描述:获取 post 请求内容
     * <pre>
     * 举例：
     * </pre>
     * @param request
     * @return
     * @throws IOException      
     */
    public static String getRequestPostStr(HttpServletRequest request)
            throws IOException {
        byte buffer[] = getRequestPostBytes(request);
        String charEncoding = request.getCharacterEncoding();
        if (charEncoding == null) {
            charEncoding = "UTF-8";
        }
        return new String(buffer, charEncoding);
    }
 %>