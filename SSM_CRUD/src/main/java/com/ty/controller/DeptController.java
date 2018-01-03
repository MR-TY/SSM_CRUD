package com.ty.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ty.entity.Department;
import com.ty.entity.Msg;
import com.ty.service.DeptService;
/**
* @Description: ajax发送请求，通过，后端采集所有的部门对象，并且以json的对象返回，bootstrap用js对json数据进行解析
* @ClassName: DeptController.java
* @version: v1.0.0
* @author: 
* @date: 2018年1月3日 上午11:31:30
 */
@Controller
public class DeptController {
	@Autowired
	private DeptService deptService;

	@RequestMapping("depts")
	@ResponseBody
	public Msg getEmpsWithJson() throws InterruptedException {
		System.out.println("进入部门查询了");
		List<Department> departments = deptService.findAllDepts();
		return Msg.success().returnJson("dept", departments);
	}
}
