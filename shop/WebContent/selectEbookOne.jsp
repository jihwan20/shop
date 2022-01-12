<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");

	//데이터 수집
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		
	// 디버깅 코드
	System.out.println(ebookNo + " < -- ebookNo");
	
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 후기 페이징
	int commentcurrentPage = 1;
	
	// 페이지 번호가 null이 아니라면 int 타입으로 바꿔서 페이지 번호 사용
	if(request.getParameter("commentcurrentPage") != null) {
		commentcurrentPage = Integer.parseInt(request.getParameter("commentcurrentPage"));
	}
	
	// 디버깅 코드
	System.out.println(commentcurrentPage +" <-- commentcurrentPage");
	
	final int Comment_ROW_PER_PAGE = 10; // 상수 : rowPerPage 변수는 10으로 초기화되면 끝까지 10이다. 바꾸지 말자.
	
	int commentbeginRow = (commentcurrentPage - 1) * Comment_ROW_PER_PAGE;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기(주문)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="text-align: center;">
<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);	
%>	
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<h1>상품 상세보기</h1>
		<img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg() %>" width="300px" height="300px">
		<p></p>
			<table class="table table-dark table-striped" border="1" style="margin:auto">
				<thead>
					<tr>
						<th>번호</th>
						<th>도서 코드</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>페이지 수</th>
						<th>가격</th>
						<th>책 소개</th>
						<th>상태</th>
						<th>입고 날짜</th>
						<th>업데이트 날짜</th>
					</tr>		
				</thead>
				<tbody>
					<tr>
						<td><%=ebook.getEbookNo()%></td>
						<td><%=ebook.getEbookISBN()%></td>
						<td><%=ebook.getCategoryName()%></td>
						<td><%=ebook.getEbookTitle()%></td>
						<td><%=ebook.getEbookAuthor()%></td>
						<td><%=ebook.getEbookCompany()%></td>
						<td><%=ebook.getEbookPageCount()%></td>
						<td><%=ebook.getEbookPrice()%></td>
						<td><%=ebook.getEbookSummary()%></td>
						<td><%=ebook.getEbookState()%></td>
						<td><%=ebook.getCreateDate()%></td>
						<td><%=ebook.getUpdateDate()%></td>
						<td>
				</tbody>
			</table>
		<br>
		<div>
			<h2>상품 주문</h2>
			<!-- 주문 입력하는 폼 -->
<%
				
				if(loginMember == null) {
%>
					<div>로그인 후에 주문이 가능합니다.</div>
					<div><a class="btn btn-outline-primary" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a></div>
					
<%
				} else {
%>
			<form method ="post" action ="<%=request.getContextPath()%>/insertOrderAction.jsp">
				<input type = "hidden" name = "ebookNo" value="<%=ebookNo%>">
				<input type = "hidden" name = "memberNo" value="<%=loginMember.getMemberNo()%>">
				<input type = "hidden" name = "orderPrice" value="<%=ebook.getEbookPrice()%>">
				<button type="submit" class="btn btn-outline-success" style="width:100px; height:50px;">주문 하기</button>
			</form>
<%
			}
%>
		</div><br>
		<h2>상품 후기</h2>
		<div>
		<!-- 상품의 별점 평균 -->
		<!-- SELECT AVG(order_score) FROM order_comment WHERE ebook_no = ? ORDER BY ebook_no -->
		<%
			OrderCommentDao ordercommentDao = new OrderCommentDao();
			double avgScore = ordercommentDao.selectOrderScoreAvg(ebookNo);
		%>
		별점 평균 : <%=avgScore %>
		</div><br>
		<div>
			<h2>후기 목록(페이징)</h2>
		<!-- 상품의 후기 -->
		<!--  SELECT * FROM order_comment WHERE ebook_no=? LIMIT ?,? -->
<%
			ArrayList<OrderComment> ordercommentlist = ordercommentDao.selectOrderCommentList(ebookNo, commentbeginRow, Comment_ROW_PER_PAGE);
%>
		 <table class="table table-dark table-striped" style="margin:auto;">
				<thead>
					<tr>
						<th>별점</th>
						<th>상품 후기</th>
						<th>등록 날짜</th>
				</thead>
<%		
			for(OrderComment oc : ordercommentlist ) {
%>				
				<tbody>
					<tr>
						<td> <%=oc.getOrderScore()%></td>
						<td> <%=oc.getOrderCommentContent()%></td>
						<td> <%=oc.getCreateDate()%></td>
					</tr>
<%		
			}
%>
	
	</table>
		 <div>
<%

			int lastPage = ordercommentDao.selectlastPage(Comment_ROW_PER_PAGE);

			// 페이지 번호의 갯수
			int nowPage = 10;
			
			// 시작 페이지 번호
			int startPage = ((Comment_ROW_PER_PAGE - 1) / nowPage) * nowPage + 1;
			
			// 디버깅 코드
			System.out.println("startPage : "+startPage);
	
			// 마지막 페이지 번호
			int endPage = startPage + nowPage - 1;
			
			// 디버깅 코드
			System.out.println("endPage : "+endPage);
			
			//시작 버튼
%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=1&ebookNo=<%=ebookNo%>">처음으로</a>
<%
		
			// 이전 버튼
				if(startPage > nowPage){
%>
				<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-nowPage%>&ebookNo=<%=ebookNo%>">이전</a>
<%
			}
		
			// 페이지 번호 버튼
			for(int i=startPage; i<=endPage; i++) {
				if(endPage < lastPage){
%>
					<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-nowPage%>&ebookNo=<%=ebookNo%>"><%=i%></a>
<%
				} else if(endPage>lastPage){
%>
					<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-nowPage%>&ebookNo=<%=ebookNo%>"><%=i%></a>
<%	
				}
				if(i == lastPage || lastPage == 0) {	
					break;
				}
			}

			// 다음 버튼
			if(endPage < lastPage){
%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-nowPage%>&ebookNo=<%=ebookNo%>">다음</a>
<%
			}
%>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-nowPage%>&ebookNo=<%=ebookNo%>">끝으로</a>
<%
%>
		</div>
		</div>
	</div>
</body>
</html>