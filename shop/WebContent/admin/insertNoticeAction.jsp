<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertNoticeAction.jsp</title>
</head>
<body>
<% 
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 공지사항 값이 null 이면 폼으로 다시 이동
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null || request.getParameter("memberNo") == null ) {
		response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp");
		return;
	}
	// 공지사항 값이 공백 이면 폼으로 다시 이동
	if(request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("") || request.getParameter("memberNo").equals("") ) {
		response.sendRedirect(request.getContextPath()+"/insertNoticeForm.jsp");
		return;
	}
	
	// 데이터 수집
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println(noticeTitle + " <-- noticeTitle");
	System.out.println(noticeContent + " <-- noticeCotent");
	System.out.println(memberNo + " <-- memberNo");
	
	// 데이터 가져오기
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setMemberNo(memberNo);
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNotice(notice);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
	
%>
</body>
</html>