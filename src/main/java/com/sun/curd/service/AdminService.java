package com.sun.curd.service;

import com.sun.curd.bean.Admin;
import com.sun.curd.dao.AdminDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    AdminDao adminDao;

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    public Admin login(String username,String password){
        Admin admin = new Admin();
        admin.setUsername(username);
        admin.setPassword(password);
        return adminDao.queryAdmin(admin);
    }
}
