<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="com.cms.view.velocity.VelocityInfoContextImp"%>
<%@page pageEncoding="UTF-8"%>
<%
	DataObject infoData = (DataObject)session.getAttribute("viewInfoData");
	if(infoData != null){
		VelocityInfoContextImp vc = new VelocityInfoContextImp(request);
		vc.setTemplateID(infoData);
		String content = vc.parseTemplate();
		if(content != null && !"".equals(content) && content.length() > 0){
			out.println(content);
		}else{
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);//返回404状态码
			request.getRequestDispatcher("/404.htm").forward(request,response);
		}
	}
%>