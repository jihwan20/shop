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
	
	// 공지사항 리스트 불러오기
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeList(beginRow, ROW_PER_PAGE);
	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 사항</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid" style="text-align: center;">
		<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : sub menu include -->
	<h1>공지 사항</h1>
		<table border="1" class="table table-dark table-striped"  style="margin:auto">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성 날짜</th>
				</tr>		
			</thead>
			<tbody>
<%
				for(Notice n : list) {
%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
						<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getCreateDate() %></td>
<%
				}
%>
			</tbody>
		</table>
		<br>
		<div>
<%		
		if(loginMember == null) {
%>			
			<div></div>
<%			
		}  else if(loginMember.getMemberLevel() < 1) {
%>		
			<div></div>
<%			
		} else if(loginMember.getMemberLevel() >= 1) {
%>
			<a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">추가</a>
<%
		}
%>
		</div>
		<p></p>
		<div>
<%

			int lastPage = noticeDao.selectLastPage(ROW_PER_PAGE);

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
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=1">처음으로</a>
<%
		
			// 이전 버튼
				if(startPage > nowPage){
%>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=startPage-nowPage%>">이전</a>
<%
			}
		
			// 페이지 번호 버튼
			for(int i=startPage; i<=endPage; i++) {
				if(endPage < lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
<%
				} else if(endPage>lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%></a>
<%	
				}
				if(i == lastPage || lastPage == 0) {	
					break;
				}
			}

			// 다음 버튼
			if(endPage < lastPage){
%>
			<a class="btn btn-success" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=startPage+nowPage%>">다음</a>
<%
			}
%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/selectNoticeList.jsp?currentPage=<%=lastPage%>">끝으로</a>
<%
%>
		</div>
		<br>
	</div>
</body>
</html>