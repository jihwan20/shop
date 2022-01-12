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
	
	// 페이지
	int currentPage = 1;
	
	// 페이지 번호가 null이 아니라면 int 타입으로 바꿔서 페이지 번호 사용
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 디버깅 코드
	System.out.println(currentPage +" <-- selectMemberList currentPage");
	
	final int ROW_PER_PAGE = 10; // 상수 : rowPerPage 변수는 10으로 초기화되면 끝까지 10이다. 바꾸지 말자.
	
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// 주문 리스트 불러오기
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
	
	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 리스트</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
	<h1>주문 리스트</h1>
		<table class="table table-dark table-striped" border="1" style="margin:auto">
			<thead>
				<tr>
					<th>주문 번호</th>
					<th>전차책 제목</th>
					<th>회원 번호</th>
					<th>전자책 가격</th>
					<th>주문 날짜</th>
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
						<td><%=oem.getMember().getMemberNo()%></td>
						<td><%=oem.getOrder().getOrderPrice()%></td>
						<td><%=oem.getOrder().getCreateDate()%></td>
<%					
				}
%>
			</tbody>
		</table>
		<br>
		<div>
<%

			int lastPage = orderDao.selectLastPage(ROW_PER_PAGE);

			// 페이지 번호의 갯수
			int nowPage = 10;
			
			// 시작 페이지 번호
			int startPage = ((currentPage - 1) / nowPage) * nowPage + 1;
			
			// 디버깅 코드
			System.out.println("startPage : "+startPage);
	
			// 마지막 페이지 번호
			int endPage = startPage + nowPage - 1;
			
			// 디버깅 코드
			System.out.println("endPage : "+endPage);
			
			//시작 버튼
%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=1">처음으로</a>
<%
		
			// 이전 버튼
				if(startPage > nowPage){
%>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=startPage-nowPage%>">이전</a>
<%
			}
		
			// 페이지 번호 버튼
			for(int i=startPage; i<=endPage; i++) {
				if(endPage < lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%></a>
<%
				} else if(endPage>lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%></a>
<%	
				}
				if(i == lastPage || lastPage == 0) {	
					break;
				}
			}

			// 다음 버튼
			if(endPage < lastPage){
%>
			<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=startPage+nowPage%>">다음</a>
<%
			}
%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=lastPage%>">끝으로</a>
<%
%>
		</div>
	</div>
</body>
</html>