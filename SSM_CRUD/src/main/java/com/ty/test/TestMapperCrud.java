package com.ty.test;
import static org.hamcrest.CoreMatchers.nullValue;
import static org.junit.Assert.*;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.ty.dao.DepartmentMapper;
import com.ty.dao.EmployeeMapper;
import com.ty.entity.Department;
import com.ty.entity.Employee;
/**
 * 测试dao层
* @ClassName: TestMapperCrud.java
* @Description: 单元测试
*
* @version: v1.0.0
* @author: water
* @date: 2018年1月4日 下午10:33:45 
* 1.导入SpringTest的测试模块
* 2.@ContextConfiguration指定配置文件的位置
* 3.直接autowired
* 4.生成有参构造器，一定要生成无参构造器
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class TestMapperCrud {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	private SqlSession sqlSession;//能批量生产的sqlsession 
	//测试dept的mapper
	@Test
	public void testCRUD() {
		/*ctrl+shift+f进入了繁体字
		 * 這是原生的測試方法，現在有spring，就可以使用注入的方式获取对象
		 // 1.創建IOC容器
		ApplicationContext IOC = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.從IOC容器取出mapper
		DepartmentMapper departmentMapper = IOC.getBean(DepartmentMapper.class);*/
//		System.out.println("departmentMapper"+departmentMapper);
//		//插入几个部门
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
//		departmentMapper.insertSelective(new Department(null,"人事部"));
		
		//插入几个员工
//		employeeMapper.insertSelective(new Employee(null, "唐宇", "M", "465141730@qq.com", 1));
//		employeeMapper.insertSelective(new Employee(null, "唐哈哈", "M", "465141730@qq.com", 2));
		
		//批量的sqlSession插入
		EmployeeMapper employeeMapper1 = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 500; i < 1000; i++) {
//			String uString = UUID.randomUUID().toString().substring(0, 5)+i;
//			employeeMapper1.insertSelective(new Employee(null,uString,"m", uString+"@4651", 1));
			employeeMapper1.deleteByPrimaryKey(i);
		}
	}
}
