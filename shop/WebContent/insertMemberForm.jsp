<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
	// 로그인 상태
	if(session.getAttribute("loginMember") != null) {
		// 다시 브라우저에게 다른 곳을 요청
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
	<div style="margin-top: 100px; border-radius:15px; width: 500px; height: 550px;" class="container float-center text-center  bg-light">
	<br>
		<a class="h1 text-primary" style="text-decoration-line : none;" href="<%=request.getContextPath() %>/index.jsp">EbShop</a>
<%
			String memberIdCheck="";
			if(request.getParameter("memberIdCheck") != null) {
				memberIdCheck = request.getParameter("memberIdCheck");
			}
%>
		
		<!-- memberId가 사용가능한지 확인 폼 -->
		<form action="<%=request.getContextPath() %>/selectMemberIdCheckAction.jsp" method="post">
			<div class="text-dark">
				아이디 중복 검사 : 
				<!--처음 이 페이지에 들어오면 null -->
				<!-- 중복 검사 후 들어오면 '사용중인 아이디 입니다' -->
				<%=request.getParameter("idCheckResult") %>
			</div>
			<div><input type="text" name="memberIdCheck"></div><br>
			<button class="btn btn-outline-primary" type="submit">아이디 중복 검사</button>
		</form>
		
		<!-- 회원가입 폼 -->
		<form id="joinForm" action="<%=request.getContextPath() %>/insertMemberAction.jsp" method="post" class=".custom-select">	
		
			<!-- 회원 아이디 -->
			<div class="text-dark">아이디 : </div>
			<div><input type="text" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck%>"></div>
			
			<!-- 회원 비밀번호 -->
			<div class="text-dark">비밀번호 : </div>
			<div class="text-dark"><input type="password" id="memberPw" name="memberPw"></div>
			
			<!-- 회원 이름 -->
			<div class="text-dark">이름 : </div>
			<div class="text-dark"><input type="text" id="memberName" name="memberName"></div>
			
			<!-- 회원 나이 -->
			<div class="text-dark">나이 : </div>
			<div><input type="text" id="memberAge" name="memberAge"></div>
			
			<!-- 회원 성별 -->
			<div class="text-dark">성별 : </div>
			<div>
			<input type="radio" class="memberGender" name="memberGender" value="남">남
			<input type="radio" class="memberGender" name="memberGender" value="여">여
			</div>
			
			<br><button class="btn btn-outline-primary" id="btn" type="button">회원가입</button>
			<button class="btn btn-outline-primary" type="reset">초기화</button>
		</form>
	</div>
	<script>
		$('#btn').click(function() {
			if($('#memberId').val() == '') {
				alert('아이디를 입력해주세요!');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('비밀번호를 입력해주세요!');
				return;
			}
			if($('#memberName').val() == '') {
				alert('이름를 입력해주세요!');
				return;
			}
			if($('#memberName').val() == '') {
				alert('이름를 입력해주세요!');
				return;
			}
			if($('#memberAge').val() == '') {
				alert('나이를 입력해주세요!');
				return;
			}
			let memberGender = $('.memberGender:checked'); // 클래스 속성으로 부르면 리턴 값은 배열로 취한다.
			if(memberGender.length == 0) {
				alert('성별을 선택해주세요!');
				return;
			}
			$('#joinForm').submit();
		})
	</script>
</body>
</html>