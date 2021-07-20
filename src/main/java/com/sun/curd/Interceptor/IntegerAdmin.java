package com.sun.curd.Interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IntegerAdmin extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        Object admin = request.getSession().getAttribute("admin");
        if(admin==null){
             response.sendRedirect(request.getContextPath()+"/admin/login");
            // request.getRequestDispatcher(request.getContextPath()+"/admin/login").forward(request,response);
            return false;
        }
        return true;
    }
}
