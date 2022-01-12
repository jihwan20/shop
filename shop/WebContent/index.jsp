<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container-fluid p-3">
		<!-- start :  sub menu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : sub menu include -->
		

	<br>
	<!-- 상품 목록 출력 -->
	<%
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
	
	// 전체 목록 가져오기
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	
	// 인기 상품 목록 가져오기
	ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
	
	// 신상품 목록 가져오기
	ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
	
	// 최근 공지사항 5개 가져오기
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNewEbookList();
	
	
%>
	<h2>공지 사항</h2>
		<table class="table table-dark table-striped text-center"  style="margin:auto">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성 날짜</th>
				</tr>		
			</thead>
			<tbody>
<%
				for(Notice n : noticeList) {
%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
						<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getCreateDate().substring(0,10) %></td>
<%
				}
%>
			</tbody>
		</table><br>
		
  <h2>신상품 목록</h2>
  <table class="table" style="margin:auto">
      <tr>
<%
            for(Ebook e : newEbookList) {
%>   
               <td>
                  <div>
                      <a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
                     <img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
                     </a>
                  </div>
                  <div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
                  <div>₩ <%=e.getEbookPrice()%></div>
               </td>
            
<%         
            }
%>
      </tr>
   </table><br>
  
  <h2>인기 상품 목록</h2>
  <table class="table" style="margin:auto">
      <tr>
<%
            for(Ebook e : popularEbookList) {
%>   
               <td>
                  <div>
                     <a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
                     <img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
                     </a>
                  </div>
                  <div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
                  <div>₩ <%=e.getEbookPrice()%></div>
               </td>
            
<%         
            }
%>
      </tr>
   </table><br>
  
  
  <h2>전체 상품 목록</h2>
   <table class="table" style="margin:auto">
      <tr>
<%
            int i = 0;
            for(Ebook e : ebookList) {
%>   
               <td>
                  <div>
                     <a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
                    <img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200">
                    </a>
                  </div>
                  <div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
                  <div>₩ <%=e.getEbookPrice()%></div>
               </td>
<%
               i+=1; // for문 끝날때마다 i는 1씩 증가
               if(i%5 == 0) {
%>
                  </tr><tr> <!-- <tr> 태그를 닫고 열면서 줄바꿈 -->
<%         
               }
            }
%>
      </tr>
   </table>
</div>
</body>
</html>