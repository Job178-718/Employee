<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<jsp:include page="../temp/index_head.jsp"></jsp:include>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-6">
          <h2>个人信息</h2>
        </div>
    </div>
   <div class="panel panel-default">
        <div class="panel-body">
        <%--图片上传--%>
        <%--图片上传只能采用post--%>
        <form id="uploadImg" enctype="multipart/form-data" action="##">
            <div class="container">
                <h2>图片上传</h2>
                <div class="file-loading">
                    <a>
                        <input type="file" name="file" />
                        <div class="row">
                            <div class="col-xs-6 col-md-3">
                                <a href="#" class="thumbnail">
                                    <img src="<c:if test="${empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/static/img/0287.jpg</c:if>
                                    <c:if test="${not empty sessionScope.admin.imgPath}">${pageContext.request.contextPath}/upload/${sessionScope.admin.imgPath}</c:if>" alt="用户头像" id="picture">
                                </a>
                            </div>
                        </div>
                        <input type="button"  value="提交" id="file_submit"/>
                    </a>
                </div>
            </div>
        </form>
        </div>
    <div class="panel-body">

    </div>
</div>
</div>
</body>
<jsp:include page="../temp/index_foot.jsp"></jsp:include>
<script type="text/javascript">
    $("#file_submit").click(
        function(){
            $.ajax({
                url:"${pageContext.request.contextPath}/admin/uploadPicture",
                type:"POST",
                data:new FormData($("#uploadImg")[0]),
                processData:false,
                contentType:false,
                caches:false,
                success:function(result){
                    alert("success");
                    select();
                },
                error:function(){
                    alert("erro");
                }
            });
        }
    );


    function select(){
        $.ajax({
            url:"${pageContext.request.contextPath}/admin/flushImg",
            type:"GET",
            dataType:"json",
            success:function(result){
                $("#picture").attr("src","${pageContext.request.contextPath}/upload/"+result.extend.admin.imgPath);
            }
        });
    }
</script>
