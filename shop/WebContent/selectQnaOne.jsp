<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	//인증 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 데이터 수집
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		
	// 디버깅 코드
	System.out.println(qnaNo + " < -- qnaNo");
	
	// 댓글 페이징
	int commentcurrentPage = 1;
	
	// 페이지 번호가 null이 아니라면 int 타입으로 바꿔서 페이지 번호 사용
	if(request.getParameter("commentcurrentPage") != null) {
		commentcurrentPage = Integer.parseInt(request.getParameter("commentcurrentPage"));
	}
	
	// 디버깅 코드
	System.out.println(commentcurrentPage +" <-- commentcurrentPage");
	
	final int Comment_ROW_PER_PAGE = 10;
	
	int commentbeginRow = (commentcurrentPage - 1) * Comment_ROW_PER_PAGE;
	
	// QnaDao 가져오기
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : sub menu include -->
		<h1>QnA</h1>
	
<%		
		if(qna.getQnaSecret().equals("Y")){
		if(loginMember == null) {	
%>			
			<div>글을 볼 수 없습니다.</div><br>
			<div><a class="btn btn-outline-primary" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a></div>
<% 
		} else if(loginMember.getMemberNo() == qna.getMemberNo() || loginMember.getMemberLevel() >= 1){
%>
			<!-- 댓글 코딩 -->
			<!-- Q&A 상세보기 폼 -->
			<p></p>
			<hr color = "white">
			<h6><%=qna.getQnaTitle()%></h6>
			<hr color = "white">
			<div style="font-size: 20px;"><%=qna.getQnaContent()%></div>
			<br><div style="text-align: right;">작성 날짜 : <%=qna.getCreateDate()%></div><br>
			<p></p>
			<!--답글 -->
			<div class="container p-3 bg-dark text-white" style="text-align: center;">
			<p></p>
<%		
			if(loginMember != null && loginMember.getMemberLevel() >= 1) {
%>			
			<h5>답변</h5>
				<div>
					<form action="<%=request.getContextPath()%>/admin/insertQnaCommentAction.jsp" method="post">
						<input type="hidden" name="qnaNo" value="<%=qna.getQnaNo()%>">
						<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
						<textarea style="text-align: center;" name="qnaCommentContent" class="form-control" cols="30" rows="3"></textarea><br>
						<button class="btn btn-outline-danger" type="submit">입력</button>
					</form>
					<p></p>
				</div>
<%			
			} else {			
			}
%>
			<h2>답글</h2>
<%
				QnaCommentDao qnacommentDao = new QnaCommentDao();
				ArrayList<QnaComment> qnacommentlist = qnacommentDao.selectQnaCommentList(qnaNo, commentbeginRow, Comment_ROW_PER_PAGE);
%>
			 	<table class="table table-dark table-striped" style="margin:auto;">
<%
					for(QnaComment qc :  qnacommentlist) {
%>				
						<tr>
							<td>관리자 : <%=qc.getMemberNo() %></td>
							<td><%=qc.getQnaCommentContent() %></td>
							<td><%=qc.getCreateDate() %></td>
						</tr>
<%		
					}
%>
				</table>
<%
		} else if(loginMember.getMemberNo() != qna.getMemberNo()) {
%>			
			<div>글을 볼 수 없습니다.</div><br>
<%			
		}
		} else {
%>				
			<!-- Q&A 상세보기 폼 -->
			<p></p>
			<hr color = "white">
			<h6><%=qna.getQnaTitle()%></h6>
			<hr color = "white">
			<div style="font-size: 20px;"><%=qna.getQnaContent()%></div>
			<br><div style="text-align: right;">작성 날짜 : <%=qna.getCreateDate()%></div><br>
			<!--답글 -->
			<div class="container p-3 bg-dark text-white" style="text-align: center;">
			<p></p>
<%		
			if(loginMember != null && loginMember.getMemberLevel() >= 1) {
%>			
				<div>
					<form action="<%=request.getContextPath()%>/admin/insertQnaCommentAction.jsp" method="post">
						<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
						<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
						<div class="text-white">답변</div>
						<textarea style="text-align: center;" name="qnaCommentContent" class="form-control" cols="30" rows="3"></textarea><br>
						<button class="btn btn-outline-danger" type="submit">댓글입력</button>
					</form>
					<p></p>
				</div>
<%			
			} else {			
			}
%>
			<h2>답글</h2>
<%
				QnaCommentDao qnacommentDao = new QnaCommentDao();
				ArrayList<QnaComment> qnacommentlist = qnacommentDao.selectQnaCommentList(qnaNo, commentbeginRow, Comment_ROW_PER_PAGE);
%>
			 	<table class="table table-dark table-striped" style="margin:auto;">
<%
					for(QnaComment qc :  qnacommentlist) {
%>				
						<tr>
							<td>관리자 : <%=qc.getMemberNo() %></td>
							<td><%=qc.getQnaCommentContent() %></td>
							<td><%=qc.getCreateDate() %></td>
						</tr>
<%		
					}
%>
				</table>
<%
		}
%>
		<p></p>
<%			
			if(loginMember == null || loginMember.getMemberLevel() > 0) {
%>				
				<br><div><a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectQnaList.jsp">목록</a></div>
<%			
			} else if(loginMember.getMemberNo() == qna.getMemberNo()){
%>				
				<br><a class="btn btn-outline-success" href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=qnaNo%>">수정</a>
				<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteQnaAction.jsp?qnaNo=<%=qnaNo%>">삭제</a>
				<p></p><div><a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectQnaList.jsp">목록</a></div>
<%				
			} else {
%>				
				<p></p><div><a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectQnaList.jsp">목록</a></div>
<%				
			}
%>
			</div>
		</div>
	</div>
</body>
</html>