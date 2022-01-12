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
<title>updateMemberLevelAction</title>
</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 데이터 수집
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberNewLevel = Integer.parseInt(request.getParameter("memberNewLevel"));
	
	// 디버깅 코드
	System.out.println(memberNo+" <-- memberNo");
	System.out.println(memberNewLevel+" <-- memberLevel");
	
	// MemberDao 불러오기
	MemberDao memberDao = new MemberDao();
	
	// 데이터 가져오기
	Member member = new Member();
	member.setMemberNo(memberNo);
		
	memberDao.updateMemberLevelByAdmin(member, memberNewLevel);

	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
	
%>
</body>
</html>