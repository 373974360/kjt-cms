<%@page pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.util.Date"%>
<%
	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curTime = df.format(new Date());
	String group = request.getParameter("group");
 %>
<tr>
    <th class="nui-form-label" style="width:120px;">所属栏目：</th>
    <td colspan="6">   
    	<input id="catId" name="info.catId" style="width:555px;" class="mini-treeselect" url="com.cms.content.ContentService.queryInfoEditorCategoryTreeNode.biz.ext"
    		ajaxData="{'userId':'<%=userObject.getUserId() %>'}" 
    		multiSelect="false"  valueFromSelect="false"
    		idField="id" textField="text" parentField="pid" onbeforenodeselect="beforenodeselect" allowInput="true"
	        showRadioButton="true" showFolderCheckBox="false" dataField="data"/>
    </td>
</tr>
<tr>
    <th class="nui-form-label" style="width:120px;">是否涉密<span style="color:red;"> *</span>：</th>
    <td style="width:100px;">    
    	<div style="width:100px;" name="info.isShemi" class="nui-radiobuttonlist"
		    textField="text" dataField="yesNo" valueField="id" value="2"
		    url="<%=request.getContextPath()%>/content/info/yesNo.txt" >
		</div>
    </td>
    <th class="nui-form-label" style="width:70px;">文章分类：</th>
    <td style="width:100px;">    
        <input name="info.infoType" class="nui-combobox" textField="typeName" valueField="id"  style="width:100px;"
	    url="com.cms.basics.InfoTypeService.queryInfoTypeAll.biz.ext" dataField="data" showNullItem="true" />
    </td>
    <th class="nui-form-label" style="width:80px;">同时发布：</th>
    <td style="width:150px;">    
        <input id="infoCatId" name="infoCat.catId" class="nui-buttonedit nui-form-input" onbuttonclick="onButtonEdit" allowInput="false"/>
    </td>
    <td></td>
</tr>     
<tr>
    <th class="nui-form-label">列表标题：</th>
    <td colspan="5">    
        <input name="info.listTitle" class="nui-textbox nui-form-input"/>
    </td>
</tr>       
<tr>
    <th class="nui-form-label">上标题：</th>
    <td colspan="5">    
        <input name="info.topTitle" class="nui-textbox nui-form-input"/>
    </td>
</tr>  
<tr>
    <th class="nui-form-label">文章标题<span style="color:red;"> *</span>：</th>
    <td colspan="5">    
        <input id="infoTitle" name="info.infoTitle" class="nui-textbox nui-form-input" required="true" onblur="getTitleTags()"/>
        <input name="info.editor" class="nui-hidden" value="<%=userObject.getUserRealName() %>"/>
    </td>
</tr>
<%
	if(group.equals("manager")){
%>
<tr>
    <th class="nui-form-label">标题样式：</th>
    <td>
    	<div name="info.titleWeight" class="mini-checkbox" readOnly="false" text="加粗"></div>
    	<div name="info.titleColor" class="mini-checkbox" readOnly="false" text="标红"></div>
    </td>
    <th class="nui-form-label">换行字数：</th>
    <td>
    	<input name="info.titleBrIndex" class="nui-textbox nui-form-input"/>
    </td>
</tr>
<%
	}
%>
<tr>
    <th class="nui-form-label">副标题：</th>
    <td colspan="5">    
        <input name="info.subTitle" class="nui-textbox nui-form-input"/>
    </td>
</tr>  
<tr>
    <th class="nui-form-label">来源<span style="color:red;"> *</span>：</th>
    <td colspan = 3>    
    	<%
			if(group.equals("manager")){
		%>
    	<input id="infoSource" name="info.source" class="nui-textbox nui-form-input" value="<%=userObject.getUserOrgName() %>" required="true"/>
		<%
			}else{
		%>
    	<input id="infoSource" name="info.source" class="nui-textbox nui-form-input" readonly="readonly" value="<%=userObject.getUserOrgName() %>" required="true"/>
		<%
			}
		%>
    </td>
    <td>
		<a href="javascript:void(0)" onclick="removeSource()">[移除]</a>
	</td>
    <td>
    	<div id="infoSourceCombobox" class="nui-combobox" style="width:100px;" popupWidth="400" textField="sourceName" valueField="sourceName"
		    url="com.cms.basics.SourceService.querySourceAll.biz.ext" dataField="data" onvaluechanged="setInfoSource()">
		</div>
	</td>
</tr>
<tr>
    <th class="nui-form-label">来源地址：</th>
    <td colspan="4">    
        <input name="info.sourceUrl" class="nui-textbox nui-form-input"/>
    </td>
</tr>  
<tr>
    <th class="nui-form-label">作者：</th>
    <td colspan = 3>    
    	<input id="infoAuthor" name="info.author" class="nui-textbox nui-form-input"/>
    </td>
    <td>
    	<div id="infoAuthorCombobox" class="nui-combobox" style="width:100px;" popupWidth="400" textField="authorName" valueField="authorName"
		    url="com.cms.basics.AuthorService.queryAuthorAll.biz.ext" dataField="data" onvaluechanged="setInfoAuthor()">
		</div>
    </td>
</tr>
<tr>
    <th class="nui-form-label">关键词：</th>
    <td colspan="3">    
        <input id="keywords" name="info.keywords" class="nui-textbox nui-form-input"/>
    </td>
    <th class="nui-form-label">发布时间<span style="color:red;"> *</span>：</th>
    <td>    
    	<%
			if(group.equals("manager")){
		%>
    	<input name="info.releasedDtime" class="nui-datepicker nui-form-input" format="yyyy-MM-dd HH:mm:ss" dateFormat="yyyy-MM-dd HH:mm:ss" value="<%=curTime %>" showTime="true" required="true"/>
		<%
			}else{
		%>
    	<input name="info.releasedDtime" class="nui-datepicker nui-form-input" readonly="readonly" format="yyyy-MM-dd HH:mm:ss" dateFormat="yyyy-MM-dd HH:mm:ss" value="<%=curTime %>" showTime="true" required="true"/>
		<%
			}
		%>
    </td>
</tr>
<tr>
    <th class="nui-form-label">摘要：</th>
    <td colspan="5">    
       <textarea name="info.description" class="nui-textarea" style="width:100%;"></textarea>
    </td>
</tr>