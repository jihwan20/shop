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
<title>공지사항 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark text-white" style="text-align: center;">
		<h1>공지사항 추가</h1>
			<!-- 공지사항 폼 -->
			<form action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp" method="post" class=".custom-select">
			
					<div class="text-white">제목 : </div>
					<div class="text-white"><input type="text" style="text-align:center;" name="noticeTitle"></div>
					
					<div class="text-white">내용 : </div>
					<div><textarea name="noticeContent" rows="3" cols="30" style="text-align:center;" class="form-control"></textarea></div>
					
					<div class="text-white">회원 번호 : </div>
					<div class="text-white"><input type="text" style="text-align:center;" name="memberNo" readOnly="readOnly" value="<%=loginMember.getMemberNo()%>"></div>
					
					<br><button class="btn btn-success" type="submit">추가</button>
					<button class="btn btn-danger" type="reset">초기화</button>
			</form>
	</div>	
</body>
</html>