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
<title>[관리자]상품 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
		
		<!-- 전자책 상세보기 폼 -->
		
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);	
	%>	
		<h1>상품 상세보기</h1>
		<img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg() %>" width="300px" height="300px">
		<p></p>
			<table border="1" style="margin:auto">
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
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/admin/updateEbookForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">수정</a>
			<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">이미지 수정</a>
			<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/deleteEbookAction.jsp?ebookNo=<%=ebook.getEbookNo()%>">삭제</a>
		</div>
	</div>
</body>
</html>