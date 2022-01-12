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
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		
	// 디버깅 코드
	System.out.println(ebookNo + " < -- ebookNo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectEbookOne.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
		<form action="<%=request.getContextPath() %>/admin/updateEbookImgAction.jsp" method="post" 
		enctype="multipart/form-data"> 
		<!-- multipart/form-data : 액션으로 기계어 코드를 넘길 때 사용 -->
		<!-- application/x-www-form-urlencoded : 액션으로 문자열을 넘길 때 사용 -->
		<input type="text" name="ebookNo" value="<%=ebookNo%>" readonly="readonly">
		<input type="file" name="ebookImg">
		<button style="submit">이미지 파일 수정</button>
		</form>
	</div>
</body>
</html>