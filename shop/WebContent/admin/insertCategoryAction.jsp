<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryAction.jsp</title>
</head>
<body>
<% 
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 카테고리 이름 값이 공백인지 아니면 널인지 호출
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/insertCategoryForm.jsp");
		return;
	}
	
	// 데이터 수집
	String categoryName = request.getParameter("categoryName");
	
	// 디버깅 코드
	System.out.println(categoryName + " <-- categoryName");
	
	// 데이터 가져오기
	Category category = new Category();
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>
</body>
</html>