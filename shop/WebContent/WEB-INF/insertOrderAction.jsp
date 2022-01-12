<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	//인증 방어 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 데이터 수집
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
   
	// 디버깅 코드
	System.out.println(ebookNo + " < -- ebookNo");
	System.out.println(orderPrice + " <-- ebookPrice");
	System.out.println(memberNo + " <-- memberNo");
	
	// Order 데이터 가져오기
	Order order = new Order();
	order.setEbookNo(ebookNo);
	order.setMemberNo(memberNo);
	order.setOrderPrice(orderPrice);
	
	OrderDao orderDao = new OrderDao();
	orderDao.insertOrder(ebookNo, memberNo, orderPrice);
	
	// 페이지 이동
	response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
%> 	 