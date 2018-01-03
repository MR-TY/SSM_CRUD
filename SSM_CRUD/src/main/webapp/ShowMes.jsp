<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
		总体思路：把页面分成四部分，然后对每一部分填充内容
  -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工的数据显示</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
	不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
	以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
	http://localhost:3306/crud
	 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery.blockUI.js"></script>
</head>
<body>

	<!-- 更新员工弹出来的模态框 -->
	<div class="modal fade" id="UpdateOneEmp" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>

				<div class="modal-body">
					<!--填写信息的表单  -->
					<form class="form-horizontal" id="empUpdate">

						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<!-- <input type="text" name="empName" class="form-control"
									id="empName_update_input"> -->
								<p class="form-control-static" id="empName_update_static"></p>
								<!--错误信息的内容放置  -->
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input">
								<!--错误信息的内容放置  -->
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio1" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio2" value="m"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门的ID进行提交  -->
								<select class="form-control" name="dId" id="updateOneDept">
								</select>
							</div>
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 添加员工弹出来的模态框 -->
	<div class="modal fade" id="AddOneEmp" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>

				<div class="modal-body">
					<!--填写信息的表单  -->
					<form class="form-horizontal" id="empAdd">

						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
								<!--错误信息的内容放置  -->
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="465171730@qq.com">
								<!--错误信息的内容放置  -->
								<span class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio1" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio2" value="m"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门的ID进行提交  -->
								<select class="form-control" name="dId" id="sOneDept">
								</select>
							</div>
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
				</div>
			</div>
		</div>
	</div>

	<div class="container">

		<!--把页面分成4行  -->
		<!--第一部分：标题行  -->
		<div class="row">
			<div class="col-md-12">
				<h1>Mr_Ty_SSM_CRUD</h1>
			</div>
		</div>

		<!--第二部分：按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<!--新增一个员工  -->
				<button class="btn btn-primary" id="emp_add_model"
					data-target="#myModal">新增</button>

				<!--删除员工  -->
				<button class="btn btn-danger" id="emp_delete_all">删除</button>
			</div>
		</div>

		<!--第三部分：表格数据  -->
		<div class="row">
			<table class="table table-striped table-hover" id="emps_table">
				<thead>
					<tr class="info">
						<th><input type="checkbox" id="check_all" /></th>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					</tr>
				</tbody>
			</table>
		</div>

		<!--第四部分：分页  -->
		<div class="row">
			<div class="col-md-6" id="page_info"></div>
			<div class="col-md-6 col-md-offset-9" id="page"></div>
		</div>
	</div>

	<!-- 引入 blockUI 需要的 gif -->
	<img id="loading" alt="" src="${APP_PATH}/static/img/1111.GIF"
		style="display: none" />

	<script type="text/javascript">
		var totalRecord;//显示总记录数，只要显示最后一页
		var currentPage;//显示当前的页面
		$(function() {
			//使用默认的BlockUI设置（专门用来对发送ajax请求和接收ajax响应进行页面处理）
			//$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
			//自定义具体的blockUI使用
			$(document).ajaxStart(function() {
				$.blockUI({
					message : $("#loading"),
					css : {
						top : ($(window).height() - 400) / 2 + 'px',
						left : ($(window).width() - 400) / 2 + 'px',
						width : '400px',
						border : 'none'
					},
					overlayCSS : {
						backgroundColor : 'white'
					}
				})
			}).ajaxStop($.unblockUI);
			// 通过 ajax 获取后台的分页数据
			to_page(1);
		});
		
