package com.sun.curd.service;

import com.sun.curd.bean.EmployeeExample;
import com.sun.curd.bean.Manager;
import com.sun.curd.bean.ManagerExample;
import com.sun.curd.dao.ManagerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Repository
public class ManagerService {
    @Autowired
    private ManagerMapper managerMapper;

    /**
     * 条件查询
     * @param manager
     */
    public void getManager(Manager manager){
        ManagerExample managerExample = new ManagerExample();
        ManagerExample.Criteria criteria = managerExample.createCriteria();
        criteria.andUsernameEqualTo(manager.getUsername());
        criteria.andPasswordEqualTo(manager.getPassword());
        List<Manager> managers = managerMapper.selectByExample(managerExample);
        for(Manager manager1: managers){
            System.out.println(manager);
        }

    }



}
