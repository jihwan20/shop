<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 최근 공지사항 5개 가져오기
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNewEbookList();
	
	// 답글이 달리지 않은 QnA
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectNoCommentQnaList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- 관리자 메뉴 include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
	<!-- 관리자 메뉴 end -->
	<div>
	<h1>관리자 페이지</h1>
	<div class="text-white"><%=loginMember.getMemberId()%>님 반갑습니다.</div><br>
	
	<h2>공지 사항</h2>
		<table border="1" class="table table-dark table-striped"  style="margin:auto">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성 날짜</th>
				</tr>		
			</thead>
			<tbody>
<%
				for(Notice n : noticeList) {
%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
						<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getCreateDate() %></td>
<%
				}
%>
			</tbody>
		</table>
		<p></p>
		<div><a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지사항 추가</a></div>
		<p></p>
	<h2>답글이 달리지 않은 QnA</h2>
		<table border="1" class="table table-dark table-striped"  style="margin:auto">
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>제목</th>
					<th>비밀글</th>
					<th>작성 날짜</th>
				</tr>		
			</thead>
			<tbody>
<%
				for(Qna q : qnaList) {
%>
					<tr>
						<td><%=q.getQnaNo() %></td>
						<td><%=q.getQnaCategory() %></td>
						<td><a href="<%=request.getContextPath() %>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
						<td style="text-align:center;">
							<%
								if(q.getQnaSecret().equals("Y")){
							%>
									<img src="<%=request.getContextPath()%>/image/lock.jpg" width="20" height="20">
							<%
								} else {
							%>
									<img src="<%=request.getContextPath()%>/image/unlock.jpg" width="20" height="20">
							<%
								}
							%>
							</td>
						<td><%=q.getCreateDate() %></td>
<%
				}
%>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>