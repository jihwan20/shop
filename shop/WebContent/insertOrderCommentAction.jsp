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
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 데이터 수집
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	String orderCommentContent = request.getParameter("orderCommentContent");
	
	// 디버깅 코드
	System.out.println(orderNo + " <-- orderNo");
	System.out.println(ebookNo + " <-- ebookNo");
	System.out.println(orderScore + " <-- orderScore");
	System.out.println(orderCommentContent + " <-- orderCommentContent");
	
	// 데이터 가져오기
	OrderComment ordercomment = new OrderComment();
	ordercomment.setOrderNo(orderNo);
	ordercomment.setEbookNo(ebookNo);
	ordercomment.setOrderScore(orderScore);
	ordercomment.setOrderCommentContent(orderCommentContent);
	
	OrderCommentDao ordercommentDao = new OrderCommentDao();
	ordercommentDao.insertOrderComment(ordercomment);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
%>