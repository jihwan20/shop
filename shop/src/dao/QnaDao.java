package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Qna;

public class QnaDao {
	
	// [관리자] 답글이 달리지 않은 QnA 출력
	public ArrayList<Qna> selectNoCommentQnaList() throws ClassNotFoundException, SQLException {
		
		// ArrayList 생성
		ArrayList<Qna> list = new ArrayList<Qna>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*
		SELECT q.*, qc.*
		FROM qna q LEFT JOIN qna_comment qc
		ON q.qna_no = qc.qna_no
		WHERE qc.qna_no IS NULL;
		*/
		
		// 쿼리문 작성
		String sql = "SELECT q.*, qc.* FROM qna q LEFT JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE qc.qna_no IS NULL;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qna_no"));
			qna.setQnaCategory(rs.getString("qna_category"));
			qna.setQnaTitle(rs.getString("qna_title"));
			qna.setQnaContent(rs.getString("qna_content"));
			qna.setQnaSecret(rs.getString("qna_secret"));
			qna.setMemberNo(rs.getInt("member_no"));
			qna.setCreateDate(rs.getString("create_date"));
			qna.setUpdateDate(rs.getString("update_date"));
			list.add(qna);
		}
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		System.out.println("rs : "+rs);
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// [글쓴이] QnA 삭제
	public void deleteNotice(int qnaNo) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}

	// [글쓴이] QnA 수정
	public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "UPDATE qna SET qna_category=?, qna_title=?, qna_content=?, qna_secret=?, member_no=?, update_date=NOW() WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		stmt.setInt(6, qna.getQnaNo());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
			
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [회원, 관리자] QnA 글쓰기 페이지
	public void insertQna(Qna qna) throws ClassNotFoundException, SQLException {
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO qna(qna_no, qna_category, qna_title, qna_content, qna_secret, member_no, create_date, update_date) VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qna.getQnaNo());
		stmt.setString(2, qna.getQnaCategory());
		stmt.setString(3, qna.getQnaTitle());
		stmt.setString(4, qna.getQnaContent());
		stmt.setString(5, qna.getQnaSecret());
		stmt.setInt(6, qna.getMemberNo());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		
	}
	
	// [회원, 관리자] QnA 상세보기 페이지
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		Qna qna = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT qna_no qnaNo, qna_title qnaTitle, qna_content qnaContent, member_no memberNo, qna_secret qnaSecret, create_date createDate FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setMemberNo(rs.getInt("MemberNo"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setCreateDate(rs.getNString("createDate"));
			return qna;
		}
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		System.out.println("rs : "+rs);
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return qna;
	}
	
	
	// 페이징 구현
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
		String sql = "SELECT COUNT(*) from qna";
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
		
	// [비회원, 회원, 관리자] QnA 게시판 리스트
	public ArrayList<Qna> selectQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<Qna>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql="SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo, create_date createDate, update_date updateDate FROM qna ORDER BY create_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// QnA 값 가져오기
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}