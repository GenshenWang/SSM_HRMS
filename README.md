# Java SSM练手小项目-手把手带你搭建一个基于SSM框架的人力资源管理后台系统


## 前言
相信很多小伙伴在学习完SSM三大架构以后，不知道该如何找到一个简单容易上手的项目进行实战训练，经常在博客上看到一个不错的项目下载下来以后全部都是代码，无处下手。因此本文力求以最简单易懂的项目结构和代码搭建一个还较为完整（即从登录到退出的整个流程）的后台系统。
（高手勿喷）

整个项目的操作流程动态图如下：


用到的技术点有：
* 框架：SSM
* 数据库：MySQL
* 前端框架：Bootstrap快速搭	搭建JSP页面
* 项目管理：MAVEN
* 开发工具：IntellijIDEA
* 开发环境：Windows

从这个项目中你可以完整独立地体验从前端到后台的搭建过程，以及使用SSM框架完成后台的CRUD整个流程。

## 一、准备
准备部分主要包括数据库建表、SSM框架的搭建启动。

**1 数据库建表**

tbl_emp表：
```
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp`(
	`emp_id` int(11) UNSIGNED NOT NULL auto_increment,
	`emp_name` VARCHAR(22) NOT NULL DEFAULT '',
  `emp_email` VARCHAR(256) NOT NULL DEFAULT '',
  `gender` CHAR(2) NOT NULL DEFAULT '',
   `department_id` int(11) NOT NULL DEFAULT 0,
	 PRIMARY KEY(`emp_id`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8;
```

tbl_dept表：
```
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept`(
	`dept_id` int(11) NOT NULL DEFAULT 0,
	`dept_name` VARCHAR(255) NOT NULL DEFAULT '',
  `dept_leader` VARCHAR(255) NOT NULL DEFAULT ''

) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
对应的实体类见bean/Employee.java和bean/Department.java。


**2 SSM项目搭建与启动**

（1）首先导入项目中可能用到的依赖包：
见pom.xml.

（2）web.xml：
见WEB-INF/web.xml.

（3）Spring容器配置文件：applicationContext.xml：
见resources/applicationContext.xml.

（4）SpringMVC配置文件：springmvc.xml：
见resources/springmvc.xml.

**3 测试**
写好上述配置文件后，可以在controller目录下新建TestController.java文件和WEB-INF/jsp/test.jsp，启动容器测试是否成功。


## 二、DAO层代码完成与测试
这一章主要完成数据库底层的CRUD代码实现与测试工作.

**1. MyBasits配置文件**

见resources/MyBatis.xml.

**2. DAO层代码**

首先编写实体类Employee 与 表tbl_emp相关操作代码。
EmployeeMapper.java主要接口有：
```
int deleteOneById(@Param("empId") Integer empId);
int updateOneById(@Param("empId") Integer empId,
                   @Param("employee") Employee employee);
int insertOne(Employee employee);           
 Employee selectOneById(@Param("empId") Integer empId);
Employee selectOneByName(@Param("empName") String empName);
// 查询带有部门信息的Employee
Employee selectWithDeptById(@Param("empId") Integer empId);
// 分页查询
List<Employee> selectByLimitAndOffset(@Param("limit") Integer limit,@Param("offset") Integer offset);
int countEmps();
```
具体实现参考EmployeeMapper.java与EmployeeMapper.xml中代码。

写完后需要对实现的代码进行测试，以验证代码的正确性。
测试用例代码见EmployeeMapperTest.java。

类似地，
实体类Department与 表tbl_dept相关操作代码实现也如上类似，具体实现见DepartmentMapper.java 与 DepartmentMapper.xml，测试用例代码见DepartmentMapperTest.java。

## 三、前端页面的搭建
前端页面实现的最终效果如下。
主页面：
![Alt text](./1520599179172.png)

员工操作页面（部门操作页面类似）：
![Alt text](./1520599165397.png)


最后加上一个登陆页面（比较简单的页面加上最简单的登录判断）：
![Alt text](./1520308535903.png)

主要就是采用Bootstrap3去搭建这个前端页面，然后再利用SSM框架+JSP完成从前端到后端的整个流程。
下面首先Bootstrap3去搭建前端页面。

#### **1 主页面的静态搭建**

主页面的HTML代码实现放在webapp/static/html/hrms_main.html，（此处仅仅为了方便查看和参考）。
整个主页面完成后，分别将其中公共部分的代码提取出来，如导航栏，左侧栏，尾部这3个部分都属于公共部分，
分别见hrms_head.html、hrms_foot.html、hrms_leftsidebar.html三个部分。

#### **2 公共页面的JSP实现及分层**

下面将上述公共部分的HTML代码用JSP实现，详细见WEB-INF/jsp/commom目录下的head.jsp、foot.jsp、leftsidebar.jsp。

然后实现主页面的内容，主要包括三个公共部分（导航栏+左侧栏+尾部+轮播部分），实现效果如下：
![Alt text](./1520601286508.png)

新建main.jsp，将上述三个公共部分的代码用
`<<%@ include file="./commom/xx.jsp"%>>`引入，再实现轮播图部分即可。


#### **3 员工操作/部门操作的静态页面实现**

员工操作页面与主页面3个公共部分相同，不同之处在于中间部分展示的是员工信息的表格显示，而主页面是一个轮播图。
![Alt text](./1520601459034.png)


下面就将实现employeePage的页面，详细代码见employeePage.jsp（即将main.jsp中的轮播部分换成员工表单显示部分即可）。

（为了方便对比与查看，将实现的HTML部分代码留在了项目目录中，实现的HTML代码见WEB-INF/static/html/hrms_employee.html。
相应的部门显示的页面类似，实现的HTML代码见WEB-INF/static/html/hrms_department.html。
然后将上述代码分别用JSP页面实现，即对应的employeePage.jsp和departmentPage.jsp。）

## 四、员工CRUD操作前后端实现
#### **1  员工信息查询的数据显示**

页面搭建完成以后，就要将从后台获取到的数据展示在对应的页面中。页面数据展示部分主要实现是利用JSP的JSTL表达式和AJAX+jQuery，将从后台获取到的数据显示在页面对应的位置。

由于部门操作与员工操作类似，下面主要讲解员工显示页面的实现。
整个流程是从数据库中查询到数据后，放在SpringMVC的ModelAndView中，然后前端通过JSTL就可以解析获取到的结果集。
（1）首先写一个JSON相关的操作类：JsonMsg.java。
（2）业务操作：EmployeeService.java；
（3）Controller类：EmployeeController.java；
EmployeeController.java中接口""emp/getEmpList?pageNo=XXX""是根据输入的页码返回对应页数的数据，然后用JSTL表达式进行解析显示。
```
    @RequestMapping(value = "/getEmpList", method = RequestMethod.GET)
    public ModelAndView getEmp(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo){
        ModelAndView mv = new ModelAndView("");
        int limit = 5;
        // 记录的偏移量(即从第offset行记录开始查询)，
        // 如第1页是从第1行(offset=(21-1)*5=0,offset+1=0+1=1)开始查询；
        // 第2页从第6行(offset=(2-1)*5=5,offset+1=5+1=6)记录开始查询
        int offset = (pageNo-1)*limit;
        //获取指定页数包含的员工信息
        List<Employee> employees = employeeService.getEmpList(offset, limit);
        //获取总的记录数
        int totalItems = employeeService.getEmpCount();
        //获取总的页数
        int temp = totalItems / limit;
        int totalPages = (totalItems % limit == 0) ? temp : temp+1;
        //当前页数
        int curPage = pageNo;

        //将上述查询结果放到Model中，在JSP页面中可以进行展示
        mv.addObject("employees", employees)
                .addObject("totalItems", totalItems)
                .addObject("totalPages", totalPages)
                .addObject("curPage", curPage);
        return mv;
    }

```
然后在employeePage.jsp页面上将后端的Modal中数据取出来进行显示。
主要代码有：
```
<tbody>
	<c:forEach items="${employees}" var="emp">
		 <tr>
		     <td>${emp.empId}</td>
		     <td>${emp.empName}</td>
		     <td>${emp.empEmail}</td>
		     <td>${emp.gender == "M"? "女": "男"}</td>
		     <td>${emp.department.deptName}</td>
		     <td>
		         <a href="#" role="button" class="btn btn-primary">编辑</a>
		         <a href="#" role="button" class="btn btn-danger">删除</a>
		      </td>
		</tr>
	</c:forEach>
</tbody>
```
和
```
<div class="table_items">
	当前第<span class="badge">${curPage}</span>页，共有<span class="badge">${totalPage}</span>页，总记录数<span class="badge">${totalItems}</span>条。
</div>
```

（4）分页栏的代码实现。
分页栏完成效果如下：
![Alt text](./1520426940165.png)

关于分页栏需要完成的需求有：
* 当前页需要激活（主要是页面上的1，2，3，4，5页）；
* 在首页（第1页）的时候，<< 禁止点击；
* 在末页（最后一页）的时候，>>禁止点击；
* 默认显示首页数据；
* 首页，上一页，末页，下一页添加事件，显示对应页码数据
* 中间页每一页，为其添加点击事件，并跳转到对应页面；
* 左边信息栏中当前第X页需要根据点击的页数同步显示。

主要的代码实现都是在前端使用jQuery+JSTL实现的。代码如下：
```
<div class="panel-body">
此处代码略
</div>
```
以及对应的jQuery实现上一页、下一页的操作：
```
$(function () {
        //上一页
        var curPage = ${curPage};
        var totalPages = ${totalPages};
        $(".prePage").click(function () {
            if (curPage > 1){
                var pageNo = curPage-1;
                $(this).attr("href", "/emp/getEmpList?pageNo="+pageNo);
            }
        });
        //下一页
        $(".nextPage").click(function () {
            if (curPage < totalPages){
                var pageNo = curPage+1;
                $(this).attr("href", "/emp/getEmpList?pageNo="+pageNo);
            }
        });
    })
```

最后在主页面中的员工信息加上一个指定链接，跳转到当前员工信息显示的页面（部门操作类似，不再赘述）,以及点击公司LOGO的时候跳转到主页面。
代码如下：
head.jsp:
```
<script type="text/javascript">
    //跳转到主页面
    $("#company_logo").click(function () {
        $(this).attr("href", "/hrms/main");
    });
```
leftsidebar.jsp:
```
<script type="text/javascript">
    //跳转到员工页面
    $(".emp_info").click(function () {
        $(this).attr("href", "/hrms/emp/getEmpList");
    });
    //跳转到部门页面
    $(".dept_info").click(function () {
        $(this).attr("href", "/hrms/dept/getDeptList");
    });
</script>
```


至此，员工信息的显示部分基本完成。

####  **2  员工添加**

接下来将会实现员工的新增操作，以及对新增数据的简单验证。
完成的页面效果如下：
![Alt text](./1520588009736.png)

主要完成的需求有：
* （1）点击左侧栏的员工新增按钮，弹出员工新增的模态框页面；
* （2）对输入的姓名和邮箱格式进行验证，格式不正确，提示错误信息；
* （4） 对输入的姓名进行姓名是否重复判断，重复则提示重复信息；
* （5）添加成功后跳转到添加记录所在的页面（即最后一页）；
* （6）添加失败则提示错误信息。

后台代码实现主要有：
```
    /**
     * 查询输入的员工姓名是否重复
     * @param empName
     * @return
     */
    @RequestMapping(value = "/checkEmpExists", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg checkEmpExists(@RequestParam("empName") String empName){
        //对输入的姓名与邮箱格式进行验证
        String regName = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regName)){
            return JsonMsg.fail().addInfo("name_reg_error", "输入姓名为2-5位中文或6-16位英文和数字组合");
        }
        Employee employee = employeeService.getEmpByName(empName);
        if (employee != null){
            return JsonMsg.fail().addInfo("name_reg_error", "用户名重复");
        }else {
            return JsonMsg.success();
        }
    }

    /**
     * 新增记录后，查询最新的页数
     * @return
     */
    @RequestMapping(value = "/getTotalPages", method = RequestMethod.GET)
    @ResponseBody
    public JsonMsg getTotalPage(){
        int totalItems = employeeService.getEmpCount();
        //获取总的页数
        int temp = totalItems / 5;
        int totalPages = (totalItems % 5 == 0) ? temp : temp+1;
        return JsonMsg.success().addInfo("totalPages", totalPages);
    }

    /**
     * 新增员工
     * @param employee 新增的员工信息
     * @return
     */
    @RequestMapping(value = "/addEmp", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg addEmp(Employee employee){
        int res = employeeService.addEmp(employee);
        if (res == 1){
            return JsonMsg.success();
        }else {
            return JsonMsg.fail();
        }
    }
```

前端代码见**employeeAdd.jsp。**
主要是jQuey的操作，很多操作可以封装成一个函数进行调用，例如错误信息的显示。本文为了便于查看，没有进行封装。


#### **3  员工更改**

员工修改操作完成页面如下：
![Alt text](./1520587529370.png)
![Alt text](./1520587549441.png)

主要完成的需求有：
* （1） 获取点击修改员工的id与name;
* （2） 根据id或name查询出对应员工信息进行回显；
* （3） 回显部门列表；
* （4） 进行修改，对修改的邮箱格式进行判断；
* （5） 点击更新按钮，发送AJAX请求到后台进行保存；
* （6）更改成功后跳转到当前更改页面。

后台代码实现主要有：
```
    /**
     * 更改员工信息
     * @param empId
     * @param employee
     * @return
     */
    @RequestMapping(value ="/updateEmp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public JsonMsg updateEmp(@PathVariable("empId") Integer empId,  Employee employee){
        int res = employeeService.updateEmpById(empId, employee);
        if (res != 1){
            return JsonMsg.fail().addInfo("emp_update_error", "更改异常");
        }
        return JsonMsg.success();
    }
```
前端页面+jQuery代码见：**employeeUpdate.jsp**。


####  **4 员工删除**

员工删除操作完成页面如下：
![Alt text](./1520587790035.png)


主要完成的需求有：
* （1）弹出确认框：是否删除XX信息；
*  （2）发送AJAX请求，执行删除操作；
*   （3）删除成功后，跳转到当前页。

后台代码：
```
    /**
     * 员工删除操作
     * @param empId
     * @return
     */
    @RequestMapping(value = "/deleteEmp/{empId}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonMsg deleteEmp(@PathVariable("empId") Integer empId){
        int res = employeeService.deleteEmpById(empId);
        if (res != 1){
            return JsonMsg.fail().addInfo("emp_del_error", "员工删除异常");
        }
        return JsonMsg.success();
    }
```

前端页面代码见employeePage.jsp:
```
    <!-- ==========================员工删除操作=================================== -->
    $(".emp_delete_btn").click(function () {
        var curPage = ${curPage};
        var delEmpId = $(this).parent().parent().find("td:eq(0)").text();
        var delEmpName = $(this).parent().parent().find("td:eq(1)").text();
        if (confirm("确认删除【" + delEmpName+ "】的信息吗？")){
            $.ajax({
                url:"/hrms/emp/deleteEmp/"+delEmpId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href="/hrms/emp/getEmpList?pageNo="+curPage;
                    }else {
                        alert(result.extendInfo.emp_del_error);
                    }
                }
            });
        }
    });
