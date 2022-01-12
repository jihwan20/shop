<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberAction</title>
</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 상태에서는 페이지 접근 불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"index.jsp");
		return;
	}
	
	// 회원가입 입력값 검사(null일 때 검사)
		if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null 
				|| request.getParameter("memberAge") == null || request.getParameter("memberGender") == null ) {		
			// 다시 브라우저에게 다른 곳을 요청
			response.sendRedirect(request.getContextPath()+"/index.jsp");
			return;
		}
	
	// 회원가입 입력값 검사(공백일 때 검사)
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("")
			|| request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")) {		
		// 다시 브라우저에게 다른 곳을 요청
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	// 데이터 수집
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	// 디버깅 코드
	System.out.println(memberId + " <-- memberId");
	System.out.println(memberPw + " <-- memberPw");
	System.out.println(memberName + " <-- memberName");
	System.out.println(memberAge + " <-- memberAge");
	System.out.println(memberGender + " <-- memberGender");
	
	// 데이터 가져오기
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	MemberDao memberDao = new MemberDao();
	memberDao.insertMember(member);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>
</body>
</html>