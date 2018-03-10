package com.hrms.bean;

/**
 * @author GenshenWang.nomico
 * @date 2018/3/5.
 */
public class Department {
    private Integer deptId;
    private String deptLeader;
    private String deptName;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptLeader() {
        return deptLeader;
    }

    public void setDeptLeader(String deptLeader) {
        this.deptLeader = deptLeader;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Department() {
    }

    public Department(Integer deptId, String deptLeader, String deptName) {
        this.deptId = deptId;
        this.deptLeader = deptLeader;
        this.deptName = deptName;
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptLeader='" + deptLeader + '\'' +
                ", deptName='" + deptName + '\'' +
                '}';
    }
}
