<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>请登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/all/css/login.css" type="text/css" />
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css" />
    <script src="${pageContext.request.contextPath}/static/all/js/login.js"></script>
    <style type="text/css">
        body {
            background-image: url('${pageContext.request.contextPath}/static/img/0555.jpg');
            background-repeat: no-repeat;
            background-size: 100% auto;
        }
    </style>
</head>

<body>
<div id="Login-box">
    <h2 style="color: #fff;">请登录</h2>
    <div class="form">
        <form action="${pageContext.request.contextPath}/admin/login" method="POST">
            <div class="item">
                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                <input type="text" placeholder="Username" name="username" value="aaa"/>
            </div>
            <div class="item">
                <i class="fa fa-key" aria-hidden="true"></i>
                <input type="password" placeholder="Password" name="password" value="aaa"/>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
    <div id="Register">
        <pre><a href="${pageContext.request.contextPath}/">注册</a></pre>
    </div>
</div>
</body>
</html>


