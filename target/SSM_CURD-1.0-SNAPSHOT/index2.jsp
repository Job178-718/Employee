<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<jsp:forward page="${APP_PATH}/emps"></jsp:forward>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>CURD页面</title>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"/>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
</body>
</html>