//--------------------------------------分页显示------------------------------------------		
		//ajax发送的页面请求
		function to_page(pn) {
			$.ajax({

				url : "${APP_PATH }/emps",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					console.log(result);
					//解析并显示员工的数据
					build_emps(result);
					//解析显示分页的信息
					build_mes(result);
					//解析显示分页条的信息
					build_tiao(result);
				}
			});
		}

		//显示数据：解析json格式的数据
		function build_emps(result) {
			$("#emps_table tbody").empty();
			//获取返回json格式的数据
			var emps = result.map.pageInfo.list;
			//相当于遍历数组，返回回调函数，index：指标。item:每次遍历后的一个对象
			$.each(emps,function(index, item) {
					var checkBoxId = $("<td> <input type='checkbox' class='check_item'/></td>");
					var empId = $("<td></td>").append(item.empId);
					var empName = $("<td></td>").append(
							item.empName);
					var gender1 = item.gender == "M" ? "男" : "女";
					var gender = $("<td></td>").append(gender1);
					var email = $("<td></td>").append(item.email);
					var deptName = $("<td></td>").append(
							item.department.deptName);
	
					//编辑按钮
					/**
						<button class="btn btn-primary btn-sm">
									<span aria-hidden="true" class="glyphicon glyphicon-pencil"></span>编辑
								</button>
					 */
					var edit = $("<button></button>").addClass(
							"btn btn-primary btn-sm edit_btn")
							.append($("<span></span>")).addClass(
									"glyphicon glyphicon-pencil")
							.append("编辑");
	
					//为编辑按钮添加自定义的属性，方便别人获取id值
					edit.attr("edit_id", item.empId);
	
					//删除按钮
					/**
						<button class="btn btn-danger btn-sm">
										<span aria-hidden="true" class="glyphicon glyphicon-trash"></span>删除
									</button>
					 */
					/*添加按钮的class标识：delete_btn  */
					var delete1 = $("<button></button>").addClass(
							"btn btn-danger btn-sm delete_btn")
							.append("<span></span>").addClass(
									"glyphicon glyphicon-trash")
							.append("删除");
	
					//两个按钮放在一个单元格里面
					var btn = $("<td></td>").append(edit).append(
							" ").append(delete1);
					
					//给tr添加需要显示的子元素
					$("<tr></tr>").append(checkBoxId).append(empId)
							.append(empName).append(gender).append(
									email).append(deptName).append(
									btn).appendTo(
									"#emps_table tbody");
					
					delete1.attr("delete_id", item.empId);
	
				});
		}

		//解析显示分页信息
		function build_mes(result) {
			$("#page_info").empty();
			var pageInfo = result.map.pageInfo;
			$("#page_info").append(
					"当前第 " + pageInfo.pageNum + " 页 总共  " + pageInfo.pages
							+ " 页 总共 " + pageInfo.total + " 记录")
			totalRecord = pageInfo.total;
			currentPage = pageInfo.pageNum;
		}

		//解析显示分页条,点击需要执行
		function build_tiao(result) {
			$("#page").empty();
			var pageInfo = result.map.pageInfo;
			//创建ul
			var ul = $("<ul></ul>").addClass("pagination");
			//向左翻页和跳转到第一页
			var firstPage = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var leftPage = $("<li></li>")
					.append($("<a></a>").append("&laquo;"));
			//判断是否有上一页，如果没有就禁用按键
			if (pageInfo.hasPreviousPage == false) {
				firstPage.addClass("disabled");
				leftPage.addClass("disabled");
			} else {
				//首页和向左翻页添加点击事件
				firstPage.click(function() {
					to_page(1);
				});
				leftPage.click(function() {
					to_page(pageInfo.pageNum - 1);
				});
			}

			//向右翻页，跳转到最后一页
			var rightPage = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var endfirstPage = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			//判断是否有下一页，如果没有就禁用按键
			if (pageInfo.hasNextPage == false) {
				//如果没有下一页就显示禁止的符号，并且不会发送ajax的请求
				rightPage.addClass("disabled");
				endfirstPage.addClass("disabled");
			} else {
				//末页和向右翻页添加点击事件
				endfirstPage.click(function() {
					to_page(pageInfo.pages);
				});

				rightPage.click(function() {
					to_page(pageInfo.pageNum + 1);
				});
			}
			ul.append(firstPage).append(leftPage);

			//遍历连续显示的页
			$.each(pageInfo.navigatepageNums, function(index, item) {
				var numVal = $("<li></li>").append($("<a></a>").append(item));
				if (pageInfo.pageNum == item) {
					numVal.addClass("active");
				}
				numVal.click(function() {
					to_page(item);
				});
				ul.append(numVal);
			});

			//ul中添加li的内容
			ul.append(rightPage).append(endfirstPage);
			//把ul加入到nav原素中
			var nav = $("<nav></nav>").append(ul);
			//把导航条添加到要显示的div中
			nav.appendTo("#page");
		}

		//进行表单的清空
		function reset_form(ele) {
			//使每一次添加时框内的数据为空就行：表单重置
			$(ele)[0].reset();
			//清空表单的样式:表单下的所有元素，都进行清空
			$(ele).find("*").removeClass("has-error has-success");
			//清空辅助元素
			$(ele).find(".help-block").text("");
		}
		
