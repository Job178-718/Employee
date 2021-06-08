<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="temp/index_head.jsp"></jsp:include>
<!-- 搭建显示页面 -->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>员工信息</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-primary">删除</button>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>E-mail</th>
                    <th>depetement</th>
                    <th>编辑</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button  class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button  class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
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
                        <a href="${pageContext.request.contextPath}/employee?pn=1">首页</a>
                    </li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                    <li>
                        <a href="${pageContext.request.contextPath}/employee?pn=${pageInfo.pageNum-1}" aria-label="Previous">
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
                            <li><a href="${pageContext.request.contextPath}/employee?pn=${pages}">${pages}</a></li>
                        </c:if>

                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                    <%--本页后面是否还有页面--%>
                    <li>
                        <a href="${pageContext.request.contextPath}/employee?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    </c:if>
                    <li>
                        <a href="${pageContext.request.contextPath}/employee?pn=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<jsp:include page="temp/index_foot.jsp"/>

