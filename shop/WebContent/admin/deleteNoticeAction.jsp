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
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
	// 디버깅 코드
	System.out.println(noticeNo + " < -- noticeNo");
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNotice(noticeNo);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectNoticeListByAdmin.jsp?currentPage=1");
%>