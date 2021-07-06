function validateForm() {
    var x = document.forms["Form"]["user"].value;
    if (x == "") {
        alert("请填写用户名！");
        return false;
    }
    var y = document.forms["Form"]["key"].value;
    if (y == "") {
        alert("密码为空！");
        return false;
    }
}

