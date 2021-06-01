package com.sun.curd.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.curd.bean.Admin;
import com.sun.curd.bean.Employee;
import com.sun.curd.service.AdminService;
import com.sun.curd.service.EmployeeService;
import com.sun.org.apache.xpath.internal.objects.XNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    @GetMapping("/login")
    public String loginMange(){
        return "login";
    }

    @PostMapping("/login")
    public String loginMange(String username, String password, HttpSession session){
        Admin login = adminService.login(username, password);
        System.out.println("controller跳转");
        if(login!=null){
            session.setAttribute("admin",login);
            return "homepage";
        }

        return "login";
    }
}
