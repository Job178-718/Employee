<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <meta chatset="UTF-8">
    <title>登录</title>
    <style type="text/css">
        #login-box {
            border: 1px solid blue;
            width: 30%;
            text-align: center;
            margin: 0 auto;
            margin-top: 15%;
            background: #BCCCE5;
            padding: 20px 50px;
        }
        #login-box h1 {
            color: white;
        }

        #login-box .form .item input {
            width: 200px; /* 设置合适的宽度 */
            border: 0; /* 首先将边界取消，方便下面修改下部边界宽度 */
            border-bottom: 5px solid white; /* 将下边界进行修改，显示出横线效果 */
            font-size: 18px; /* 将字体适当的变大加粗 */
            background: #ffffff00; /* 将输入框设置为透明 */
            color: white; /* 上面的文本颜色设置为白色，但是placeholder的颜色要单独设置 */
            padding: 5px 10px; /* 为了placeholder的内容不是顶格显示，增加内部边界 */
        }

        #login-box .form .item i {
            color: white;
            font-size: 18px;
        }

        body {
            background-image: url(${APP_PATH}/webapp/WEB-INF/img/0558.jpg);
            background-size: 100% auto;
            background-repeat: no-repeat;
        }

        #login{
            height: 30px;
            width: 50px;
            margin-top: 10px;
            border-radius: 5px;
            background-color: aquamarine;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/login" method="POST">
    <div id="login-box">
        <h1>Login</h1> <!-- Login的大标题 -->
        <div class="form">
            <div class="item"> <!-- username部分 -->
                <i></i> <!-- 将来用来绘制username前面的图标 -->
                <input type="text" placeholder="username" name="username">
                <!-- 用文本框实现的username的输入 -->
            </div>
            <div class="item"><!-- password部分 -->
                <i></i> <!-- 将来用来绘制password前面的图标 -->
                <input type="password" placeholder="password" name="password">
                <!-- 用password文本框实现的密码输入 -->
            </div>
        </div>
        <button type="submit" id="login">Login</button>
        <!-- 用button实现的Login登陆按钮 -->
    </div>
</form>
</body>
</html>

