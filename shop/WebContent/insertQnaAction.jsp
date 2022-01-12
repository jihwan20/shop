<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertQnaAction</title>
</head>
<body>
<% 
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null ) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// Qna 값이 null 이면 폼으로 다시 이동
	if(request.getParameter("qnaCategory") == null || request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null || 
		request.getParameter("qnaSecret") == null || request.getParameter("memberNo") == null ) {
		response.sendRedirect(request.getContextPath()+"/insertQnaForm.jsp");
		return;
	}
	// QnA 값이 공백 이면 폼으로 다시 이동
	if(request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent").equals("") || 
			request.getParameter("qnaSecret").equals("") || request.getParameter("memberNo").equals("") ) {
		response.sendRedirect(request.getContextPath()+"/insertQnaForm.jsp");
		return;
	}
	
	// 데이터 수집
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println(qnaCategory + " <-- qnaCategory");
	System.out.println(qnaTitle + " <-- qnaTitle");
	System.out.println(qnaContent + " <-- qnaCotent");
	System.out.println( qnaSecret + " <--  qnaSecret");
	System.out.println(memberNo + " <-- memberNo");
	
	// 데이터 가져오기
	Qna qna = new Qna();
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	qna.setMemberNo(memberNo);
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.insertQna(qna);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
	
%>
</body>
</html>