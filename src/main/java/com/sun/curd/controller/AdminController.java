package com.sun.curd.controller;

import com.sun.curd.bean.Admin;
import com.sun.curd.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

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
        if(login!=null){
            session.setAttribute("admin",login);
            return "main";
        }
        return "login";
    }
}
