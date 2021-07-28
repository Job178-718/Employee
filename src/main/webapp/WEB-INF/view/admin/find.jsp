<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../temp/index_head.jsp"></jsp:include>
<%--功能模块--%>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <%--搜索信息查询--%>
        <div class="collapse navbar-collapse">
            <div class="row">
                <div class="form-group">
                    <div class="col-md-2" >
                        <input type="text" class="form-control" placeholder="姓名" id="select" style="border-radius: 5px;margin-top: 20px">
                    </div>
                    <div class="col-md-2" style="float:left;margin-top: 20px">
                        <button class="btn btn-info" id="selectName">查询</button>
                        <button class="btn btn-info">全部</button>
                    </div>
                    <div class="col-md-4 col-md-offset-10" style="margin-bottom: 20px">
                        <button  class="btn btn-info" id="addEmployee">新增</button>
                        <button  class="btn btn-info" id="deleteEmployee">删除</button>
                        <button  class="btn btn-info" id="test">Test</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<%--表格模块--%>
<nav class="navbar navbar-default" style="margin-top: 10px">
    <div class="container-fluid">
        <%--数据导入--%>
        <div class="row" style="margin-top: 10px" >
            <div class="col-md-12">
                <%--表格--%>
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="check_all"></th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>E-mail</th>
                            <th>depetement</th>
                            <th>编辑</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <!-- 页码 -->
            <div class="col-md-6" id="pageNumber">
            </div>
            <!-- 页面信息 -->
            <div class="col-md-6">
                <nav aria-label="Page navigation" id="changePage">
                    <ul class="pagination" id="">
                    </ul>
                </nav>
            </div>
        </div>
</nav>
<jsp:include page="../temp/index_foot.jsp"></jsp:include>
<script>


    //事件
    //1.查找功能
    $(document).on("click","#selectName",function(){
        toPage(1);
    });

    //2.跳转实现
     $(document).on("click","#changePage  .page_select",function(){
         //alert("成功了");
         // 1.获取pn
         var pn = $(this).prop("select_id");

         // 2.跳转到pn
         toPage(pn);
     });


    //方法区：
    function toPage(pn){
        clickSelect(pn)
    }

    //1.ajax请求:获取需要查找的数据;
    var name ;
    function clickSelect(pn){
        name = $("#select").val();
        if(name!=null&&name!=''){
            $.ajax({
                url:"${pageContext.request.contextPath}/em/selectbyname",
                data:"name="+name+"&pn="+pn,
                type:"GET",
                dataType:"json",
                contentType:"application/json",
                async:false,
                success:function(data){
                    //1.展示数据;
                    buildTable_tbody(data);
                    //2.页面信息
                    buildTable_foot_page(data);
                    //3.页码信息
                    chagePage(data);
                },
                error:function() {
                    alert("error");
                }
            });
        }
        return false;
    }


    //2.创建一个表格
    function buildTable_tbody(result){
       $("#emps_table tbody").empty();
       var emps =  result.extend.pageInfo.list;
       $.each(emps,function(index,item){

           //1.check
           var emp_check = $("<td><input type='checkbox' id='check_all'></td>");
           //2.ID
           var emp_empId = $("<td></td>").append(item.empId);
           //3.Name
           var emp_empName = $("<td></td>").append(item.empName);
           //4.Gender
           var emp_gender = $("<td></td>").append(item.gender);
           //5.E-mail
           var emp_email = $("<td></td>").append(item.email);
           //6.depetement
           var emp_deptName = $("<td></td>").append(item.department.deptName);
           //7 按钮
           //7.1 编辑按钮
           var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").append("编辑");
           //7.2 删除按钮
           var deleteBtn = $("<button></button>").addClass("btn btn-info btn-sm delete_btn").append("删除");
           var emp_edit =  $("<td></td>").append(editBtn).append(deleteBtn);
           /*整合*/
           $("<tr><tr>").append(emp_check)
                        .append(emp_empId)
                        .append(emp_empName)
                        .append(emp_gender)
                        .append(emp_email)
                        .append(emp_deptName)
                        .append(emp_edit)
                        .appendTo("#emps_table tbody");
       });
    }



    //3.页码信息
    function buildTable_foot_page(result){
        $("#pageNumber").empty();
        //1.第一行
        var btn_first = $("<button></button>").addClass("btn btn-sm").append(result.extend.pageInfo.pageNum);
        var span_first = $("<span>当前第 </span>").append(btn_first).append($("<span>页,</span>"));
        //2.第二行
        var btn_second = $("<button></button>").addClass("btn btn-sm").append(result.extend.pageInfo.pages);
        var span_second = $("<span>共 </span>").append(btn_second).append($("<span>页,</span>"));
        //第三行数据
        var btn_third = $("<button></button>").addClass("btn btn-sm").append(result.extend.pageInfo.total);
        var span_third = $("<span>共 </span>").append(btn_third).append($("<span>条记录;</span>"));
        //合并
        $("<a></a>").append(span_first)
                    .append(span_second)
                    .append(span_third)
                    .appendTo("#pageNumber");
    }
    //4.页面转换
    function chagePage(result){
        $("#changePage").empty();
        var page = result.extend.pageInfo.navigatepageNums;

         //1.首页
        var firstPage = $("<a></a>").addClass("page_select btn btn-info").append("首页").prop("select_id","1");
         //2.末页
        var lastPage = $("<a></a>").addClass("page_select btn btn-info").append("末页").prop("select_id",""+result.extend.pageInfo.pages);
         //3.遍历页码信息
         var complete = $("<div></div>").addClass("btn-group btn-group-sm").prop("role","group").attr("style","margin-bottom:20px");
         var fowordpage = complete.append(firstPage);
         $.each(page,function(index,item){
             var btnNum = $("<a></a>").addClass("page_select btn btn-default").prop("select_id",""+item).append(item);
             fowordpage.append(btnNum);
         });
        // 合并的标签
        fowordpage.append(lastPage)
                  .appendTo("#changePage");
    }
</script>