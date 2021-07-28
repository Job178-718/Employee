package com.sun.curd.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.curd.bean.Employee;
import com.sun.curd.bean.State;
import com.sun.curd.commons.Comoons;
import com.sun.curd.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/em")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 将数据传递给后端
     *
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping(value = "/employee", method = RequestMethod.GET)
    public String getEmployee(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //@RequestParam(value = "pn",defaultValue = "1"),参数：pn与页面中的参数pn对应，默认第一页

        //通过控制线程查询数据；
        PageHelper.startPage(pn, 5);

        List<Employee> emps = employeeService.getAll();

        //PageInfo封装了分页中的大部分信息
        PageInfo page = new PageInfo(emps, 5);

        model.addAttribute("pageInfo", page);

        return "admin/list";
    }

    /**
     * 批量删除/单个删除都适用
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public State deleteEmpById(@PathVariable(value = "ids") String ids) {
        System.out.println("进入删除选项！");
        if (ids.contains("-")) {
            //批量删除
            System.out.println("批量删除");
            List<Integer> ids_list = new ArrayList<Integer>();

            String[] id_empId = ids.split("-");
            for (String id : id_empId) {
                ids_list.add(Integer.parseInt(id));
            }

            employeeService.deleteBath(ids_list);
        } else {
            //单个删除
            System.out.println("单个删除");
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return State.sucess();
    }

    /**
     * 员工更新方法；
     *
     * @param employee
     * @return 区别：
     * /emp/{empId}
     * /emp/{id}
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public State updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return State.sucess();
    }

    /**
     * 显示员工
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public State getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return State.sucess().add("employee", employee);
    }


    /**
     * 获取页面信息
     *
     * @param pn
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.GET)
    public State getMsg(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //@RequestParam(value = "pn",defaultValue = "1"),参数：pn与页面中的参数pn对应，默认第一页
        //pn页码参数，6条数据；
        PageHelper.startPage(pn, 6);

        List<Employee> emps = employeeService.getAll();

        //PageInfo封装了分页中的大部分信息
        PageInfo page = new PageInfo(emps, 5);
        //连续显示5页的数字 int[] page = {1,2,3,4,5};
        return State.sucess().add("pageInfo", page);
    }

    /**
     * 查询员工列表（分页查询）
     * 返回完整页面
     *
     * @return String
     */
    // @RequestMapping("/emps")
    public String getEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                         Model model) {
        //@RequestParam(value = "pn",defaultValue = "1"),参数：pn与页面中的参数pn对应，默认第一页

        //pn页码参数，5条数据,从第一页开始展示;
        PageHelper.startPage(pn, 6);

        List<Employee> emps = employeeService.getAll();

        //PageInfo封装了分页中的大部分信息
        PageInfo page = new PageInfo(emps, 5);
        //获取数据后打包在一起，页面调用需要的数据展现出来；

        //连续显示5页的数字 int[] page = {1,2,3,4,5}；
        model.addAttribute("pageInfo", page);
        List<Employee> list = page.getList();

        return "list";
    }

    /**
     * 保存用户
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public State saveEmp(Employee employee) {
        //映射文件出现问题
        employeeService.saveEmp(employee);
        return State.sucess();
    }

    /**
     * 检查用户姓名
     *
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkuser")
    public State checkUser(@RequestParam(value = "empName") String empName) {
        //姓名的正则表达式
        String regs = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        //不符合规定返回
        if (!empName.matches(regs)) {
            return State.fail().add("va_msg", "用户名应为2-5位汉字或6-16位英文字母或数字");
        }

        //先判断用户名是否合法；
        Boolean b = employeeService.checkUser(empName);
        if (b) {
            return State.sucess();
        } else {
            return State.fail().add("va_msg", "用户名不可用");
        }
    }

    @ResponseBody
    @GetMapping(value = "/selectbyname")
    public State selectbyname(@RequestParam("name") String name,@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //首先控制器中的pn应该与前端中的pn对应，employee应该可以接收到前段传来的数据;
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.selectByname(name);
        PageInfo<Employee> page = new PageInfo<>(employees, 5);
        return State.sucess().add(Comoons.PAGEINFO, page);
    }

    @PostMapping("/selectName")
    public String selectNanme(@RequestParam("name") String name,@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpServletRequest request) {
        System.out.println(name);
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.selectByname(name);
        PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);
        request.setAttribute(Comoons.SELECTNAME, pageInfo);
        return "admin/likeselect";
    }
}
