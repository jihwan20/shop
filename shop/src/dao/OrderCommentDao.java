package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.OrderComment;

public class OrderCommentDao {
	
	// [회원, 비회원] 상품 후기 페이징
	public int selectlastPage(int commentrowPerPage) throws ClassNotFoundException, SQLException {
		
		// 변수 선언
		int lastPage = 0;
		
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// SQL쿼리
		String sql = "SELECT COUNT(*) FROM order_comment";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;
		if(rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / commentrowPerPage;
		if(totalRowCount % commentrowPerPage != 0) {
			lastPage++;
		}
		//연결 끊기
		rs.close();
	    stmt.close();
	    conn.close();
		return lastPage;
		}
	
	// [회원, 비회원] 상품 후기 페이지
	public ArrayList<OrderComment> selectOrderCommentList(int ebookNo, int commentbeginRow, int commentrowPerPage) throws ClassNotFoundException, SQLException {
	ArrayList<OrderComment> list = new ArrayList<OrderComment>();
	
	// MariaDB 연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// 디버깅 코드
	System.out.println("conn : "+conn);
	
	// 쿼리문 작성
	String sql = "SELECT order_score orderScore, order_comment_content orderCommentContent, create_date createDate FROM order_comment WHERE ebook_no=? ORDER BY create_date DESC LIMIT ?,?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, ebookNo);
	stmt.setInt(2, commentbeginRow);
	stmt.setInt(3, commentrowPerPage);
	ResultSet rs = stmt.executeQuery();
	
	while(rs.next()) {
		OrderComment oc = new OrderComment();
		oc.setOrderScore(rs.getInt("orderScore"));
		oc.setOrderCommentContent(rs.getString("orderCommentContent"));
		oc.setCreateDate(rs.getString("createDate"));
		list.add(oc);
	}
	
	// 연결 끊기
	rs.close();
	stmt.close();
	conn.close();
	return list;
	
	}
	
	//[회원, 비회원] 상품 평균 구하기
	public double selectOrderScoreAvg(int ebookNo) throws ClassNotFoundException, SQLException {
		double avgScore = 0;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT AVG(order_score) av FROM order_comment WHERE ebook_no = ? ORDER BY ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			avgScore = rs.getDouble("av");
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return avgScore;
	}
	
	// [회원] 내가 주문한 상품 평가 페이지
	public void insertOrderComment(OrderComment ordercomment) throws ClassNotFoundException, SQLException {

		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_date, update_date) VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordercomment.getOrderNo());
		stmt.setInt(2, ordercomment.getEbookNo());
		stmt.setInt(3, ordercomment.getOrderScore());
		stmt.setString(4, ordercomment.getOrderCommentContent());
		stmt.executeUpdate();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
}
