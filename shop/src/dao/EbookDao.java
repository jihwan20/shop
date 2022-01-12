package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	// [관리자] 전자책 추가
	public void insertEbook(Ebook ebook) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_img, ebook_summary, ebook_state, create_date, update_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookImg());
		stmt.setString(9, ebook.getEbookSummary());
		stmt.setString(10, ebook.getEbookState());
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [회원, 관리자] 전차책 신상품 목록
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException {
		// ArrayList 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice
		FROM ebook
		ORDER BY create_date DESC
		LIMIT 0, 5
		*/
		
		// 쿼리문 작성
		String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice FROM ebook ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 카테고리 값 가져오기
		while(rs.next()) {
		Ebook ebook = new Ebook();
		ebook.setEbookNo(rs.getInt("ebookNo"));
		ebook.setEbookImg(rs.getString("ebookImg"));
		ebook.setEbookPrice(rs.getInt("ebookPrice"));
		ebook.setEbookTitle(rs.getString("ebookTitle"));
		list.add(ebook);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
				
	}
	
	// [회원, 관리자] 전차책 인기 상품 목록
	public ArrayList<Ebook> selectPopularEbookList() throws SQLException, ClassNotFoundException {
		
		// ArrayList 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice
		FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) 
		FROM orders 
		GROUP BY ebook_no 
		ORDER BY COUNT(ebook_no) DESC
		LIMIT 0, 5) t
		ON e.ebook_no = t.ebook_no
		*/
		
		// 쿼리문 작성
		String sql = "SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 카테고리 값 가져오기
		while(rs.next()) {
		Ebook ebook = new Ebook();
		ebook.setEbookNo(rs.getInt("ebookNo"));
		ebook.setEbookImg(rs.getString("ebookImg"));
		ebook.setEbookPrice(rs.getInt("ebookPrice"));
		ebook.setEbookTitle(rs.getString("ebookTitle"));
		list.add(ebook);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}

	// [관리자] 전자책 삭제 
	public void deleteEbookByAdmin(int ebookNo) throws ClassNotFoundException, SQLException {
		
		// MariaDb 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "DELETE FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
		
	}
	
	// [관리자] 전자책 이미지 수정
	public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setInt(2, ebook.getEbookNo());
		stmt.executeUpdate();
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [관리자] 전차책 상세보기 페이지
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		Ebook ebook = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리숨 작성
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_state ebookState, create_date createDate, update_date updateDate FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookState(rs.getString("ebookState"));
			ebook.setCreateDate(rs.getString("createDate"));
			ebook.setUpdateDate(rs.getString("updateDate"));
			return ebook;
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return ebook;
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
		String sql = "SELECT COUNT(*) from ebook";
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
	
	// [관리자 & 고객] 전차책 리스트
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws SQLException, ClassNotFoundException {
		
		// ArrayList 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		 SELECT 
		 ebook_no ebookNo,
		 category_name categoryName,
		 ebook_title ebookTitle,
		 ebook_state eoobkState
		 FROM ebook
		 ORDER BY create_date DESC 
		 LIMIT ?,?
		*/
		
		// 쿼리문 작성
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 카테고리 값 가져오기
		while(rs.next()) {
		Ebook ebook = new Ebook();
		ebook.setEbookNo(rs.getInt("ebookNo"));
		ebook.setCategoryName(rs.getString("categoryName"));
		ebook.setEbookImg(rs.getString("ebookImg"));
		ebook.setEbookPrice(rs.getInt("ebookPrice"));
		ebook.setEbookTitle(rs.getString("ebookTitle"));
		ebook.setEbookState(rs.getString("ebookState"));
		list.add(ebook);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// [관리자] 카테고리 별 전차책 리스트 생성
	public ArrayList<Ebook> selectEbookListByCategory(int beginRow, int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException {
		// ArrayList 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		 SELECT 
		 ebook_no ebookNo,
		 category_name categoryName,
		 ebook_title ebookTitle,
		 ebook_state eoobkState
		 FROM ebook
		 WHERE category_name=?
		 ORDER BY create_date DESC 
		 LIMIT ?,?
		*/
		// 쿼리문 작성
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 카테고리 값 가져오기
		while(rs.next()) {
		Ebook ebook = new Ebook();
		ebook.setEbookNo(rs.getInt("ebookNo"));
		ebook.setCategoryName(rs.getString("categoryName"));
		ebook.setEbookTitle(rs.getString("ebookTitle"));
		ebook.setEbookState(rs.getString("ebookState"));
		list.add(ebook);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;	
		
	}
}
