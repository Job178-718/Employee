//最后一页
var lastPage;
//本页
var thisPage;


//初始化
$(function () {
    toPage(1);
});

//跳转功能
function toPage(pn){
    $.ajax({
        url:"${APP_PATH}/emp",
        data:"pn="+pn,
        //pn：传入的数据；
        type:"GET",
        success:function (result) {
            // console.log(result);
            //显示表格内容
            build_emp_table(result);
            //页面信息
            build_page_info(result);
            //显示导航
            build_emp_nav(result);
        }
    });
}

//显示表格内容
function build_emp_table(result){
    $("#emp_table tbody").empty();
    var emps = result.extend.pageInfo.list;
    $.each(emps,function(index,item){
        var checkBoxTd = $("<td><input type='checkbox' class='checkbox_item'/></td>");
        var empIdTd = $("<td></td>").append(item.empId);
        var empNameTd = $("<td></td>").append(item.empName);
        var empGenderTd = $("<td></td>").append(item.gender);
        var empEmailTd = $("<td></td>").append(item.email);
        var empDepartmentTd = $("<td></td>").append(item.department.deptName);

        //编辑按钮
        var setEmpTd = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
            .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
            .append("编辑");
        setEmpTd.attr("edit-id",item.empId);

        //删除按钮
        var delEmpTd = $("<button></button>").addClass("btn btn-danger btn-sm  delete_btn")
            .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            .append("删除");
        delEmpTd.attr("del-id",item.empId);

        //合并单元格
        var btnTd = $("<td></td>").append(setEmpTd).append(" ").append(delEmpTd);
        //表格拼接
        $("<tr></tr>").append(checkBoxTd)
            .append(empIdTd)
            .append(empNameTd)
            .append(empGenderTd)
            .append(empEmailTd)
            .append(empDepartmentTd)
            .append(btnTd)
            .appendTo("#emp_table tbody");


    })
}

//页码信息
function  build_page_info(result) {
    $("#build_page_area").empty();
    //  当前第 页,共 页,共 条记录；
    $("#build_page_area").append("当前第"+result.extend.pageInfo.pageNum+"页，")
        .append("共"+result.extend.pageInfo.pages+"页")
        .append("共"+result.extend.pageInfo.total+"条记录")
    lastPage = result.extend.pageInfo.pages+1
    thisPage = result.extend.pageInfo.pageNum;
}


//显示分页条，点击反应
function build_emp_nav(result){

    $("#build_page_nav").empty();
    //ul标签添加
    var ulEle = $("<ul></ul>").addClass("pagination");
    //首页
    var firstPage = $("<li></li>").append($("<a></a>").append("首页"));
    //前一页
    var prePage = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
    //没有上一行时按钮不可操作
    if(result.extend.pageInfo.hasPreviousPage==false){
        firstPage.addClass("disabled");
        prePage.addClass("disabled");
    }else {
        firstPage.click(function () {
            toPage(1);
        });
        prePage.click(function () {
            toPage(result.extend.pageInfo.pageNum - 1);
        });
    }
    //后一页
    var nextPage = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
    //末页
    var lastPage = $("<li></li>").append($("<a></a>").append("末页"));


    //没有下一页按钮不可操作
    if(result.extend.pageInfo.hasNextPage==false){
        nextPage.addClass("disabled");
        lastPage.addClass("disabled");
    }else{
        nextPage.click(function(){
            toPage(result.extend.pageInfo.pageNum + 1);
        });
        lastPage.click(function(){
            toPage(result.extend.pageInfo.pages);
        });
    }
    //nav拼接
    ulEle.append(ulEle).append(firstPage).append(prePage);
    //遍历显示的页码
    $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
        var numPage = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
        //当前页高显

        numPage.click(function(){
            toPage(item);
        });
        if(result.extend.pageInfo.pageNum==item){
            numPage.addClass("active");
        }
        ulEle.append(numPage);

    })
    //拼接ul元素
    ulEle.append(nextPage).append(lastPage);

    //创建nav
    var nav = $("<nav></nav>").append(ulEle);
    nav.appendTo("#build_page_nav");
}

//重置表单的方法；
function reset_page(element){
    //重置表单
    $(element)[0].reset();
    $(element).find("*").removeClass("has-error has-success");
    $(element).find(".help-block").text("");
}

//新增按钮弹出模块,点击时触发
$("#emp_add_btn").click(function(){
    //每次都重置表单
    reset_page("#emp_add_btn_model form");
    //显示部门信息
    showDepartements("#add_department");
    //点击新增按钮弹出模态框
    $("#emp_add_btn_model").modal({
        backdrop:"static"
    });
});

//展示部门
function showDepartements(element){
    $(element).empty();
    $.ajax({
        url: "${APP_PATH}/depts",
        type: "GET",
        success:function(result){
            // 拼接查找的信息
            $.each(result.extend.depts,function(){
                var deptSelect=  $("<option></option>").append(this.deptName).attr("value",this.deptId);
                deptSelect.appendTo(element);
            });
        }
    });
}

//检验方法
function vail_data_check(element,state,message){
    //清空标签
    $(element).parent().removeClass("has-error has-success");
    $(element).next("span").text("");
    //失败成功给出反应
    if("success"==state){
        $(element).parent().addClass("has-success");
        $(element).next("span").text(message);
    }else if("error"==state){
        $(element).parent().addClass("has-error");
        $(element).next("span").text(message);
    }
}

