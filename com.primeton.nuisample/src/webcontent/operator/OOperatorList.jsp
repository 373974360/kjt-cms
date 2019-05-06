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
      操作员查询
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body style="width:98%;height:95%;">
    <div class="nui-panel" title="操作员查询" iconCls="icon-add" style="width:100%;height:15%;" showToolbar="false" showFooter="true">
      <div id="queryform" class="nui-form" align="center" style="height:100%">
        <!-- 数据实体的名称 -->
        <input class="nui-hidden" name="criteria/_entity" value="com.primeton.nuisample.data.OOperator">
        <!-- 排序字段 -->
        <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="userName">
        <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
        <table id="table1" class="table" style="height:100%">
          <tr>
            <td class="form_label">
              身份证:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="criteria/_expr[1]/userId"/>
              <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
            </td>
            <td class="form_label">
              姓名:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="criteria/_expr[2]/userName"/>
              <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
              <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
            </td>
          </tr>
        </table>
      </div>
    </div>
    <!--footer-->
    <div property="footer" align="center">
      <a class="nui-button" onclick="search()">
        查询
      </a>
      <a class="nui-button" onclick="reset()">
        重置
      </a>
    </div>
    <div class="nui-panel" title="操作员列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
      <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
          <tr>
            <td style="width:100%;">
              <a class="nui-button" iconCls="icon-add" onclick="add()">
                增加
              </a>
              <a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">
                编辑
              </a>
              <a class="nui-button" iconCls="icon-remove" onclick="remove()">
                删除
              </a>
            </td>
          </tr>
        </table>
      </div>
      <div class="nui-fit">
        <div id="datagrid1" dataField="ooperators" class="nui-datagrid" style="width:100%;height:100%;" url="com.primeton.nuisample.ooperatorbiz.queryOOperators.biz.ext" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
            <div type="indexcolumn">
            </div>
            <div type="checkcolumn">
            </div>
            <div field="operatorId" headerAlign="center" allowSort="true" visible="false">
              操作员编号
            </div>
            <div field="userId" headerAlign="center" allowSort="true" >
              身份证
            </div>
            <div field="userName" headerAlign="center" allowSort="true" >
              姓名
            </div>
            <div field="birthday" headerAlign="center" allowSort="true" >
              生日
            </div>
            <div field="gender" headerAlign="center" allowSort="true" >
              性别
            </div>
            <div field="postcode" headerAlign="center" allowSort="true" >
              邮政编码
            </div>
            <div field="address" headerAlign="center" allowSort="true" >
              地址
            </div>
            <div field="phone" headerAlign="center" allowSort="true" >
              电话
            </div>
            <div field="email" headerAlign="center" allowSort="true" >
              电子邮件
            </div>
            <div field="memo" headerAlign="center" allowSort="true" >
              备注
            </div>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      nui.parse();
      var grid = nui.get("datagrid1");

      var formData = new nui.Form("#queryform").getData(false,false);
      grid.load(formData);

      //新增
      function add() {
        nui.open({
          url: "OOperatorAdd.jsp",
          title: "新增记录", width: 700, height: 400,
          onload: function () {},
          ondestroy: function (action) {//弹出页面关闭前
          if(action=="saveSuccess"){
            grid.reload();
          }
        }
        });
      }

      //编辑
      function edit() {
        var row = grid.getSelected();
        if (row) {
          nui.open({
            url: "OOperatorUpdate.jsp",
            title: "编辑数据",
            width: 700,
            height: 400,
            onload: function () {
              var iframe = this.getIFrameEl();
              var data = row;
              //直接从页面获取，不用去后台获取
              iframe.contentWindow.setData(data);
              },
              ondestroy: function (action) {
                if(action=="saveSuccess"){
                  grid.reload();
                }
              }
              });
            } else {
              nui.alert("请选中一条记录","提示");
            }
          }

          //删除
          function remove(){
            var rows = grid.getSelecteds();
            if(rows.length > 0){
              nui.confirm("确定删除选中记录？","系统提示",
              function(action){
                if(action=="ok"){
                  var json = nui.encode({ooperators:rows});
                  grid.loading("正在删除中,请稍等...");
                  $.ajax({
                    url:"com.primeton.nuisample.ooperatorbiz.deleteOOperators.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
                    success:function(text){
                      var returnJson = nui.decode(text);
                      if(returnJson.exception == null){
                        grid.reload();
                        nui.alert("删除成功", "系统提示", function(action){
                          });
                        }else{
                          grid.unmask();
                          nui.alert("删除失败", "系统提示");
                        }
                      }
                      });
                    }
                    });
                  }else{
                    nui.alert("请选中一条记录！");
                  }
                }

                //重新刷新页面
                function refresh(){
                  var form = new  nui.Form("#queryform");
                  var json = form.getData(false,false);
                  grid.load(json);//grid查询
                  nui.get("update").enable();
                }

                //查询
                function search() {
                  var form = new nui.Form("#queryform");
                  var json = form.getData(false,false);
                  grid.load(json);//grid查询
                }

                //重置查询条件
                function reset(){
                  var form = new nui.Form("#queryform");//将普通form转为nui的form
                  form.reset();
                }

                //enter键触发查询
                function onKeyEnter(e) {
                  search();
                }

                //当选择列时
                function selectionChanged(){
                  var rows = grid.getSelecteds();
                  if(rows.length>1){
                    nui.get("update").disable();
                  }else{
                    nui.get("update").enable();
                  }
                }
              </script>
            </body>
          </html>
