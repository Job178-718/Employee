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
                    </div>
                    <div class="col-md-4 col-md-offset-10" style="margin-bottom: 20px">
                        <button  class="btn btn-info" id="addEmployee">新增</button>
                        <button  class="btn btn-info" id="deleteEmployee">删除</button>
                        <button  class="btn btn-info" id="test">Test</button>
                    </div>
                </div>
                <!-- 按钮 -->
            </div>
        </div>
    </div>
</nav>
<%--展示模块--%>

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
                    <ul class="pagination" >
<%--                        <li>--%>
<%--                            <a href="${pageContext.request.contextPath}/em/employee?pn=1">首页</a>--%>
<%--                        </li>--%>
<%--                        <c:if test="${pageInfo.hasPreviousPage}">--%>
<%--                            <li>--%>
<%--                                <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum-1}" aria-label="Previous">--%>
<%--                                    <span aria-hidden="true">&laquo;</span>--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </c:if>--%>
<%--                        <c:forEach items="${pageInfo.navigatepageNums}" var="pages">--%>

<%--                            &lt;%&ndash;var是items遍历的对象&ndash;%&gt;--%>
<%--                            <c:if test="${pages == pageInfo.pageNum}">--%>
<%--                                <li class="active"><a href="#">${pages}</a></li>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${pages != pageInfo.pageNum}">--%>
<%--                                <li><a href="${pageContext.request.contextPath}/em/employee?pn=${pages}">${pages}</a></li>--%>
<%--                            </c:if>--%>

<%--                        </c:forEach>--%>
<%--                        <c:if test="${pageInfo.hasNextPage}">--%>
<%--                            &lt;%&ndash;本页后面是否还有页面&ndash;%&gt;--%>
<%--                            <li>--%>
<%--                                <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pageNum+1}" aria-label="Next">--%>
<%--                                    <span aria-hidden="true">&raquo;</span>--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </c:if>--%>
<%--                        <li>--%>
<%--                            <a href="${pageContext.request.contextPath}/em/employee?pn=${pageInfo.pages}">末页</a>--%>
<%--                        </li>--%>
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
            async:false,
            success:function(data){
                //2.展示数据;
                buildTable_tbody(data);
                //3.页面信息
                buildTable_foot_page(data);
                //4.页码信息
                chagePage(data);

            },
            error:function() {
                alert("error");
            }
        });
    }
    //2.创建表格
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
                .addClass("btn btn-info btn-sm edit_btn").append("编辑")

            //1.2 删除按钮
            var deleteBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append("删除");
            //1.3 合并
            var btn = $("<td></td>").append(editBtn).append(deleteBtn);

            //2 组合
            rowEmp= $("<tr><tr>").append(checkBoxTd)
                  .append(empIdTd)
                  .append(empNameTd)
                  .append(empGenderTd)
                  .append(empEmailTd)
                  .append(empDepartmentTd)
                  .append(btn);
        });
        rowEmp.appendTo("table #createTr");
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
        var page = result.extend.pageInfo.navigatepageNums;

         //1.首页
        var firstPage = $("<button></button>").addClass("btn btn-info").append("首页");
         //2.末页
        var lastPage = $("<button></button>").addClass("btn btn-info").append("末页");
         //3.遍历页码信息
         var complete = $("<div></div>").addClass("btn-group btn-group-sm").attr("role","group").attr("style","margin-bottom:20px");
         var fowordpage = complete.append(firstPage);
         $.each(page,function(index,item){
             var btnNum = $("<button></button>").addClass("btn btn-default").append(item);
             fowordpage.append(btnNum);
         });
        // 合并的标签
        fowordpage.append(lastPage)
                  .appendTo("#changePage");
    }
</script>