```


至此，SSM项目的增删改查操作也基本完成，部门操作与上类似，本文不再赘述，感兴趣的可以略看Department相关操作的代码。


####  **5 登录页面**

最后，为求项目的完整性，加上一个登陆页面，实现的效果
图如下：
![Alt text](./1520599502796.png)

后台主要做了一个简单的登录验证，代码见LoginController.java：
```
    /**
     * 登录：跳转到登录页面
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    /**
     * 对登录页面输入的用户名和密码做简单的判断
     * @param request
     * @return
     */
    @RequestMapping(value = "/dologin", method = RequestMethod.POST)
    @ResponseBody
    public JsonMsg dologin(HttpServletRequest request){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println(username + password);
        if (!"admin1234".equals(username + password)){
            return JsonMsg.fail().addInfo("login_error", "输入账号用户名与密码不匹配，请重新输入！");
        }
        return JsonMsg.success();
    }

    /**
     * 跳转到主页面
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(){
        return "main";
    }

    /**
     * 退出登录：从主页面跳转到登录页面
     * @return
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(){
        return "login";
    }

```

前台页面见login.jsp代码；以及退出登录按钮的操作见head.jsp：
```
//账号退出
$(".hrms_logout").click(function () {
  window.location.href = "/hrms/logout";
});
```

## 五、项目代码下载
最后，将本次项目的代码上传到我的github当中，想要下载的话<a href="">戳这里</a>，如果觉得对你有帮助别忘了在我的github上随手点个star，THX！

----
2018/03/09 in NJ.