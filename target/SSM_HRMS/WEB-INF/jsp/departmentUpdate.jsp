<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门更改页面</title>
</head>
<body>
<div class="modal fade dept-update-modal" tabindex="-1" role="dialog" aria-labelledby="dept-update-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">部门更改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal update_dept_form">
                    <div class="form-group">
                        <label for="update_deptName" class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-8">
                            <input type="text" name="deptName" class="form-control" id="update_deptName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_deptLeader" class="col-sm-2 control-label">部门老大</label>
                        <div class="col-sm-8">
                            <input type="text" name="deptLeader" class="form-control" id="update_deptLeader">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary dept_update_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    <!-- ==========================部门新增操作=================================== -->
    //1 点击编辑按钮，发送AJAX请求查询对应id的部门信息，进行回显；
    //2 进行修改，点击更新按钮发送AJAX请求，将更改后的信息保存到数据库中；
    //3 跳转到当前更改页；
    var edit_deptId = 0;
    var curPageNo = ${curPageNo};

    $(".dept_edit_btn").click(function () {
        edit_deptId = $(this).parent().parent().find("td:eq(0)").text();
        alert("id"+edit_deptId);
        //查询对应deptId的部门信息
        $.ajax({
            url:"/hrms/dept/getDeptById/"+edit_deptId,
            type:"GET",
            success:function (result) {
                if (result.code == 100){
                    var deptData = result.extendInfo.department;
                    //回显
                    $("#update_deptName").val(deptData.deptName);
                    $("#update_deptLeader").val(deptData.deptLeader);
                }else {
                    alert(result.extendInfo.get_dept_error);
                }
            }
        });
    });

    $(".dept_update_btn").click(function () {
        $.ajax({
            url:"/hrms/dept/updateDept/"+edit_deptId,
            type:"PUT",
            data:$(".update_dept_form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    alert("更新成功！");
                    window.location.href = "/hrms/dept/getDeptList?pageNo="+curPageNo;
                } else {
                    alert(result.extendInfo.update_dept_error);
                }
            }

        });
    });


</script>
</body>
</html>
