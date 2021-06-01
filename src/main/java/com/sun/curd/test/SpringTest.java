package com.sun.curd.test;

import com.sun.curd.bean.Admin;
import com.sun.curd.bean.Employee;
import com.sun.curd.bean.EmployeeExample;
import com.sun.curd.dao.AdminDao;
import com.sun.curd.dao.DepartmentMapper;
import com.sun.curd.dao.EmployeeMapper;

import com.sun.curd.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * @author Job178-718
 *
 *      * 通过spring模块测试
 *      * 1.导入springTest模块
 *      * 2.配置applicationContext.xml信息
 *      * 3.测试环境
 *      * @RunWith(SpringJUnit4ClassRunner.class)
 *      * @ContextConfiguration(locations = {"classpath:applicationContext.xml"})
 *      *
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class SpringTest {

    @Autowired
    AdminDao adminDao;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;


    @Autowired
    SqlSession sqlSession;

    @Autowired
    EmployeeService employeeService;

    @Test
    public void testCurd(){

        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        EmployeeMapper bean = app.getBean(EmployeeMapper.class);
        System.out.println(bean);
//        System.out.println(employeeMapper);
    }


    @Test
    public void springTest(){
        /**
         * 错误分析：
         * 1.引用成功，指向失败
         * @Autowired
         * EmployeeMapper employeeMapper;
         * 2.配置文件不正常
         */


        //插入部门
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //插入员工
        employeeMapper.insertSelective(new Employee(null,"刘类","男","456@163.com",3));

        //批量生成员工代码
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        //批量添加员工
        for(int i=0;i<100;i++){
            String uuid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uuid,"女",uuid+"@163.com",1));
        }


    }

    @Test
    public void query(){
        //dao层正常
        Employee employee = employeeMapper.selectByPrimaryKey(1);
        System.out.println(employee);
    }

    @Test
    public void insert(){
        Employee employee = new Employee();
        employee.setEmpName("刘表");
        employee.setEmail("刘表@163.com");
        employee.setGender("男");
        employee.setdId(2);
//        System.out.println("Service:"+employeeService);
        employeeService.saveEmp(employee);//添加数据
        //1.service层代码不能使用
        //2.问题出现在dao层
        //3.映射层中mapper中的问题
        //4.事务处理时read-only="true"问题
    }

    @Test
    public void selectEmployee(){

        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo("aaaaaa");
        List<Employee> list = employeeMapper.selectByExample(employeeExample);
        for(Employee employee : list){
            System.out.println(employee);
        }
    }

    @Test
    public void select(){
        Admin admin = new Admin();
        admin.setUsername("aaa");
        admin.setPassword("aaa");
        Admin admin1 = adminDao.queryAdmin(admin);
        System.out.println(admin1);
    }

}
