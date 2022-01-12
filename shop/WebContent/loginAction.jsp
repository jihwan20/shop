<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	// 인코딩 코드
	request.setCharacterEncoding("utf-8");

	// 데이터 생성
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 디버깅 코드
	System.out.println(memberId+ " <-- memberId");
	System.out.println(memberPw+ " <-- memberPw");
	
	// 데이터 불러오기
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	Member returnMember = memberDao.login(paramMember);
	
	// 로그인 성공과 실패
	if(returnMember == null) {
		System.out.println("로그인 실패");
	} else {
		System.out.println("로그인 성공");
		System.out.println(returnMember.getMemberId());
		System.out.println(returnMember.getMemberName());
		System.out.println(returnMember.getMemberLevel());
		
		// 세션 변수를 생성
		session.setAttribute("loginMember", returnMember);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
%>