<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인증 방어 코드 : 로그인 전에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	
	if(session.getAttribute("loginMember") != null) {
		System.out.println("이미 로그인 되어 있습니다.");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div style="margin-top: 100px; border-radius:15px; width: 500px; height: 400px;" class="container float-center text-center  bg-light">
		<br>
		<a class="h1 text-primary" style="text-decoration-line : none;" href="<%=request.getContextPath() %>/index.jsp">EbShop</a>
		<form id="loginForm" action="<%=request.getContextPath() %>/loginAction.jsp">
			<table style="margin-top: 60px;" class="table table-bordered">
				<tr>
					<th>아이디</th>
					<td><input class="btn btn-light" type="text" id="memberId" name="memberId" value="test"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input class="btn btn-light" type="password" id="memberPw" name="memberPw" value="1234"></td>
				</tr>
			</table>
			<br>
			<button style="width: 450px;" class="btn btn-outline-dark" type="button" id="loginBtn" onclick="button()">로그인</button>
			
		</form>
	</div>
	<br>
	<div style="text-align: center;">
		<a class="btn" href="<%=request.getContextPath() %>/insertMemberForm.jsp">회원가입</a>
	</div>
	<script>
		let loginBtn = $('#loginBtn').click(function() {
			if($('#memberId').val() == '') { // id가 공백이면
				alert('아이디를 입력해주세요!');
				return;
			} else if($('#memberPw').val() == '') { // pw가 공백이면
				alert('비밀번호를 입력해주세요!');
			} else {
				// 버튼을 클릭 했을 때
				// <button type="button"> -> <button type="submit">
				$('#loginForm').submit();
			}
		});
	</script>
</body>
</html>