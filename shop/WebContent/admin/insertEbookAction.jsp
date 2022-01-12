<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> <!-- request 대신에 쓰자. -->
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일 이름 중복을 피하려는 변수 -->
<% 
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	MultipartRequest mr = new MultipartRequest(request, "D:/Git-Shop/shop/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	// 전차책 값이 null이면 폼으로 다시 이동
	if(mr.getParameter("ebookIsbn") == null || mr.getParameter("categoryName") == null || mr.getParameter("ebookTitle") == null || mr.getParameter("ebookAuthor") == null || mr.getParameter("ebookCompany")==null || mr.getParameter("ebookPageCount") == null || mr.getParameter("ebookPrice") == null || mr.getFilesystemName("ebookImg")==null || mr.getParameter("ebookSummary") == null || mr.getParameter("ebookState") == null) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		return;
	}
	
	// 전차책 값이 공백이면 폼으로 다시 이동
	if(mr.getParameter("ebookIsbn").equals("") || mr.getParameter("categoryName").equals("") || mr.getParameter("ebookTitle").equals("") || mr.getParameter("ebookAuthor").equals("") || mr.getParameter("ebookCompany").equals("") || mr.getParameter("ebookPageCount").equals("") || mr.getParameter("ebookPrice").equals("") || mr.getFilesystemName("ebookImg").equals("") || mr.getParameter("ebookSummary").equals("") || mr.getParameter("ebookState").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		return;
	}
	
	// 데이터 수집
	String ebookIsbn = mr.getParameter("ebookIsbn");
	String categoryName = mr.getParameter("categoryName");
	String ebookTitle = mr.getParameter("ebookTitle");
	String ebookAuthor = mr.getParameter("ebookAuthor");
	String ebookCompany = mr.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(mr.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(mr.getParameter("ebookPrice"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	String ebookSummary = mr.getParameter("ebookSummary");
	String ebookState = mr.getParameter("ebookState");
	
	// 디버깅 코드
	System.out.println(ebookIsbn+" <-- ebookIsbn");
	System.out.println(categoryName+" <-- categoryName");
	System.out.println(ebookTitle+" <-- ebookTitle");
	System.out.println(ebookAuthor+" <-- ebookAuthor");
	System.out.println(ebookCompany+" <-- ebookCompany");
	System.out.println(ebookPageCount+" <-- ebookPageCount");
	System.out.println(ebookPrice+" <-- ebookPrice");
	System.out.println(ebookImg+" <-- ebookImg");
	System.out.println(ebookSummary+" <-- ebookSummary");
	System.out.println(ebookState+" <-- ebookState");
	
	
	// 데이터 가져오기
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookIsbn);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookImg(ebookImg);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.insertEbook(ebook);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookList.jsp");
	
%>