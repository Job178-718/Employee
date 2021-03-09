# SSM-CURD
## 技术
+ 后端：
  >   java,SSM框架，json数据封装javaBean
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
     + 逻辑方法
       + 1.点击按钮获取所有登陆者信息;
       + 2.通过ajax获取信息，不然信息都会失效
       
## 逻辑
+ 查询
  + 业务层：Service   
  + 持久层：Dao
  + View层：Controller
  > 启动服务器默认返回index.jsp,前端通过Ajax对页面进行响应，Ajax调用控制器，控制器通过业务层调用持久层进行查找,
    最终控制器将数据以JavaBean封装好的json形式进行返回。  
+ 登录 
   + 1.点击按钮获取所有登陆者信息;
   + 2.登录之后获取数据,将数据传递给页面;
   + 3.首先登录之前页面内所有功能失效;

## 部署错误分析
+ 1.Springmvc文件错误




