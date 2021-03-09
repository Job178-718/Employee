package com.sun.curd.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.curd.bean.Employee;
import com.sun.curd.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
@Controller
@RequestMapping("/user")
public class LayoutController {
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/getEmployee")
    public String getEmp(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                         Model model){
        //@RequestParam(value = "pn",defaultValue = "1"),参数：pn与页面中的参数pn对应，默认第一页
        //pn页码参数，5条数据；
        PageHelper.startPage(pn,6);

        List<Employee> emps = employeeService.getAll();

        //PageInfo封装了分页中的大部分信息
        PageInfo page = new PageInfo(emps,5);
        //连续显示5页的数字 int[] page = {1,2,3,4,5}；
        model.addAttribute("pageInfo", page);
        List<Employee> list = page.getList();

        return "employee";
    }

    @RequestMapping("/login")
    public String loginMange(){

        return "login";
    }
}
