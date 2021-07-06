<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工管理系统</title>
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/nprogress.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/custom.min.css" rel="stylesheet">
    <c:if test="${not empty param.needSwitch}">
        <link href="${pageContext.request.contextPath}/static/plugins/switch/bootstrap-switch.min.css" rel="stylesheet">
    </c:if>
    <c:if test="${not empty param.needCropper}">
        <link href="${pageContext.request.contextPath}/static/plugins/cropper/cropper.css" rel="stylesheet">
    </c:if>
    <c:if test="${not empty param.needTable}">
        <link href="${pageContext.request.contextPath}/static/plugins/table/bootstrap-table.css" rel="stylesheet">
    </c:if>
<style type="text/css">
    body .right_col{
        background-image: url('${pageContext.request.contextPath}/static/img/0558.jpg');
        background-repeat: no-repeat;
        background-size: 100% auto;
    }
</style>

</head>
<body class="nav-md">
<div class="container body">
    <div class="main_container">
        <div class="col-md-3 left_col menu_fixed">
            <div class="left_col scroll-view">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="index.html" class="site_title"><i class="fa fa-users"></i> <span>员工管理系统</span></a>
                </div>
                <div class="clearfix"></div>
                <div class="profile clearfix">
                    <div class="profile_pic">
                        <img src="<c:if test="${empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/static/img/0287.jpg</c:if>
                                    <c:if test="${not empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/upload/${sessionScope.admin.imgPath}</c:if>" alt="用户头像" style="width:40px;height: 40px;margin-top: 20px;margin-left: 30px;border-radius: 50px">
                    </div>
                    <div class="profile_info">
                        <span>欢迎登录，
                        <c:if test="${empty admin.nickName}">${admin.username}</c:if><c:if test="${not empty admin.nickName}">${admin.nickName}</c:if>
                        </span>
                    </div>
                </div>
                <br />
                <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                    <div class="menu_section">
                        <h3>General</h3>
                        <ul class="nav side-menu">
                            <li><a><i class="fa fa-home"></i> 我的信息 <span class="fa fa-chevron-down"></span></a>
                                <ul class="nav child_menu">
                                    <li><a href="${pageContext.request.contextPath}/admin/personal">个人主页</a></li>
                                    <li><a href="${pageContext.request.contextPath}/admin/upload">修改头像</a></li>
                                    <li><a href="#">我的通知</a></li>
                                </ul>
                            </li>
                            <li><a><i class="fa fa-id-card"></i> 员工管理<span class="fa fa-chevron-down"></span></a>
                                <ul class="nav child_menu">
                                    <li><a href="${pageContext.request.contextPath}/em/employee">员工信息</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sidebar-footer hidden-small">
                    <a data-toggle="tooltip" data-placement="top" title="Settings">
                        <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                        <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Lock">
                        <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                    </a>
                    <a data-toggle="tooltip" data-placement="top" title="Logout" href="${pageContext.request.contextPath}/admin/singnOut">
                        <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                    </a>
                </div>
            </div>
        </div>
        <div class="top_nav">
            <div class="nav_menu">
                <nav>
                    <div class="nav toggle">
                        <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="">
                            <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <img src="<c:if test="${empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/static/img/0287.jpg</c:if>
                                    <c:if test="${not empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/upload/${sessionScope.admin.imgPath}</c:if>" alt="用户头像">
                                <span class=" fa fa-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-usermenu pull-right">
                                <li><a href="${pageContext.request.contextPath}/admin/personal"> 个人主页</a></li>
                                <li><a href="javascript:;">修改密码</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin/singnOut"><i class="fa fa-sign-out pull-right"></i> 登出</a></li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown">
                            <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-envelope-o"></i>
                                <span class="badge bg-green">00</span>
                            </a>
                            <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                                <li>
                                    <a>
                                        <span class="image"><img src="${pageContext.request.contextPath}/upload/${admin.imgPath}" alt="Profile Image" /></span>
                                        <span>
                                            <span>John Smith</span>
                                            <span class="time">3 mins ago</span>
                                        </span>
                                        <span class="message">
                                            Film festivals used to be do-or-die moments for movie makers. They were where...
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <div class="text-center">
                                        <a>
                                            <strong>See All Alerts</strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                </div>
                <div class="clearfix"></div>
                <div class="row">
