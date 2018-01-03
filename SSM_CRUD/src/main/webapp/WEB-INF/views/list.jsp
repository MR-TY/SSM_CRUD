<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工的数据显示</title>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
%>
<!--
	1.不用斜杠的web资源，找资源以当前的页面为标准
	2.使用以斜线开始找路径以服务器为标准：以此种方式找路径
 -->
<link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="${PATH}/text/javascript" src="static/js/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<!--把页面分成4行  -->
		<!--标题行  -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>
		<!--按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!--表格数据  -->
		<div class="row">
			<table class="table table-striped table-hover">
				<tr class="info">
					<th>ID</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list}" var="employee">
					<tr>
						<td>${employee.empId}</td>
						<td>${employee.empName}</td>
						<td>${employee.gender=="M"?"男":"女"}</td>
						<td>${employee.email}</td>
						<td>${employee.department.deptName}</td>
						<td>
							<button class="btn btn-primary btn-sm">
								<span aria-hidden="true" class="glyphicon glyphicon-pencil"></span>编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span aria-hidden="true" class="glyphicon glyphicon-trash"></span>删除
							</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<!--分页  -->
		<div class="row">
		
			<div class="col-md-6">当前第 ${pageInfo.pageNum } 页 总共
				${pageInfo.pages } 页 总共 ${pageInfo.total } 记录
			</div>

			<div class="col-md-6 col-md-offset-9">
				<nav aria-label="Page navigation">
				<ul class="pagination">

					<!--显示首页  -->
					<li><a href="${PATH}/emps?pn=${1}">首页</a></li>

					<!--当前还有前一页，就减1 -->
					<li><c:if test="${pageInfo.hasPreviousPage}">
							<a href="${PATH}/emps?pn=${pageInfo.pageNum-1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a>
						</c:if> <c:if test="${!pageInfo.hasPreviousPage}">
							<a href="${PATH}/emps?pn=${1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a>
						</c:if></li>

					<!--点击当前前页 -->
					<c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
						<c:if test="${page_num == pageInfo.pageNum}">
							<li class="active"><a href="#">${pageInfo.pageNum}</a></li>
						</c:if>

						<c:if test="${page_num != pageInfo.pageNum}">
							<li><a href="${PATH}/emps?pn=${page_num}">${page_num}</a></li>
						</c:if>
					</c:forEach>

					<!--当前有后一前页就+1 -->
					<c:if test="${pageInfo.hasNextPage}">
						<li><a href="${PATH}/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>

					<!--显示末页  -->
					<li><a href="${PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>

		</div>
	</div>
</body>
</html>