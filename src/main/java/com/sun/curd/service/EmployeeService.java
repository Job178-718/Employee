package com.sun.curd.service;

import com.sun.curd.bean.Employee;
import com.sun.curd.bean.EmployeeExample;
import com.sun.curd.bean.State;
import com.sun.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     *  查询员工是否重复；
     * @param empName
     * @return 没有相同的名字true，已经有相同名字返回false；
     */
    public  boolean checkUser(String empName) {
        //创建条件对象
        EmployeeExample example = new EmployeeExample();
        //给出标准
        EmployeeExample.Criteria criteria = example.createCriteria();
        //检验标准
        criteria.andEmpNameEqualTo(empName);
        //通过条件查询是否存在本用户；
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     *查询所有员工
     * @return
     */
    public List<Employee> getAll(){

        //1.获取所有employee对象;
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        return employees;
    }

    /**
     * 保存员工
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 通过主键查id
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 更新数据
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 通过主键删除emp
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
        System.out.println("deleteById...");
    }

    /**
     * 批量删除
     * @param ids
     */
    public void deleteBath(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
        System.out.println("oneByOne");
    }
}
