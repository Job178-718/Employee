package com.sun.curd.controller;

import com.sun.curd.bean.Department;
import com.sun.curd.bean.State;
import com.sun.curd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/depts")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 查询所有部门:
     * add(depts,list),depts：封装的list的集合；
     * @return State
     */
    @ResponseBody
    @RequestMapping("/getDepts")
    public State getDepts(){
        List<Department> list = departmentService.getDepts();
        return State.sucess().add("depts",list);
    }

}
