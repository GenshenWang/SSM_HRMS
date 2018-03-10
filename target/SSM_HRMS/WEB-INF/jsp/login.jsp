<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/ionicons/2.0.1/css/ionicons.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//cdn.bootcss.com/jquery/2.1.4/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4" style="margin: 380px 380px">
            <div class="login-panel panel panel-default" >
                <div class="panel-heading">
                    <h3 class="panel-title" style="text-align: center;">登录</h3>
                </div>
                <div class="panel-body">
                    <form role="form" action="#" method="post" id="login_form">
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control" placeholder="用户名:admin" name="username" autofocus>
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="密码:1234" name="password" type="password" value="">
                            </div>
                            <!-- Change this to a button or input when using this as a form -->
                            <a href="javascript:void(0)" class="btn btn-lg btn-success btn-block" id='login_btn'>登录</a>
                        </fieldset>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function () {
        $("#login_btn").click(function () {
            $.ajax({
                url:"/hrms/dologin",
                type:"POST",
                data:$("#login_form").serialize(),
                success:function (result) {
                    if(result.code == 100){
                        window.location.href= "/hrms/main";
                    }else {
                        alert(result.extendInfo.login_error);
                    }
                }

            });
        });
    });
</script>
</body>
</html>
