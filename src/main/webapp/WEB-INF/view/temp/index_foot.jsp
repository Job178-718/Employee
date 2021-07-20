<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</div>
</div>
</div>
</div>
</div>
<footer>
    <div class="pull-right">
        Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
    </div>
    <div class="clearfix"></div>
</footer>
<script src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/fastclick.js"></script>
<script src="${pageContext.request.contextPath}/static/js/nprogress.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/custom.min.js"></script>
<c:if test="${not empty param.needSwitch}">
    <script src="${pageContext.request.contextPath}/static/plugins/switch/bootstrap-switch.min.js"></script>
</c:if>
<c:if test="${not empty param.needCropper}">
    <script src="${pageContext.request.contextPath}/static/plugins/cropper/cropper.js"></script>
</c:if>
<c:if test="${not empty param.needAlert}">
    <script src="${pageContext.request.contextPath}/static/plugins/sweetalert2.js"></script>
</c:if>
<c:if test="${not empty param.needTable}">
    <script src="${pageContext.request.contextPath}/static/plugins/table/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath}/static/plugins/table/bootstrap-table-zh-CN.min.js"></script>
</c:if>
</body>
</html>
