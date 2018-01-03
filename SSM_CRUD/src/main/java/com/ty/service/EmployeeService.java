package com.ty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ty.dao.EmployeeMapper;
import com.ty.entity.Employee;
import com.ty.entity.EmployeeExample;
import com.ty.entity.EmployeeExample.Criteria;

@Service
@Transactional
public class EmployeeService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	public List<Employee> findAllEmps() throws InterruptedException{
		System.out.println("进入到service页面");
		//----------没有条件就是查询的所有员工----------
		List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
		return employees;
	}

	public void savaEmp(Employee employee) {
		System.out.println("进入到保存页面");
		//员工的id是自增的所以用此方法
		employeeMapper.insertSelective(employee);
	}

	public boolean cheackUserName(String empName) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		//如果名字不重复则返回0，如果名字重复则不等于0 
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);
		//如果count=0说明名字可用，不可用为不等于0
		return count==0;
	}

	public Employee findOneEmpById(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	public void updateEmp(Employee employee) {
		//因为对象传过来不更新名字，所以不用更新名字，就是有选择的
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria =  employeeExample.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(employeeExample);
	}

}