//姓名和邮箱校验
function valid_data_form(){
    //1.验证使用者姓名
    var empName =  $("#add_Name").val();
    var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    if(!regName.test(empName)) {
        vail_data_check("#add_Name", "error", "Name应输入6-16位英文字母或2-5位中文字母");
        return false;
    }else{
        vail_data_check("#add_Name", "success", "");
    }
    //2.验证邮箱信息
    var empEmail =  $("#add_E-mail").val();
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(empEmail)) {
        vail_data_check("#add_E-mail", "error", "E-mail语法错误!");
        return false;
    }else{
        vail_data_check("#add_E-mail", "success", "")
    }
    return true;
}


//检验方法的具体实现
$("#add_Name").change(function(){
    var empName = this.value;
    $.ajax({
        url:"${APP_PATH}/checkuser",
        data:"empName="+empName,
        type:"GET",
        success:function(result){
            if(result.codeState==100){
                //返回成功
                vail_data_check("#add_Name", "success", "用户名可用");
                $("#add_Name").attr("ajax-va","success");
            }else{
                //返回失败
                vail_data_check("#add_Name", "error", result.extend.va_msg);
                $("#add_Name").attr("ajax-va","error");
            }
        }
    });
});

//点击按钮，进行保存
$("#save_Emp").click(function(){
    // 校验函数返回true则跳过，返回false则，校验失败；
    if(!valid_data_form()){
        return false;
    };

    //姓名校验,ajax-va="error"时，直接返回错误；
    if($("#add_Name").attr("ajax-va")=="error"){
        return false;
    };

    //点击保存按钮添加数据
    $.ajax({
        //传递url
        url:"${APP_PATH}/emp",
        //设置POST类型
        type:"POST",
        //获取数据
        data:$("#emp_add_btn_model form").serialize(),
        success:function(result){
            //保存之后，关闭模块
            $("#emp_add_btn_model").modal("hide");
            //跳转到最后一页
            toPage(lastPage);
        }
    });
});


//1.直接使用click不行：js加载绑定时间在添加按钮之前
//解决方案：使用live/on方法替代
$(document).on("click",".edit_btn",function(){
    //1.显示部门信息
    showDepartements("#update_department");
    //2.查出员工信息
    getEmp($(this).attr("edit-id"));
    //3.将edit-id绑定在更新按钮；
    $("#update_Emp").attr("update-id",$(this).attr("edit-id"));
    //3.弹出模态框
    $("#emp_update_btn_model").modal({
        backdrop:"static"
    });
});

//获取更新列表列表
function getEmp(id){
    $.ajax({
        url:"${APP_PATH}/emp/"+id,
        type:"GET",
        success:function (result) {
            //获取emp对象；
            var emp = result.extend.employee;
            $("#update_Name").text(emp.empName);
            $("#update_E-mail").val(emp.email);
            $("#emp_update_btn_model input[name=gender]").val([emp.gender]);
            $("#emp_update_btn_model select").val([emp.dId]);
        }
    });
}

//绑定更新事件
$("#update_Emp").click(function(){
    //1.验证邮箱信息
    var empEmail =  $("#update_E-mail").val();
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(empEmail)) {
        vail_data_check("#update_E-mail", "error", "E-mail语法错误!");
        return false;
    }else{
        vail_data_check("#update_E-mail", "success", "")
    }

    //2.ajax请求
    $.ajax({
        url:"${APP_PATH}/emp/"+$(this).attr("update-id"),
        type:"PUT",
        data:$("#emp_update_btn_model form").serialize(),
        success:function(result){
            //1.保存之后关闭模块；
            $("#emp_update_btn_model").modal("hide");
            //2.刷新界面；
            toPage(thisPage);
        }
    });
});

//删除按钮
$(document).on("click",".delete_btn",function(){
    var empName = $(this).parents("tr").find("td:eq(2)").text();
    var empId = $(this).attr("del-id");
    if(confirm("是否删除【"+empName+"】用户")){
        $.ajax({
            url:"${APP_PATH}/emp/"+empId,
            type:"DELETE",
            success:function(result){
                //1.打印是否成功
                alert(result.message);
                //2.回到本页面
                toPage(thisPage);
            }
        });
    }
});

//全选||或全不选
$("#check_all").click(function(){
    //判断check_all是否为true；
    //prop处理标签自带的属性，checked处理自定义的属性；
    $(".checkbox_item").prop("checked",$(this).prop("checked"));
});

//去选之后页面全选按钮反应
$(document).on("click",".checkbox_item",function(){
    //获取选中的个数；
    var flag = $(".checkbox_item:checked").length==$(".checkbox_item").length;
    $("#check_all").prop("checked",flag);
});

//删除按钮
$("#emp_delete_btn").click(function(){
    var empNames = "";
    var empIds = "";
    $.each($(".checkbox_item:checked"),function(){
        //empNames
        empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
        //empIds
        empIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
    });
    //去除empNames最后的
    empNames = empNames.substring(0,empNames.length-1);
    empIds = empIds.substring(0,empIds.length-1);

    if(empNames==""){
        alert("请选择删除用户！！");
        return false;
    }
    //判断删除对象；
    if(confirm("确认删除["+empNames+"]")){
        $.ajax({
            url:"${APP_PATH}/emp/"+empIds,
            type:"DELETE",
            success:function(result){
                alert(result.message);
                toPage(thisPage);
                quitDel_btn();
            }
        })
    }
});

/**
 *删除之后取消绑定
 */
function quitDel_btn() {
    var del = $("#check_all").prop("checked",false);
}
