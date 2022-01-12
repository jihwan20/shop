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
	// 데이터 수집
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	// 디버깅 코드
	System.out.println(orderNo + " < -- orderNo");
	System.out.println(ebookNo + " < -- ebookNo");
%>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품평 작성</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="text-align: center;">
	
		<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- 상품평 작성 -->
		<form action="<%=request.getContextPath() %>/insertOrderCommentAction.jsp" method="post" class=".custom-select">
		<h1>상품평 작성</h1>
		
			<!-- 주문 번호 -->
			<div class="text-white">주문 번호 : </div>
			<div><input type="text" style="text-align:center;" name="orderNo" readonly="readonly" value="<%=orderNo%>"></div>
			
			<!-- 책 번호 -->
			<div class="text-white">전자책 번호 : </div>
			<div><input type="text" style="text-align:center;" name="ebookNo" readonly="readonly" value="<%=ebookNo%>"></div>
			
			<!-- 별점 -->
			<div class="text-white">별점 : (10점 만점에 몇 점?) </div>
			<div>
				<select name="orderScore" class="custom-select" style="width:170px; height:35px; text-align:center;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</div>
				
			<!-- 상품 평 -->
			<div class="text-white">상품 평 : </div>
			<div><textarea name="orderCommentContent" rows="3" cols="30" style="text-align:center;" class="form-control"></textarea></div>
			<br>
			<div>
				<button class="btn btn-warning" type="submit">등록</button>
				<button class="btn btn-danger" type="reset">초기화</button>
			</div>
		</form>
	</div>
</body>
</html>