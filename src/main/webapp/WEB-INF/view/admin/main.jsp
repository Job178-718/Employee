<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date date = new Date();
    String time = format.format(date);
%>
<jsp:include page="../temp/index_head.jsp"></jsp:include>
<p>欢迎,${admin.nickName}登录员工管理系统!登录时间:<%=time%></p>
<jsp:include page="../temp/index_foot.jsp"></jsp:include>
