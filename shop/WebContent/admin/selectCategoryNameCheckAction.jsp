<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");	

	// memberIdCheck 값이 공백인지 아니면 널인지 호출
	if(request.getParameter("categoryNameCheck") == null || request.getParameter("categoryNameCheck").equals("")) {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	// 데이터 수집
	String categoryNameCheck = request.getParameter("categoryNameCheck");
	
	// 디버깅 코드
	System.out.println(categoryNameCheck + " <-- categoryNameCheck");
	
	// MemberDao.selectMemberId() 메서드를 호출
	CategoryDao categoryDao = new CategoryDao();
	String result = categoryDao.SelectCategoryName(categoryNameCheck);

	// 페이지 이동
	// null이 아니면 idCheckResult 값을 출력
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryNameCheck="+categoryNameCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?NameCheckResult=Using!");
	}
	
%>