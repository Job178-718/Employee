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
                        <div class="col-md-4 col-md-offset-6" style="margin-bottom: 20px">
                            <button  class="btn btn-primary" id="addEmployee">新增</button>
                            <button  class="btn btn-primary" id="deleteEmployee">删除</button>
                            <button  class="btn btn-primary" id="test">全部员工</button>
                        </div>
                    </div>
                </div>
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
                        <tbody>
                            <c:forEach items="${employeeByName}" var="emp">
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
                            </c:forEach>
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
    <jsp:include page="../temp/index_foot.jsp"></jsp:include>
<script>
        $("#selectName").click(function(){
            var name = $("#select").val();
            alert(name);
            if(name!=null && name!=' '){
                alert("判断语句");
                window.location.href="${pageContext.request.contextPath}/em/selectName?name="+name;
            }
            alert("没进来");
            return false;
        });
    </script>



