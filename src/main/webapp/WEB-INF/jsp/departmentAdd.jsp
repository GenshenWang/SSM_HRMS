<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>部门新增页面</title>
</head>
<body>
<div class="modal fade dept-add-modal" tabindex="-1" role="dialog" aria-labelledby="dept-add-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">部门新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal add_dept_form">
                    <div class="form-group">
                        <label for="add_deptName" class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-8">
                            <input type="text" name="deptName" class="form-control" id="add_deptName" placeholder="人事部">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_deptLeader" class="col-sm-2 control-label">部门老大</label>
                        <div class="col-sm-8">
                            <input type="text" name="deptLeader" class="form-control" id="add_deptLeader" placeholder="XXX">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary dept_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    <!-- ==========================部门新增操作=================================== -->
    // 为简单操作，省去了输入名称的验证、错误信息提示等操作
    //1 点击部门新增按钮，弹出模态框；
    //2 输入新增部门信息，点击保存按钮，发送AJAX请求到后台进行保存；
    //3 保存成功跳转最后一页
    $(".dept_add_btn").click(function () {
        $('.dept-add-modal').modal({
            backdrop:static,
            keyboard:true
        });

    });

    $(".dept_save_btn").click(function () {
        var deptName = $("#add_deptName").val();
        var deptLeader = $("#add_deptLeader").val();
        //验证省略...
        $.ajax({
            url:"/hrms/dept/addDept",
            type:"PUT",
            data:$(".add_dept_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("新增成功");
                    $('.dept-add-modal').modal("hide");
                    $.ajax({
                        url:"/hrms/dept/getTotalPages",
                        type:"GET",
                        success:function (result) {
                            if (result.code == 100){
                                var totalPage = result.extendInfo.totalPages;
                                window.location.href="/hrms/dept/getDeptList?pageNo="+totalPage;
                            }
                        }
                    });
                }else {
                    alert(result.extendInfo.add_dept_error);
                }
            }
        });



    });



</script>
</body>
</html>
