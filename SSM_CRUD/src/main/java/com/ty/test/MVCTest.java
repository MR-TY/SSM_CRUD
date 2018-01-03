package com.ty.test;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ty.entity.Employee;
/**
 * 
* Copyright: Copyright (c) 2018 LanRu-Caifu
* 
* @ClassName: MVCTest.java
* @Description: 模拟springMVC的功能
*
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
	//传入springmvc的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc的请求
	MockMvc mockMvc;
	//创建MockMvc
	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	//编写测试分页的方法
	@Test
	public void testPagerHelper() throws Exception{
		//模拟发送请求,发送请求的地址和参数方法如下,并且拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps")
				.param("pn", "1")).andReturn();
		//如果发送成功，并且成功接收了请求，就能拿到pageInfo的参数
		MockHttpServletRequest request = result.getRequest();
		//由于pageinfo封装后的数据是放在"pageInfo"中，所以这样就能获取pageinfo封装后的数据
		PageInfo attribute = (PageInfo) request.getAttribute("pageInfo"); 
		System.out.println("当前的页码："+attribute.getPageNum());
		System.out.println("总页码："+attribute.getPages());
		System.out.println("总记录数："+attribute.getTotal());
		System.out.println("连续显示的页码：");
		int[] pages = attribute.getNavigatepageNums();
		for (int i : pages) {
			System.out.print(" "+i);
		}
		System.out.println();
		//获取员工数据
		List<Employee> employees = attribute.getList();
		for (Employee employee : employees) {
			System.out.println("ID:"+employee.getEmpId()+" "+"NAME:"+employee.getEmpName());
		}
	}
}
