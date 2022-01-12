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
<title>updateCategoryStateAction.jsp</title>
</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//데이터 수집
	String categoryName = request.getParameter("categoryName");
	String categoryState = request.getParameter("categoryState");
	
	// 디버깅 코드
	System.out.println(categoryName+" <-- categoryName");
	System.out.println(categoryState+" <-- categoryState");
	
	// 카테고리 값 변환
	if (categoryState.equals("Y")) {
		categoryState = "N";
	} else if (categoryState.equals("N")) {
		categoryState = "Y";
	};
	
	// 데이터 가져오기
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	
	category.setCategoryName(categoryName);
	category.setCategoryState(categoryState);
	categoryDao.updateCategoryState(category);
	
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>
</body>
</html>