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
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="text-align: center;">
	<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : sub menu include -->
	<h1>나의 주문</h1>
		<table class="table table-dark table-striped" border="1" style="margin:auto">
			<thead>
				<tr>
					<th>주문 번호</th>
					<th>전차책 제목</th>
					<th>전자책 가격</th>
					<th>주문 날짜</th>
					<th>상세 주문 내역</th>
					<th>전자책 후기</th>
				</tr>		
			</thead>
			<tbody>
				<%
				for(OrderEbookMember oem : list) {
				%>
					<tr>
						<!-- 체인 방법 -->
						<td><%=oem.getOrder().getOrderNo()%></td>
						<td><%=oem.getEbook().getEbookTitle()%></td>
						<td><%=oem.getOrder().getOrderPrice()%></td>
						<td><%=oem.getOrder().getCreateDate()%></td>
						<td><a class="btn btn-outline-primary" href="<%=request.getContextPath() %>/admin/selectOrderOne.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>">주문 내역</a></td>
						<td><a class="btn btn-outline-primary"href="<%=request.getContextPath() %>/insertOrderCommentForm.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">후기 작성</a></td>
<%					
				}
%>
			</tbody>
		</table>
	</div>
</body>
</html>