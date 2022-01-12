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
	// 데이터 수집
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 디버깅 코드
	System.out.println(memberNo+" <-- memberNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 비밀번호 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark text-white" style="text-align: center;">
		<form action="<%=request.getContextPath()%>/admin/updateMemberPwAction.jsp" method="post" class=".custom-select">
		<h1>비밀 번호 수정</h1>
		<br>
			<div>번호 : <%=memberNo%></div>
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
			<!-- 회원 비밀번호 -->
			<div class="text-white">비밀번호 : </div>
			<div class="text-white"><input type="password" name="memberPw"></div>
			<br><button class="btn btn-success" type="submit">수정</button>
			<button class="btn btn-danger" type="reset">초기화</button>
		</form>
	</div>
</body>
</html>