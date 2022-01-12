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

	// 데이터 수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
	// 디버깅 코드
	System.out.println(noticeNo + " < -- noticeNo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<h1>공지 사항</h1>
		<!-- end : sub menu include -->
		
		<!-- 공지사항 상세보기 폼 -->
	<%
		NoticeDao noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(noticeNo);
	%>
		<p></p>
		<hr color = "white">
		<h6><%=notice.getNoticeTitle()%></h6>
		<hr color = "white">
		<div style="font-size: 20px;"><%=notice.getNoticeContent()%></div>
		<br><div style="text-align: right;">작성 날짜 : <%=notice.getCreateDate()%></div><br>
		<div>
<%		
		if(loginMember == null) {
%>			
			<a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectNoticeList.jsp">목록</a>
<%			
		}  else if(loginMember.getMemberLevel() < 1) {
%>		
			<a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectNoticeList.jsp">목록</a>
<%			
		} else if(loginMember.getMemberLevel() >= 1) {
%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">수정</a>
			<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>">삭제</a>
			<p></p><div><a class="btn btn-outline-success" href="<%=request.getContextPath() %>/selectQnaList.jsp">목록</a></div>
<%
		}
%>
		</div>
	</div>
</body>
</html>