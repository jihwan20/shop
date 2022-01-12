<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 인증 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 데이터 수집
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	// 디버깅 코드
	System.out.println(qnaNo+" <-- qnaNo");
	
%>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	
		<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- QnA 수정 -->
		<form action="<%=request.getContextPath() %>/updateQnaAction.jsp" method="post" class=".custom-select">
		<h1>QnA 수정</h1>
			<!-- QnA 번호 -->
			<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
			
			<!-- Member 번호 -->
			<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
		
			<!-- 비밀글 유/무 -->
			<div class="text-white">비밀글 : </div>
			<div>
				<select name="qnaSecret" class="custom-select" style="width:200px; height:40px; text-align:center;">
					<option value="">==선택==</option>
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
			</div>
			
			<!-- 구분 -->
			<div class="text-white">구분 : </div>
			<div>
				<select name="qnaCategory" class="custom-select" style="width:200px; height:40px; text-align:center;">
					<option value="">==선택==</option>
					<option value="1">전자책 관련</option>
					<option value="2">개인정보 관련</option>
					<option value="3">기타</option>
				</select>
			</div>
			
			<!-- 제목 -->
			<div class="text-white">제목 : </div>
			<div class="text-white"><input type="text" style="text-align:center;" name="qnaTitle"></div>
			
			<!-- 내용 -->	
			<div class="text-white">내용 : </div>
			<div><textarea name="qnaContent" rows="3" cols="30" style="text-align:center;" class="form-control"></textarea></div>
			
			
			<br><button class="btn btn-success" type="submit">수정</button>
			<button class="btn btn-danger" type="reset">초기화</button>
		</form>
	</div>
</body>
</html>