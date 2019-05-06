<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
  <head>
    <title>
      操作员录入
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body>
    <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
      <legend>
        操作员
      </legend>
      <div id="dataform1" style="padding-top:5px;">
        <!-- hidden域 -->
        <input class="nui-hidden" name="ooperator.oContacts" id="ooperator.oContacts"/>
        <input class="nui-hidden" name="ooperator.operatorId" id="ooperator.operatorId"/>
        <table style="width:100%;height:95%;table-layout:fixed;" class="nui-form-table">
          <tr>
            <td class="form_label">
              身份证:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.userId"/>
            </td>
            <td class="form_label">
              姓名:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.userName"/>
            </td>
          </tr>
          <tr>
            <td class="form_label">
              生日:
            </td>
            <td colspan="1">
              <input class="nui-datepicker" name="ooperator.birthday"/>
            </td>
            <td class="form_label">
              性别:
            </td>
            <td colspan="1">
              <input class="nui-dictcombobox" dictTypeId="gender" name="ooperator.gender"/>
            </td>
          </tr>
          <tr>
            <td class="form_label">
              邮政编码:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.postcode"/>
            </td>
            <td class="form_label">
              地址:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.address"/>
            </td>
          </tr>
          <tr>
            <td class="form_label">
              电话:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.phone"/>
            </td>
            <td class="form_label">
              电子邮件:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.email"/>
            </td>
          </tr>
          <tr>
            <td class="form_label">
              备注:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.memo"/>
            </td>
            <td class="form_label">
              orgId:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.oOrg.orgId"/>
            </td>
          </tr>
        </table>
      </div>
    </fieldset>
    <!-- 从表的修改 -->
    <div style="margin:0px 2px 0px 2px;" >
      <div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
        <div title="联系人">
          <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
              <tr>
                <td style="width:100%;">
                  联系人
                </td>
                <td >
                  <a class="nui-button " iconCls="icon-add" onclick="gridAddRow('grid_0')"  plain="true" tooltip="增加">
                    &nbsp;
                  </a>
                </td>
                <td >
                  <a class="nui-button " iconCls="icon-remove" onclick="gridRemoveRow('grid_0')"  plain="true" tooltip="删除">
                    &nbsp;
                  </a>
                </td>
              </tr>
            </table>
          </div>
          <div id="grid_0" class="nui-datagrid" style="width:100%;height:150px;" showPager="false" sortMode="client" allowCellEdit="true" allowCellSelect="true" multiSelect="true" editNextOnEnterKey="true" >
            <div property="columns">
              <div type="checkcolumn">
              </div>
              <div field="contactName" allowSort="true" align="left" headerAlign="center" width="">
                姓名
                <input class="nui-textbox" name="contactName" property="editor"/>
              </div>
              <div field="relation" allowSort="true" align="left" headerAlign="center" width="">
                关系
                <input class="nui-textbox" name="relation" property="editor"/>
              </div>
              <div field="phone" allowSort="true" align="left" headerAlign="center" width="">
                电话
                <input class="nui-textbox" name="phone" property="editor"/>
              </div>
              <div field="postcode" allowSort="true" align="left" headerAlign="center" width="">
                邮政邮编
                <input class="nui-textbox" name="postcode" property="editor"/>
              </div>
              <div field="address" allowSort="true" align="left" headerAlign="center" width="">
                地址
                <input class="nui-textbox" name="address" property="editor"/>
              </div>
              <div field="email" allowSort="true" align="left" headerAlign="center" width="">
                电子邮箱
                <input class="nui-textbox" name="email" property="editor"/>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
        <table width="100%">
          <tr>
            <td style="text-align:center;" colspan="4">
              <a class="nui-button" iconCls="icon-save" onclick="onOk()">
                保存
              </a>
              <span style="display:inline-block;width:25px;">
              </span>
              <a class="nui-button" iconCls="icon-cancel" onclick="onCancel()">
                取消
              </a>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <script type="text/javascript">
      nui.parse();
      var tab = nui.get("tab");
      var form = new nui.Form("#dataform1");
      form.setChanged(false);

      function onOk(){
        saveData();
      }

      function gridAddRow(datagrid){
        var grid = nui.get(datagrid);
        grid.addRow({});
      }

      function gridRemoveRow(datagrid) {
        var grid = nui.get(datagrid);
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
          grid.removeRows(rows, true);
        }
      }

      function setGridData(datagrid,dataid){
        var grid = nui.get(datagrid);
        var grid_data = grid.getChanges();
        nui.get(dataid).setValue(grid_data);
      }

      function saveData(){
        form.validate();
        if(form.isValid()==false) return;
        setGridData("grid_0","ooperator.oContacts");
        var data = form.getData(false,true);
        var json = nui.encode(data);

        $.ajax({
          url:"com.primeton.nuisample.ooperatorbiz.addOOperator.biz.ext",
          type:'POST',
          data:json,
          cache:false,
          contentType:'text/json',
          success:function(text){
            var returnJson = nui.decode(text);
            if(returnJson.exception == null){
              CloseWindow("saveSuccess");
            }else{
              nui.alert("保存失败", "系统提示", function(action){
                if(action == "ok" || action == "close"){
                  //CloseWindow("saveFailed");
                }
                });
              }
            }
            });
          }

          function onReset(){
            form.reset();
            form.setChanged(false);
          }

          function onCancel(){
            CloseWindow("cancel");
          }

          function CloseWindow(action){
            if(action=="close"){

              }else if(window.CloseOwnerWindow)
              return window.CloseOwnerWindow(action);
              else
              return window.close();
            }
          </script>
        </body>
      </html>