//-------------------------------------添加员工-------------------------------------------
		/*员工添加的模态框绑定事件  */
		$("#emp_add_model").click(function() {
			/* 
				对于用户名验证的时候，如果第一次验证成功之后，
				第二次打开的数据与刚才的数据相同但是也能进行保存 ，
				是因为第一次验证的数据已经成功，就不会在发送ajax请求
				所以，使每一次添加时框内的数据为空就行：表单重置
			 */
			//进行表单完整重置
			reset_form("#AddOneEmp form");
			//$("#AddOneEmp form")[0].reset();
			//弹出框之前，发送ajax请求，查出部门的信息
			getDept("#sOneDept");
			//弹出模态框
			$("#AddOneEmp").modal({
				/*点击背景也不会消失  */
				backdrop : "static"
			});
		});

		/*对部门的ajax请求  */
		function getDept(ele) {
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "get",
				success : function(result) {
					console.log(result);
					selectOneDept(result, ele);
				}
			});
		}

		/*添加部门的信息到选择框中  select class="form-control" */
		function selectOneDept(result, ele) {
			//进来一次就要做一次清空，不然就会一直连接下去，这样显示的内容就会发生重复
			$(ele).empty();
			var depts = result.map.dept;
			$.each(depts, function(index, item) {
				var option = $("<option></option>").append(item.deptName).attr(
						"value", item.deptId);
				option.appendTo(ele);
			});
		}

		/*
			员工的保存单击事件:这里保存也能进行后端的判断JSR303：
			这样的好处是当前端被破坏之后，后端也能进行判断 
		 */
		$("#emp_save_btn").click(function() {
						//1.点击之后将模态框中的数据提交给后台
						//2.先对要提交的数据进行格式校验，如果反会的是false就结束了
						if (!validate_add_form()) {
							//校验没有成功结束方法
							return false;
						}
						//对于用户名可用或者不可用需要在这里进行校验，如果不可用就不发送ajax请求，可用才能发送ajax请求
						//拿到当前按钮的属性值，判断是成功还是失败
						if ($(this).attr("ajax_btn") == "error") {
							return false;
						}
						//3.发送ajax请求保存员工
						//4.利用此方法能获取div下输入框中的内容：$("#empAdd").serialize()
			$.ajax({
						url : "${APP_PATH}/addOneEmp",
						type : "POST",
						data : $("#empAdd").serialize(),
						success : function(result) {
							console.log(result);
							//成功才会关闭模态框
							if (result.code == 100) {
								//1.保存成功就关闭模态框
								$("#AddOneEmp").modal('hide');
								//2.来到最后一页,发送ajax请求显示最后一页数据
								to_page(totalRecord);
							} else {
								//显示失败的信息
								console.log(result);
								//有哪个字段的错误信息，就显示哪个字段的错误信息
								if (result.map.errorFiles.email != undefined) {
									//显示邮箱的错误信息
									show_validate(
											"#email_add_input",
											"error",
											result.map.errorFiles.email);
								}
								if (result.map.errorFiles.empName != undefined) {
									//显示员工名字的错误信息
									show_validate(
											"#empName_add_input",
											"error",
											result.map.errorFiles.empName);
								}
							}

						}
					});
		});

		//当员工的输入框发生改变,校验用户名是否重复
		$("#empName_add_input").change(
				function() {
					//发送ajax请求，进行名字是否重复校验
					var empName = this.value;//empName就是输入框的内容值
					$.ajax({
						url : "${APP_PATH}/cheackUser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {

							if (result.code == 100) {
								show_validate("#empName_add_input", "success",
										"用户名可用");
								//给保存的按钮添加值
								$("#emp_save_btn").attr("ajax_btn", "success");
							} else {
								show_validate("#empName_add_input", "error",
										result.map.val_msg);
								$("#emp_save_btn").attr("ajax_btn", "error");
							}
						}
					});
				});

		//校验增加员工的表单数据
		function validate_add_form() {
			//1、拿到要校验的数据，使用正则表达式
			/* 	var empName = $("#empName_add_input").val();
				var regName = /(^[a-zA-Z0-9_-]{2,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				if(!regName.test(empName)){
					//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
					show_validate("#empName_add_input", "error", "用户名可以是2-5位中文或者2-16位英文和数字的组合");
					return false;
				}else{
					show_validate("#empName_add_input", "success", "");
				}; */

			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				//应该清空这个元素之前的样式
				show_validate("#email_add_input", "error", "邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			} else {
				show_validate("#email_add_input", "success", "");
			}
			return true;
		}

		//提取显示的信息
		function show_validate(ele, status, msg) {
			//每次进来的时候清除之前的zhuangt
			$(ele).parent().removeClass("has-error has-success");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				//设置span元素下面的提示信息
				$(ele).next("span").text(msg);
			}
		}

		//给更新绑定点击事件：我们是在按钮创建之前绑定事件，所以采集的id是没有效果的，所以此时一般的绑定是不行的
		//解决办法：用.live方法：jQuery的新版本是把.live方法给删除的，所以使用on方法进行替代
		$(document).on("click", ".edit_btn", function() {
			//1.查出员工信息
			getEmpById($(this).attr("edit_id"));
			//2.点编辑查出部门的信息，显示部门的列表
			getDept("#updateOneDept");

			//3.让更新按钮获取的ID值，等于更新模态框打开时获取的id值
			$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));

			//弹出模态框
			$("#UpdateOneEmp").modal({
				/*点击背景也不会消失  */
				backdrop : "static"
			});
		});

		//利用ajax查出员工的信息
		function getEmpById(id) {
			$.ajax({
				url : "${APP_PATH}/getEmp/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					//获取员工的数据
					var employee = result.map.emp;
					$("#empName_update_static").text(employee.empName);
					$("#email_update_input").val(employee.email);
					$("#UpdateOneEmp input[name=gender]").val(
							[ employee.gender ]);
					$("#UpdateOneEmp select").val([ employee.dId ]);
				}
			});
		}

