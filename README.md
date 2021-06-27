# SSM-CURD
## 技术
+ 后端：
  > java,SSM框架
+ 数据库：
  > mysql
+ 前端：
  > 1.HTML+CSS+JS 
           
  > 2.Jquery/bootstrap前端框架
## 功能开发
+ 1.登录
     + 登录方法
       > 管理员,创建数据库,(主键id,账号,密码,姓名,性别,邮箱,创建时间);
       ```
       -- 创建数据库,(主键id,账号,密码,姓名,性别,邮箱)
       create table lay_manager(
         lay_id int(10) primary key  AUTO_INCREMENT,
       	username varchar(255) not null,
       	password varchar(255) not null,
       	sex int(2),
       	e_mail varchar(255),
         createTime timestamp	
       );

       ```
## 2.架构
+ 1.controller
+ 2.service
+ 3.dao
      
## 3.功能
  
+ 1.登录 
  > 1.启动跳转：启动服务器后对所有controller进行拦截，判断用户信息是否使用，若用户信息为空跳转到登录界面。      
  > 2.登录过程：通过前端获取到的用户信息对用户进行查询，判断是否存在用户。若存在跳转到系统内部，否则跳转到本页面。
 
+ 2.查询
  > 启动服务器默认返回index.jsp,前端通过Ajax对页面进行响应，Ajax调用控制器，控制器通过业务层调用持久层进行查找,
    最终控制器将数据以JavaBean封装好的json形式进行返回。

## 4.错误
+ 1.jsp中不能加载图片
+ 解决方案：使用springmvc的拦截器，进行静态资源的放行可以完美解决。




