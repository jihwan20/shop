<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">
		<ul class="nav justify-content-center">
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath() %>/index.jsp">메인으로</a></li>
			<!-- 회원괸리 : 목록 불러오기, 회원 비밀번호 및 등급 수정, 강제탈퇴 -->
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">회원 관리</a></li>
			
			<!-- 전자책 카테고리 관리 : 목록, 추가, 사용유무 수정
			1) Category.class
			2) CategoryDao.class
			3) selectCategoryList.jsp
			4) insertCategoryForm.jsp
			5) insertCategoryAction.jsp
			6) selectCategoryNameCheckAction.jsp
			7) updateCategoryStateAction.jsp
			-->
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">전자책 카테고리 관리</a></li>
			
			<!-- 전자책 관리 : 목록, 추가(이미지 추가), 수정, 삭제  -->
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">전자책 관리</a></li>
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp">주문 관리</a></li>
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/selectNoticeList.jsp">공지사항 관리</a></li>
			<li class="nav-item"><a class="navbar-brand text-warning" href="<%=request.getContextPath()%>/selectQnaList.jsp">QnA 게시판 관리</a></li>
		</ul>
	</nav>