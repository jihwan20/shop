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
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[회원]회원정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="text-align: center;">
		<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : sub menu include -->
		<!-- 회원정보 상세보기 폼 -->
<%
		MemberDao memberDao = new MemberDao();
		Member member = memberDao.selectMemeberOne(loginMember.getMemberNo());
%>
		<h1>회원 정보</h1>
		<p></p><p></p>
			<div align="center">
				<div>
					아이디
				</div>
				<div>
					<input type="text" value="<%=member.getMemberId()%>">
				</div>
				<p></p>
				<div>
					비밀번호
				</div>
				<div>
					<input type="password" value="1234">
				</div>
				<p></p>
				<div>
					등급 : 
					<input type="number" value="<%=member.getMemberLevel()%>">
				</div>
				<p></p>
				<div>
					이름 : 
					<input type="text" value="<%=member.getMemberName()%>">
				</div>
				<p></p>
				<div>
					나이 : 
					<input type="number" value="<%=member.getMemberAge()%>">
				</div>
				<p></p>
				<div>
					성별 : 
					<input type="text" value="<%=member.getMemberGender()%>">
				</div>
				<p></p>
				<div>
					 날짜 : 
					<input type="text" value="<%=member.getCreateDate()%>">
				</div>
			</div>
		<p></p>
		<div align="center">
		<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/admin/updateMemberForm.jsp?memberNo=<%=member.getMemberNo()%>">정보수정</a>
		</div>
		<br><br>
		<div align="right">
		<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/deletMemberForm.jsp?memberNo=<%=member.getMemberNo()%>">회원탈퇴</a>
		</div>
		<br>
	</div>
</body>
</html>