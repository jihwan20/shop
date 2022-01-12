<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카데고리 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark text-white" style="text-align: center;">
		<h1>카테고리 추가</h1>
<%
			String categoryNameCheck="";
			if(request.getParameter("categoryNameCheck") != null) {
				categoryNameCheck = request.getParameter("categoryNameCheck");
			}
%>
			<form action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp" method="post">
				<div class="text-white">
					카테고리 이름 중복 검사 : 
					<!--처음 이 페이지에 들어오면 null -->
					<!-- 중복 검사 후 들어오면 '사용중인 아이디 입니다' -->
					<%=request.getParameter("NameCheckResult") %>
				</div>
				<div><input type="text" name="categoryNameCheck"></div>
				<button class="btn btn-success" type="submit">카테고리 이름 중복 검사</button>
			</form>
			<br>
			<!-- 카테고리 폼 -->
			<form action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp" method="post" class=".custom-select">
		
				<!-- 카테고리 이름 -->
					<div class="text-white">카테고리 이름 : </div>
					<div class="text-white"><input type="text" name="categoryName" readonly="readonly" value="<%=categoryNameCheck%>"></div>
					<br><button class="btn btn-success" type="submit">추가</button>
			</form>
	</div>	
</body>
</html>