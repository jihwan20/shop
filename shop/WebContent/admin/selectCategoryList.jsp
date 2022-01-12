<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 인증 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 카테고리Dao 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectCategoryList.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
		<h1>전자책 카테고리 관리</h1>
		<table class="table table-dark table-striped" border="1" style="margin:auto">
			<thead>
				<tr>
					<th>카테고리 이름</th>
					<th>수정 날짜</th>
					<th>생성 날짜</th>
					<th>사용 유/무</th>
					<th>상태 수정</th>
				</tr>
			</thead>
			<tbody>
<% 
				for(Category c : categoryList) {
%>
					<tr>
						<td><%=c.getCategoryName()%></td>
						<td><%=c.getUpdateDate()%></td>
						<td><%=c.getCreateDate()%></td>
						<td>
<%
	                        if(c.getCategoryState().equals("Y")) {
%>
	                           <span>사용</span>
<%      
	                        } else if(c.getCategoryState().equals("N")) {
%>
	                           <span>미사용</span>
<%      
	                        }
%>
						</td>
						<td><a href="<%=request.getContextPath() %>/admin/updateCategoryStateAction.jsp?categoryName=<%=c.getCategoryName() %>&categoryState=<%=c.getCategoryState() %>" class="btn btn-outline-success">상태 수정</a></td>
<%
				}
			
%>								
			</tbody>
		</table>
		<br><a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
	</div>	
</body>
</html>