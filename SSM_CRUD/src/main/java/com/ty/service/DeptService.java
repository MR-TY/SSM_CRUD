package com.ty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ty.dao.DepartmentMapper;
import com.ty.entity.Department;

@Service
@Transactional
public class DeptService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> findAllDepts(){
		List<Department> departments = departmentMapper.selectByExample(null);
		return departments;
	}
}
