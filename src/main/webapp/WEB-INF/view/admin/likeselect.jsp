<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../temp/index_head.jsp"></jsp:include>
<!-- 搭建显示页面 -->
<body class="container">
    <!--功能模块-->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <%--搜索信息查询--%>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <div class="row">
                    <div class="form-group">
                        <div class="col-md-2" >
                            <input type="text" class="form-control" placeholder="姓名" id="select" style="border-radius: 5px;margin-top: 20px">
                        </div>
                        <div class="col-md-2" style="float:left;margin-top: 20px">
                            <button class="btn btn-info" id="selectName">查询</button>
                        </div>
                        <script>
                            document.getElementById("selectName").click(
                                function(){
                                    alert("select。。。");
                                }
                            );
                        </script>
                        <div class="col-md-4 col-md-offset-10" style="margin-bottom: 20px">
                            <button  class="btn btn-primary" id="addEmployee">新增</button>
                            <button  class="btn btn-primary" id="deleteEmployee">删除</button>
                            <button  class="btn btn-primary" id="test">Test</button>
                        </div>
                    </div>
                    <!-- 按钮 -->
                </div>
            </div>
        </div>
    </nav>

    <!--展示模块-->
    <nav class="navbar navbar-default" style="margin-top: 10px">
         <div class="container-fluid">
            <div class="row" style="margin-top: 10px" >
                <div class="col-md-12">
                    <table class="table table-hover" >
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
                        <tbody id="createTr" >
                        </tbody>
<%--                        <c:forEach items="${pageInfo.list}" var="emp">--%>
<%--                            <tr class="panel" id="table">--%>
<%--                                <th><input type="checkbox" class="check_item"></th>--%>
<%--                                <th>${emp.empId}</th>--%>
<%--                                <th>${emp.empName}</th>--%>
<%--                                <th>${emp.gender}</th>--%>
<%--                                <th>${emp.email}</th>--%>
<%--                                <th>${emp.department.deptName}</th>--%>
<%--                                <th>--%>
<%--                                    <button  class="btn btn-primary btn-sm">--%>
<%--                                        <span class="edit_btn" aria-hidden="true"></span>编辑--%>
<%--                                    </button>--%>
<%--                                    <button  class="btn btn-primary btn-sm delete_btn">--%>
<%--                                        <span class="" aria-hidden="true"  del-id="${emp.empId}"></span>删除--%>
<%--                                    </button>--%>
<%--                                </th>--%>
<%--                            </tr>--%>
<%--                        </c:forEach>--%>
                    </table>
                </div>
             </div>
             <%--显示分页信息--%>
         <div class="row">
        <!-- 页码 -->
            <div class="col-md-6" id="pageNumber">
<%--                <a >--%>
<%--                    <span>当前第 <button class="btn btn-sm" value="${pageInfo.pageNum}"></button>页</span>,--%>
<%--                    <span>共 <button class="btn btn-sm" value="${pageInfo.pages}"></button>页</span>,--%>
<%--                    <span>共 <button class="btn btn-sm" value="${pageInfo.total}"></button></button>条记录</span>；--%>
<%--                </a>--%>
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
    </nav>
<jsp:include page="../temp/index_foot.jsp"/>
<script type="text/javascript">
    //1.查询触发点击事件
    $("#selectName").on(function(){
        //1.ajax请求
        alert("....");
        clickSelect();
    });

    //方法区：
    //1.ajax请求:获取需要查找的数据;
    function clickSelect(){
        var name = $("#select").val();
          $.ajax({
              url:"${pageContext.request.contextPath}/em/selectbyname",
              data:"name="+name,
              type:"GET",
              dataType:"json",
              contentType:"application/json",
              async:true,
              success:function(data){
                  //1.buildTable_thead
                  //2.展示数据;
                  buildTable_tbody(data);
                  buildTable_foot_page(data);
              },
              error:function(){
                  alert("error");
              }
          });
    }

    //3.创建表格
    function buildTable_tbody(result){
        //1.清楚已有的数据；
        $("#createTr").empty();
        //2.获取数据
        var emps = result.extend.pageInfo.list;

        $.each(emps,function(index,item){
            //1.创建标签
            var checkBoxTd = $("<td><input type='checkbox' class='checkbox_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.gender);
            var empEmailTd = $("<td></td>").append(item.email);
            var empDepartmentTd = $("<td></td>").append(item.department.deptName);

            //1.1 编辑按钮
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm edit_btn").append("编辑")

            //1.2 删除按钮
            var deleteBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                  .append("删除");
            //1.3 合并
            var btn = $("<td></td>").append(editBtn).append(deleteBtn);

            //2 组合
            $("<tr><tr>").append(checkBoxTd)
                         .append(empIdTd)
                         .append(empNameTd)
                         .append(empGenderTd)
                         .append(empEmailTd)
                         .append(empDepartmentTd)
                         .append(btn)
                         .appendTo("#createTr");
        });
    }
    //页面信息
    function buildTable_foot_page(result){
        $(#pageNumber).empty();
         //1.第一行
         var btn_first = $("<button></button>").addClass("btn btn-sm").append(JSON.stringify(result.extend.pageInfo.pageNum));
         var span_first = $("<span>当前第</span>").append(btn_first).append($("<span>页</span>")+",");
         //2.第二行
        var btn_second = $("<button></button>").addClass("btn btn-sm").append(JSON.stringify(result.extend.pageInfo.pages));
        var span_second = $("<span>共</span>").append(btn_second).append($("<span>页</span>")+",");
        //第三行数据
        var btn_third = $("<button></button>").addClass("btn btn-sm").append(JSON.stringify(result.extend.pageInfo.total));
        var span_third = $("<span>共</span>").append(btn_third).append($("<span>条记录</span>")+";");
        //合并
        $("<a></a>").append(span_first).append(span_second).append(span_third).appendTo("#pageNumber")
    }
</script>
</body>
</html>

