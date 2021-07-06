<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../temp/index_head.jsp"></jsp:include>
<!-- 新增员工模态框-->
<div class="modal fade" id="emp_add_btn_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <!--表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="addName" id="add_Name" placeholder="张三" style="margin-top: 5px" required="required">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">E-mail</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="addE-mail" id="add_E-mail" placeholder="163@163.com" style="margin-top: 5px" required="required">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_Gender_M" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_Gender_F" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <!--通过获取的部门返回dId-->
                            <select class="form-control" name="dId" id="add_department">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_Emp">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 搭建显示页面 -->
<div class="container">
    <!--导航页-->
    <nav class="navbar navbar-default">
        <div class="container-fluid">

            <%--搜索信息查询--%>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <form class="navbar-form navbar-left">
                <div class="form-group">
                        <input type="text" class="form-control" placeholder="姓名">
                    </div>
                    <button type="submit" class="btn btn-info" style="margin-top: 5px">查询</button>
                </form>
                    <!-- 按钮 -->
                <div class="row">
                    <div class="col-md-4 col-md-offset-8">
                            <button type="button" class="btn btn-primary" id="addEmployee">新增</button>
                            <button type="button" class="btn btn-primary" id="deleteEmployee">删除</button>
                        </div>
                    </div>
            </div>
        </div>
    </nav>


    <!-- 表格 -->
    <div class="row" style="margin-top: 10px">
        <div class="col-md-12">
            <%--
            table tr th .delete_btn
            --%>
            <table class="table table-hover">
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>E-mail</th>
                    <th>depetement</th>
                    <th>编辑</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr class="panel">
                        <th><input type="checkbox" class="check_item"></th>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button  class="btn btn-primary btn-sm">
                                <span class="edit_btn" aria-hidden="true"></span>编辑
                            </button>
                            <button  class="btn btn-primary btn-sm delete_btn">
                                <span class="" aria-hidden="true"  del-id="${emp.empId}"></span>删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!-- 页码 -->
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}条记录；
        </div>
        <!-- 页面信息 -->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${pageContext.request.contextPath}/em/employee?pn=1">首页</a>
                    </li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                    <li>
                        <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="pages">

                        <%--var是items遍历的对象--%>
                        <c:if test="${pages == pageInfo.pageNum}">
                           <li class="active"><a href="#">${pages}</a></li>
                        </c:if>
                        <c:if test="${pages != pageInfo.pageNum}">
                            <li><a href="${pageContext.request.contextPath}/em/employee?pn=${pages}">${pages}</a></li>
                        </c:if>

                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                    <%--本页后面是否还有页面--%>
                    <li>
                        <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    </c:if>
                    <li>
                        <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<jsp:include page="../temp/index_foot.jsp"/>
<script>
    //跳转到当前页
    function toPage(){
        window.location="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum}";
    }

    <%--//删除按钮--%>
    <%--$("table tr th .delete_btn").click(function(){--%>
    <%--    var empName = $(this).parents("tr").find("th:eq(2)").text();--%>
    <%--    var empId = $(this).attr("del-id");--%>
    <%--    alert("ajax准备");--%>
    <%--    if(confirm("是否删除["+empName+"]用户")){--%>
    <%--        $.ajax({--%>
    <%--            url:"${pageContext.request.contextPath}/em/emp/"+empId,--%>
    <%--            type:"DELETE",--%>
    <%--            success:function(result){--%>
    <%--                //1.打印是否成功--%>
    <%--                alert(result.message);--%>
    <%--                //2.回到本页面--%>
    <%--                toPage();--%>
    <%--            }--%>
    <%--        });--%>
    <%--    }--%>
    <%--});--%>


    //新增员工
    $("#addEmployee").click(function(){
        //展示部门信息
        showDepartements("#add_department");
        //点击新增按钮弹出模态框
        $("#emp_add_btn_model").modal({
            backdrop:"static"
        });

    });

    //展示部门信息
    function showDepartements(element){
        $(element).empty();
        $.ajax({
            //1.url:
            url: "${pageContext.request.contextPath}/depts/getDepts",
            type: "GET",
            success:function(result){
                // 拼接查找的信息
                $.each(result.extend.depts,function(){
                    var deptSelect= $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    deptSelect.appendTo(element);
                });
            }
        });
    }

    //保存
    $("#save_Emp").click(function(){
     //1.校验
     //1.校验姓名
      var eName = $("#add_Name").val();
      var regExp = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
     if(regExp.test(eName)){
         alert("Name符合要求");
     }else{
         alert("Name应输入6-16位英文字母或2-5位中文字母");
         return false;
     }

       //2.校验邮箱
        var eEmail = $("#add_E-mail").val();
        var regExp1 = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(regExp1.test(eEmail)){
            alert("E-mail符合要求");
        }else{
            alert("E-mail语法错误!");
            return false;
        }

      //2.保存
      $.ajax({
            url:"${pageContext.request.contextPath}/em/emp",
            type:"POST",
            data:""+$("#emp_add_btn_model form").serialize(),
            success:function(result){
              alert("保存成功！");
                window.location="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.lastPage}";
            }
        });
    });

   //删除，动态选择触发的事件
    $(document).on("click","table tr th .delete_btn",function(){
        //获取此用户id
        var id = $(this).children("span").attr("del-id");
        //alert(id);

        //获取此用户name, 两层th tr
        var emp = $(this).parent().parent();
        var name = emp.children("th")[2].innerHTML;
        //alert(name);

        //确认继续执行，取消false;
      if(confirm("确认删除["+name+"]吗？")){
          $.ajax({
              url:"${pageContext.request.contextPath}/em/emp/"+id,
              type:"DELETE",
              async:false,
              success:function(result){
                  alert("删除["+name+"]成功");
                  //window.location="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum}";
                  toPage();
              },
              error:function(){
                  alert("删除"+name+"失败");
              }
          });
      }
      });



    //全选/全不选按钮
    $("#check_all").click(function(){
        var state = $(this).prop("checked");
        $(".check_item").prop("checked",state);
    });

    $(".check_item").click(function(){
        //1.判断是否全选
        //alert($("input:checked").length-1+","+$(".check_item").length);
        var flag = $("input:checked").length-1==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //批量删除
    $("#deleteEmployee").click(function() {
        var name = "[";
        var ids = "";
        $.each($(".check_item:checked"),function(){
           name+= $(this).parent().parent().find("th:eq(2)").text()+",";
           ids+= $(this).parent().parent().find("th:eq(1)").text()+"-";
        });
        name = name.substring(0,name.lastIndexOf(","))+"]";
        ids = ids.substring(0,ids.lastIndexOf("-"));
        if(confirm("确定删除"+name+"吗？")){
            //1.ajax请求;
            $.ajax({
                url:"${pageContext.request.contextPath}/em/emp/"+ids,
                type:"DELETE",
                success:function(){
                    alert("删除成功！");
                }
            });
            //2.跳转到当前页;
            //toPage();
            window.location="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum}"
        }
    });
</script>

