<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null ) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	// 데이터 수집
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		
	// 디버깅 코드
	System.out.println(qnaNo + " < -- qnaNo");
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteNotice(qnaNo);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>