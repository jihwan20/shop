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
	System.out.println(currentPage +" <-- currentPage");
	
	final int ROW_PER_PAGE = 10; // 상수 : rowPerPage 변수는 10으로 초기화되면 끝까지 10이다. 바꾸지 말자.
	
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// 카테고리Dao 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// 카테고리 이름 변수 생성
	String categoryName = "";
	// 카테고리 이름이 null이 아니라면 이름 사용
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	
	// 전차책목록 불러오기
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = null;
	
	if(categoryName.equals("") == true){
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, categoryName);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectCategoryList.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
		<h1>전자책 관리</h1>
			<form action="<%=request.getContextPath()%>/admin/selectEbookList.jsp">
				<select name="categoryName" class="custom-select" style="width:250px;height:50px;" >
					<option value="">전체목록</option>
<%
				for(Category c : categoryList){
%>
				<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
<%	
				}
%>
				</select>
				<button type="submit" class="btn btn-outline-secondary">전자책목록</button>
			</form>
			<!-- 전차책 목록 출력 : 카테고리 별 출력 -->
			<div class="container p-3 bg-dark text-white" style="text-align: center;">
				<table class="table table-dark table-striped" border="1" style="margin:auto">
					<thead>
						<tr>
							<th>전차책 번호</th>
							<th>카테고리 이름</th>
							<th>전차책 제목</th>
							<th>전차책 상태</th>
						</tr>		
					</thead>
					<tbody>
<% 
						for(Ebook e : ebookList) {
%>
							<tr>
								<td><%=e.getEbookNo()%></td>
								<td><%=e.getCategoryName()%></td>
								<td><a href="<%=request.getContextPath() %>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>"><%=e.getEbookTitle() %></a></td>
								<td><%=e.getEbookState()%></td>
<%
						}
%>
					</tbody>
				</table>
				<br><a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/insertEbookForm.jsp">전자책 추가</a>
			</div>
			<div>
<%

			int lastPage = ebookDao.selectLastPage(ROW_PER_PAGE);

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
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=1">처음으로</a>
<%
		
			// 이전 버튼
				if(startPage > nowPage){
%>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=startPage-nowPage%>&categoryName=<%=categoryName%>">이전</a>
<%
			}
		
			// 페이지 번호 버튼
			for(int i=startPage; i<=endPage; i++) {
				if(endPage < lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%></a>
<%
				} else if(endPage>lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%></a>
<%	
				}
				if(i == lastPage || lastPage == 0) {	
					break;
				}
			}

			// 다음 버튼
			if(endPage < lastPage){
%>
			<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=startPage+nowPage%>&categoryName=<%=categoryName%>">다음</a>
<%
			}
%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>&categoryName=<%=categoryName%>">끝으로</a>
<%
%>
		</div>
	</div>
</body>
</html>