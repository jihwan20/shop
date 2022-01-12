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
	
	// 데이터 수집
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String qnaCommentContent = request.getParameter("qnaCommentContent");
	
		
	// 디버깅 코드
	System.out.println(qnaNo + " < -- qnaNo");
	System.out.println(memberNo + " < -- memberNo");
	System.out.println(qnaCommentContent + " < -- qnaCommentContent");
	
	// QnA 데이터 값 생성
	QnaComment qnaComment = new QnaComment();
	qnaComment.setQnaNo(qnaNo);
	qnaComment.setMemberNo(memberNo);
	qnaComment.setQnaCommentContent(qnaCommentContent);
	
	QnaCommentDao qnacommentDao = new QnaCommentDao();
	qnacommentDao.insertCommentDao(qnaComment);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaOne.jsp?qnaNo="+qnaNo);
	
%>