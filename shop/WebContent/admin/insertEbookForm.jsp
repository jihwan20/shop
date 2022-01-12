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
	
	// 카테고리 이름 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[관리자]전자책 추가</title>
</head>
<body>
	<div class="container p-3 bg-dark text-white" style="text-align: center;">
	<!-- start :  adminMenu include -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
	<!-- end :  adminMenu include -->	
		
		<!-- 전자책 추가 폼 -->
		<form action="<%=request.getContextPath() %>/admin/insertEbookAction.jsp" method="post" class=".custom-select" enctype="multipart/form-data">	
		
			<!-- 카테고리 이름 -->
			<div class="text-white">구분 : </div>
			<div>
				<select name="categoryName" class="custom-select" style="width:200px; height:40px; text-align:center;">
<%
		           for(Category c : categoryList) {
%>
		               <option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
<%      
		           }
%>
				</select>
			</div>
			
			<!-- 제목 -->
			<div class="text-white">제목 : </div>
			<div class="text-white" style="text-align:center;"><input type="text" name="ebookTitle" style="width:center;"></div>
			
			<!-- 저자 -->
			<div class="text-white">저자 : </div>
			<div class="text-white"><input type="text" name="ebookAuthor" style="width:center;"></div>
			
			<!-- 출판사 -->
			<div class="text-white">출판사 : </div>
			<div class="text-white"><input type="text" name="ebookCompany" style="width:center;"></div>
			
			<!-- 제목 -->
			<div class="text-white">제목 : </div>
			<div class="text-white"><input type="text" name="ebookTitle" style="width:center;"></div>
			
			<!-- 페이지 수 -->
			<div class="text-white">페이지수 : </div>
			<div class="text-white"><input type="number" name="ebookPageCount" style="width:center;"></div>
			
			<!-- 가격 -->
			<div class="text-white">가격 : </div>
			<div class="text-white"><input type="number" name="ebookPrice" style="width:center;"></div>
			
			<!-- 이미지 -->
			<div class="text-white">이미지 : </div>	
			<div class="text-white"><input type="file" name="ebookImg" style="width:center;"></div>
			
			<!-- 고유 번호 -->
			<div class="text-white">고유 번호 : </div>
			<div class="text-white"><input type="text" name="ebookIsbn" style="width:center;"></div>
			
			<!-- 요약 -->
			<div class="text-white">요약 : </div>
			<div><textarea name="ebookSummary" rows="3" cols="30" style="text-align:center;" class="form-control"></textarea></div>
			
			<!-- 상태 -->
			<div class="text-white">상태 : </div>
			<div>
				<select name="ebookState" class="custom-select" style="width:200px; height:40px; text-align:center;">
					<option value="">==선택==</option>
					<option value="판매중">판매중</option>
					<option value="품절">품절</option>
					<option value="절판">절판</option>
					<option value="구편절판">구편절판</option>
				</select>
			</div>
			<br><button class="btn btn-success" type="submit">추가</button>
			<button class="btn btn-danger" type="reset">초기화</button>
		</form>
	</div>
</body>
</html>