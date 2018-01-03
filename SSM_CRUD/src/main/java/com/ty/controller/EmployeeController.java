package com.ty.controller;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.method;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.filter.HttpPutFormContentFilter;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ty.entity.Employee;
import com.ty.entity.Msg;
import com.ty.service.EmployeeService;
/**
* @Description: SSM的高级整合，结合bootstrap对员工的增、删、改、查操作
* @ClassName: EmployeeController.java
* @version: v1.0.0
* @author: 唐宇
* @date: 2018年1月3日 上午11:21:49
 */
@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	* @Function: EmployeeController.java
	* @Description: 员工的增加操作
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	* @version: v1.0.0
	* @author: 唐宇
	* @date: 2018年1月3日 上午11:23:52 
	* Modification History:
	 */
	@RequestMapping("/emps")
	@ResponseBody//ajax发送请求，@ResponseBody：返回的是json格式的对象
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) throws InterruptedException{
		Thread.sleep(800);//Thread.sleep(800)：加载动态图延时一会儿效果更加好
		PageHelper.startPage(pn, 5);//PageHelper的分页，pn：显示第几页，一页显示几个对象
		List<Employee> employees = employeeService.findAllEmps();//采集所有的员工对象
		PageInfo<Employee> pageInfo = new PageInfo<>(employees, 5);//封装到PageInfo中，第二个参数：5表示连续显示多少页
		return Msg.success().returnJson("pageInfo", pageInfo);//Msg很重要，这是返回json的成功还是失败的信息，并且还能将json的数据返回到前端
	}
	/**
	* @Function: EmployeeController.java
	* @Description: 保存员工
	* 1.支持JSR303校验
	* 2.导入包：Hibernate-Validator、
	* 3.@Valid：对穿过来的数据进行校验
	* 4.BindingResult封装校验的结果
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	 */
	@RequestMapping(value="/addOneEmp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveOneEmp(@Valid Employee employee,BindingResult result){
		//校验失败，应该返回模态框中，显示校验失败的错误信息,如果有错误，则返回true
		if (result.hasErrors()) {
			//1.提取校验错误的信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError:errors){
				System.out.println("错误的字段："+fieldError.getField());
				System.out.println("错误的信息："+fieldError.getDefaultMessage());
				//把错误字段对应的错误信息放进域对象中
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.failture().returnJson("errorFiles", map);
		}else {
			employeeService.savaEmp(employee);
			return Msg.success();
		}
	}
	/**
	* @Function: EmployeeController.java
	* @Description: 进行用户名是否可用之前，因该判断用户名的格式是否正确
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	* @version: v1.0.0
	* @author: water
	* @date: 2018年1月3日 上午11:35:13 
	* Modification History:
	 */
	@RequestMapping("/cheackUser")
	@ResponseBody
	public Msg cheackUser(@RequestParam("empName")String empName){
		System.out.println("Employee Name:"+empName);
		//后端采集到名字先进行正则表达式判断名字是否符合规约，符合之后才判断是否可用
		String validString = "(^[a-zA-Z0-9_-]{2,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!(empName.matches(validString))) {
			return Msg.failture().returnJson("val_msg", "用户名可以是2-5位中文或者2-16位英文和数字的组合");
		}
		boolean flag = employeeService.cheackUserName(empName);
		if (flag) {
			//通过查询状态码就知道名字是否可用
			return Msg.success();
		}else {
			return Msg.failture().returnJson("val_msg", "用户名不可用");
		}
	}
	
	/**
	* @Function: EmployeeController.java
	* @Description: 通过id查找一个员工，并进行回显
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	* @version: v1.0.0
	* @author: 唐宇
	* @date: 2018年1月3日 上午11:38:27 
	* Modification History:
	 */
	@RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		System.out.println("--------------id:"+id);
		Employee employee = employeeService.findOneEmpById(id);
		return Msg.success().returnJson("emp", employee);
	}
	
	/**
	* @Function: EmployeeController.java
	* @Description: 修改员工
	*	1.如果直接放送ajax的PUT请求
	*		问题：是请求体中有数据，但是employee拼装不上，所以采集的员工属性都为空
	*		原因：Tomacat：它将请求体中的数据，封装一个map，
	*		请求就会从map中取值，并且这个map中默认是只接收POST请求
	*		解决：配置HttpPutFormContentFilter过滤器，它的作用是解析数据包装成map,
	*		这样就能从请求体中重新取出数据；这样就能直接发送PUT请求，后端就能接收到对象的属性
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	* @version: v1.0.0
	* @author: 唐宇
	* @date: 2018年1月3日 上午11:39:14 
	* Modification History:
	 */
	@RequestMapping(value = "/saveEmp/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		System.out.println("employee-----------"+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}

	/**
	* @Function: EmployeeController.java
	* @Description: 根据字符串中是否包含:"-"判断是进行单向删除还是多项删除
	* @param:描述1描述
	* @return：返回结果描述
	* @throws：异常描述
	* @version: v1.0.0
	* @author: 唐宇
	* @date: 2018年1月3日 下午12:27:33 
	* Modification History:
	 */
	@RequestMapping(value = "/deleteEmp/{ids}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids){
		if (ids.contains("-")) {
			List<Integer> ids_del = new ArrayList<Integer>();
			String[] id = ids.split("-");
			for (String string : id) {
				ids_del.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(ids_del);
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
}