//-----------------------------------------更新员工---------------------------------------
		//更新按钮绑定更新的事件
		$("#emp_update_btn").click(function() {
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate("#email_update_input", "success", "");
			}
			$.ajax({
				url : "${APP_PATH}/saveEmp/" + $(this).attr("edit_id"),
				/*通过put通过的过滤器就能直接写PUT请求后端就能结接收  */
				type : "PUT",
				data : $("#UpdateOneEmp form").serialize(),
				/* 
					type : "POST",
					$("#UpdateOneEmp form").serialize():获取更新列表序列化的数据
					data : $("#UpdateOneEmp form").serialize()+"&_method=PUT", 
				 */
				success : function(result) {
					//更新成功之后就隐藏模态框
					$("#UpdateOneEmp").modal("hide");
					//并且跳转到当前的页面
					to_page(currentPage);
				}
			});
		});

//---------------------------------点击单个删除--------------------------------------------
	
		//因为是按钮创建之前就绑定了click所以需要on来绑定
		$(document).on("click", ".delete_btn", function() {
			//1.弹出确认删除框,找出td:eq(1)：td的第二元素，它的文本值就是我们需要用的值
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var name = $(this).parents("tr").find("td:eq(2)").text();
			//打开模态框的时候获取id的值
			var id = $(this).attr("delete_id");
			//确认是否删除，如果确认返回true，否则返回false
			if (confirm("确认删除【" + name + "】吗？")) {
				//点击true之后发送ajax请求
				$.ajax({
					url : "${APP_PATH}/deleteEmp/" + id,
					type : "delete",
					success : function(result) {
						to_page(currentPage);
					}
				});
			}
		});
//------------------------------------多个删除员工-----------------------------------------
		//完成全选，全不选
		$("#check_all").click(function() {
			//attr获取自定义属性的值
			//prop获取不是自定义属性的值，用于修改和读取dom原生属性的值
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//单选框的点击事件
		$(document).on("click",".check_item",function() {
							//判断单选框的个数，是否是一页的总个数
							var flag = $(".check_item:checked").length == $(".check_item").length;
							//如果全选满了flag=true
							$("#check_all").prop("checked", flag);
						});

		//进行多个删除
		$("#emp_delete_all").click(function(){
					var empNames = "";
					var id_strings = "";
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find(
								"td:eq(2)").text()+ ",";
						//组装员工id的字符串
						id_strings += $(this).parents("tr").find(
								"td:eq(1)").text()	+ "-";
					});
					
					empNames = empNames.substring(0,empNames.length - 1);
					//去掉ids中最后一个横杠
					id_strings = id_strings.substring(0,
							id_strings.length - 1);
					//去除emps多余的逗号
					if (confirm("确认删除【" + empNames + "】吗？")) {
						$.ajax({
								url : "${APP_PATH}/deleteEmp/"
										+ id_strings,
								type : "DELETE",
								success : function(result) {
									alert(result.msg);
									to_page(currentPage);
								}
							});
					  }
				});
	</script>
</body>
</html>