package com.sun.curd.controller;

import com.sun.curd.bean.Admin;
import com.sun.curd.bean.State;
import com.sun.curd.commons.Comoons;
import com.sun.curd.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    //1 登录页面
    @GetMapping("/login.html")
    public String loginMange(){
        return "login";
    }

    //2 登录成功
    @GetMapping("/index.html")
    public String loginSucess(){
        return "admin/main";
    }

    //3 登录验证
    @PostMapping("/main.html")
    public String loginMange(String username, String password, HttpSession session, Model model){
        System.out.println("登录");
        Admin login = adminService.login(username, password);
        if(login!=null){
            session.setAttribute("admin",login);
            return "redirect:/admin/index.html";
        }
        model.addAttribute("msg","密码或者账号错误");
        return "redirect:/admin/login.html";
    }


    //4 更改图像
    @ResponseBody
    @GetMapping("/flushImg")
    public State flushImg(HttpServletRequest request){
        HttpSession session = request.getSession();
        Admin admin  = (Admin)session.getAttribute(Comoons.ADMIN);
        Integer id = admin.getLayId();
        System.out.println(id);
        Admin admin1 = adminService.queryById(id);
        return State.sucess().add(Comoons.ADMIN,admin);
    }

    //5 退出实现
    @GetMapping("/singnOut.html")
    public String singOut(HttpSession session){
        session.invalidate();
        return "redirect:/admin/login.html";
    }

    //6 跳转到个人信息页
    @GetMapping("/personal")
     public String personInformation(){
        return "admin/personal";
   }


    //7 图片上传
    @PostMapping("/uploadPicture")
    public String upload(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request) throws IOException {

        //获取原始文件名
        String uploadFilename = file.getOriginalFilename();
        if("".equals(uploadFilename)){
            return "/admin/personal";
        }
        System.out.println("上传文件名："+uploadFilename);

       //在服务器上创建upload文件
        String path = request.getServletContext().getRealPath("/upload");
        File realPath = new File(path);
        if(!realPath.exists()){
            realPath.mkdir();
        }
        System.out.println("上传文件保存地址"+realPath);

        //对上传的文件进行读取
        InputStream is = file.getInputStream();
        OutputStream os = new FileOutputStream(new File(realPath, uploadFilename));
        int len=0;
        byte[] buffer =new byte[1024];

        while((len=is.read(buffer))!=-1){
            os.write(buffer,0,len);
            os.flush();
        }
        os.close();
        is.close();
        //上传之后更新
        HttpSession session = request.getSession();
        Admin admin = (Admin)session.getAttribute("admin");
        Integer id = admin.getLayId();
        adminService.uploadImg(id,uploadFilename);
        return "/admin/personal";
    }

    @GetMapping("/upload")
    public String modifyImage(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request) throws IOException {

        //获取原始文件名
        String uploadFilename = file.getOriginalFilename();
        if("".equals(uploadFilename)){
            return "/admin/personal";
        }
        System.out.println("上传文件名："+uploadFilename);

        //在服务器上创建upload文件
        String path = request.getServletContext().getRealPath("/upload");
        File realPath = new File(path);
        if(!realPath.exists()){
            realPath.mkdir();
        }
        System.out.println("上传文件保存地址"+realPath);

        //对上传的文件进行读取
        InputStream is = file.getInputStream();
        OutputStream os = new FileOutputStream(new File(realPath, uploadFilename));
        int len=0;
        byte[] buffer =new byte[1024];

        while((len=is.read(buffer))!=-1){
            os.write(buffer,0,len);
            os.flush();
        }
        os.close();
        is.close();
        //上传之后更新
        HttpSession session = request.getSession();
        Admin admin = (Admin)session.getAttribute("admin");
        Integer id = admin.getLayId();
        adminService.uploadImg(id,uploadFilename);
        return "/admin/upload";
    }


    @GetMapping("/select.html")
    public String selectByQuite(){
        return "admin/find";
    }


    @PostMapping("/flushPage")
    public String flush(){
        return "";
    }

}
