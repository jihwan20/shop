<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 삭제</title>
</head>
<body>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");	
	
	//데이터 수집
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println("memberNo"+ memberNo);
	
	// 데이터 불러오기
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByAdmin(memberNo);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>
</body>
</html>