package com.sun.curd.test;


import com.github.pagehelper.PageInfo;
import com.sun.curd.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring的mvc测试模板
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
@WebAppConfiguration
public class MvcTest {

    //传入springmvc的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取处理结果；
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
            mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }


    @Test
    public void test(){
        //测试毛病
        //1.
        System.out.println("Test");
    }

    @Test
    public void testMvc() throws Exception {
        //连接URL:模拟请求拿到返回值；
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/emps").
                param("pn", "5")).andReturn();
        //param("pn", "1") pn：参数，1为值

        MockHttpServletRequest request = result.getRequest();

        PageInfo page = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("页码："+page.getPageNum());
        System.out.println("总页码:"+page.getPages());
        System.out.println("总记录:"+page.getTotal());
        System.out.println("页面连续显示的页面代码");
        int[] nums = page.getNavigatepageNums();
        for(int num : nums){
            System.out.print(" "+num);
        }

        System.out.println();
        //遍历员工
        List<Employee> list = page.getList();
        for(Employee employee:list){
            System.out.println("==> ID:"+employee.getEmpId()+" name:"+employee.
                    getEmpName()+" email:"+employee.getEmail());
        }

    }



}
