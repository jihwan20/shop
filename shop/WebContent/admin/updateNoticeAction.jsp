<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeAction</title>
</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 데이터 수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 디버깅 코드
	System.out.println(noticeNo+" <-- noticeNo");
	System.out.println(noticeTitle+" <-- noticeTitle");
	
	// 데이터 가져오기
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// NoticeDao 불러오기
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNotice(notice);

	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp?currentPage=1");
	
%>
</body>
</html>