package com.hrms.service;

import com.hrms.bean.Department;
import com.hrms.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author GenshenWang.nomico
 * @date 2018/3/8.
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public int deleteDeptById(Integer deptId){
        return departmentMapper.deleteDeptById(deptId);
    }
    public int updateDeptById(Integer deptId, Department department){
        return departmentMapper.updateDeptById(deptId, department);
    }
    public int addDept(Department department){
        return departmentMapper.insertDept(department);
    }
    public int getDeptCount(){
        return departmentMapper.countDepts();
    }
    public List<Department> getDeptList(Integer offset, Integer limit){
        return departmentMapper.selectDeptsByLimitAndOffset(offset, limit);
    };
    public Department getDeptById(Integer deptId){
        return departmentMapper.selectOneById(deptId);
    }
    public Department getDeptByName(String deptName){
        return departmentMapper.selectOneByName(deptName);
    }


    public List<Department> getDeptName(){
        return departmentMapper.selectDeptList();
    }

}
