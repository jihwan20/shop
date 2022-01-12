package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderEbookMember;

public class OrderDao {
	
	// [회원] 주문하기
	public void insertOrder(int ebookNo, int memberNo, int orderPrice) throws ClassNotFoundException, SQLException {
	
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
	    
		// 쿼리문 작성
		String sql = "INSERT INTO orders (ebook_no, member_no, order_price, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, memberNo);
		stmt.setInt(3, orderPrice);
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
 		conn.close();
	}
	
	// [회원] 나의 주문 리스트 페이지
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws SQLException, ClassNotFoundException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e Inner JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no
		WHERE m.member_no = 5 
		ORDER BY o.create_date DESC
		*/
		
		// 쿼리문 작성
	    String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e Inner JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no = ? ORDER BY o.create_date DESC";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, memberNo);
	    ResultSet rs = stmt.executeQuery();
		
		// Order, Ebook, Member 값 가져오기
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			list.add(oem);
		}
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// [관리자] 전자책 라스트 페이지
	public int selectLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		int totalRowCount = 0;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
								
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		// 검색한 아이디가 없으면 전체 데이터 수를 출력
		// 검색한 아이디가 있으면 그 검색한 데이터의 수를 출력
		String sql = "SELECT COUNT(*) from orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		System.out.println("rs : "+rs);
		
		// 토탈 페이지 구하는 코드
		if(rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / rowPerPage;
		if(totalRowCount % rowPerPage != 0) {
			lastPage++;
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return lastPage;
	}
	
	// [관리자] 주문 관리 페이지
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage)  throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		 SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate 
		 FROM orders o INNER JOIN ebook e Inner JOIN member m
		 ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no
		 ORDER BY o.create_date DESC
		 */
		// 주문 데이터를 남겨야 하기 때문에 물리적으로 외래키를 삭제한다.
		
		// 쿼리문 작성
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e Inner JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// Order, Ebook, Member 값 가져오기
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			list.add(oem);
		}
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}

}
