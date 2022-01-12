<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> <!-- request 대신에 쓰자. -->
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일 이름 중복을 피하려는 변수 -->
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
	// int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		
	// 디버깅 코드
	// System.out.println(ebookNo + " < -- ebookNo");
	// multipart/form-data로 넘겼기 때문에 사용할 수 없다.
	// request, 파일 경로, 파일 크기, 인코딩, 중복변수
	MultipartRequest mr = new MultipartRequest(request, "D:/Git-Shop/shop/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	
	// ebook 호출
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(ebookImg);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookImg(ebook);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookOne.jsp?ebookNo="+ebookNo);
	
	
%>
