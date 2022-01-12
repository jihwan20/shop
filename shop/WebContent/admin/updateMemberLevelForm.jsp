<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 방어코드
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
<title>회원 레벨 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark text-white" style="text-align: center;">
		<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post" class=".custom-select">
		<h1>회원 레벨 수정</h1>
		<br>
			<div>번호 : <%=memberNo%></div>
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
			<!-- 회원 레벨 -->
			<div class="text-white">카테고리 : </div>
				<select name="memberNewLevel">
					<option value="1">관리자</option>
				  <option value="0">일반회원</option>
				</select><br>
			<br><button class="btn btn-success" type="submit">수정</button>
			<button class="btn btn-danger" type="reset">초기화</button>
		</form>
	</div>
</body>
</html>