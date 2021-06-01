package com.sun.curd.Interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IntegerAdmin extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        Object admin = request.getSession().getAttribute("admin");
        System.out.println("进来了。。。。");
        if(admin==null){
//            request.getRequestDispatcher(request.getContextPath()+"/admin/login").forward(request,response);;
            response.sendRedirect(request.getContextPath()+"/admin/login");
            System.out.println("执行了");
            return false;
        }
        return true;
    }

}
