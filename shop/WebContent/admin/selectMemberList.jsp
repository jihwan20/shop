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
	
	// 검색어
	String searchMemberId ="";
	if(request.getParameter("searchMemberId") != null) {
		searchMemberId = request.getParameter("searchMemberId");
	}
	
	// 디버깅 코드
	System.out.println(searchMemberId +" <-- selectMemberList searchmemberId");
	
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
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
		
	// 검색어가 있을 때와 없을 때가 분리
	if(searchMemberId.equals("") == true) { // 검색어가 있을 때
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else {
		memberList = memberDao.selectMemberListAllBysearchMemberID(beginRow, ROW_PER_PAGE, searchMemberId);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
	
</head>
<body>
<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end :  adminMenu include -->
		<h1>회원 목록</h1>
		<table class="table table-dark table-striped" border="1" style="margin:auto">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원아이디</th>
					<th>회원등급</th>
					<th>회원이름</th>
					<th>회원나이</th>
					<th>회원성별</th>
					<th>수정날짜</th>
					<th>생성날짜</th>
					<th>등급수정</th>
					<th>비밀번호수정</th>
					<th>회원탈퇴</th>
				</tr>		
			</thead>
			<tbody>
<% 
				for(Member m : memberList) {
%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td>
						 <%=m.getMemberLevel()%>
<%
						if(m.getMemberLevel() == 0) {
%>
							<span> : 일반회원</span>
<%							
						} else if(m.getMemberLevel() == 1) {
%>							
							<span> : 관리자</span>
<%							
						}
%>
						</td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getMemberAge()%></td>
						<td><%=m.getMemberGender()%></td>
						<td><%=m.getUpdateDate()%></td>
						<td><%=m.getCreateDate()%></td>
						<td>
							<!-- 특정회원의 등급을 수정 -->
							<a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>">등급수정</a>
						</td>
						<td>
							<!-- 특정회원의 비밀 번호를 수정 -->
							<a class="btn btn-outline-primary" href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>">비밀번호수정</a>
						</td>
						<td>
							<!-- 특정회원을 강제 탈퇴 -->
							<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=m.getMemberNo()%>">강제탈퇴</a>
						</td>
					</tr>
<%
				}
%>
			</tbody>
		</table>
		<br>
		<div>
<%
			// ISSUE : 페이지가 잘 되었는데... 검색한 후 페이징하면 안된다... -> ISSUE 해결
			int lastPage = memberDao.selectLastPage(ROW_PER_PAGE, searchMemberId);
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
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=1&searchMemberId=<%=searchMemberId%>">처음으로</a>
<%
		
			// 이전 버튼
			if(startPage > nowPage){
%>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage-nowPage%>&searchMemberId=<%=searchMemberId%>">이전</a>
<%
			}
		
			// 페이지 번호 버튼
			for(int i = startPage; i <= endPage; i++) {
				if(currentPage == i){
%>
					<a class="btn btn-success" href="./selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>"><%=i%></a>
<%	
				} else if(endPage <= lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>"><%=i%></a>
<%
				} else if(endPage > lastPage){
%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>"><%=i%></a>
<%	
				}
				if(i == lastPage || lastPage == 0) {	
					break;
				}
			}

			// 다음 버튼
			if(endPage < lastPage){
%>
			<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage+nowPage%>&searchMemberId=<%=searchMemberId%>">다음</a>
<%
			}
%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=lastPage%>&searchMemberId=<%=searchMemberId%>">끝으로</a>
<%
%>
		</div>
		<br>
			<!-- memberId로 검색  -->
		<div>
		<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get">
		아이디 : <input type="text" name="searchMemberId">
		<button type="submit" class="btn btn-info">검색</button>
		</form>
		</div>
	</div>
</body>
</html>