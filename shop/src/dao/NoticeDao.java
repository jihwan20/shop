package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Notice;


public class NoticeDao {
	
	// [회원, 관리자] 최근 공지사항 목록
		public ArrayList<Notice> selectNewEbookList() throws ClassNotFoundException, SQLException {
			// ArrayList 생성
			ArrayList<Notice> list = new ArrayList<>();
			
			// MariaDB 연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 디버깅 코드
			System.out.println("conn : "+conn);
			
			// 쿼리문 작성
			String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT 0, 5";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			
			// 디버깅 코드	
			System.out.println("stmt : "+stmt);
			
			// 카테고리 값 가져오기
			while(rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			list.add(notice);
			}
			
			// 연결 끊기
			rs.close();
			stmt.close();
			conn.close();
			return list;
					
		}
	
	// [관리자] 공지사항 삭제
	public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [관리자] 공지사항 수정
	public void updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "UPDATE notice SET notice_title=?, notice_content=?, update_date=NOW() WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		stmt.executeUpdate();
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [비회원, 회원, 관리자] 공지사항 상세보기 페이지
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		Notice notice = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		String sql = "SELECT notice_no noticeNo , notice_title noticeTitle, notice_content noticeContent, create_date createDate FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setCreateDate(rs.getNString("createDate"));
			return notice;
		}
		return notice;
	}
	
	// [관리자] 공지사항 추가
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, create_date, update_date) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		stmt.executeUpdate();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
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
		String sql = "SELECT COUNT(*) from notice";
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
	
	// [회원, 비회원, 관리자] 공지사항 리스트
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		
		// ArrayList 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql="SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 공지사항 값 가져오기
		while(rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			list.add(notice);
		}
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
