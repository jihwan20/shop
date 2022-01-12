package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	
	// [회원] 아이디 중복검사
	public String SelectMemberId(String memberIdCheck) throws SQLException, ClassNotFoundException {
		
		// 변수 선언
		String memberId = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberIdCheck);
		ResultSet rs = stmt.executeQuery();
		
		// memberId 값 넣기
		if(rs.next()) {
			memberId = rs.getString("memberId");
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		
		// null이 나오면 사용가능한 아이디
		// null이 아니면 이미 사용중인 아이디
		return memberId;
	}
	
	// [회원] 상세보기 페이지
	public Member selectMemeberOne(int memberNo) throws ClassNotFoundException, SQLException {
		
		// 변수 선언
		Member member = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT member_id memberId, member_pw memberPw, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// member 변수에 값 넣기
		while(rs.next()) {
			member = new Member();
			member.setMemberId(rs.getString("memberId"));
			member.setMemberPw(rs.getString("memberPw"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			return member;
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return member;
	}
	// [관리자] 회원 레벨 수정
	// MemberNo + 수정된 MemberLevel -> MeberLevel
	public void updateMemberLevelByAdmin(Member member, int memberNewLevel) throws SQLException, ClassNotFoundException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "UPDATE member SET member_level=? WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNewLevel);
		stmt.setInt(2, member.getMemberNo());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
 	// [관리자] 회원 비밀번호 수정
	// MemberNo + 수정된 MemberPw -> MeberPw
	public void updateMemberPwByAdmin(Member member, String memberNewPw) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		String sql = "UPDATE member SET member_pw=PASSWORD(?) WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberNewPw);
		stmt.setInt(2, member.getMemberNo());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [관리자] 회원 강제 탈퇴
	// MemberNo를 불러와서 삭제
	public void deleteMemberByAdmin(int memberNo) throws ClassNotFoundException, SQLException {
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "DELETE FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [관리자] 회원목록 출력
	public ArrayList<Member> selectMemberListAllBysearchMemberID(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
		ArrayList<Member> list = new ArrayList<Member>();
	
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
						
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*		 
		 * SELECT member_no memberNo, 
		 * member_id memberId, 
		 * member_level memberLevel, 
		 * member_name memberName, 
		 * member_age memberAge, 
		 * member_gender memberGender, 
		 * update_date updateDate, 
		 * create_date createDate
		 * FROM member 
		 * WHERE member_id LIKE ?
		 * ORDER BY create_date DESC LIMIT ?,?
		 */
		
		// 쿼리문 작성
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate "
				+ "FROM member WHERE member_id LIKE ? ORDER BY create_date desc LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
		}
		
	// [관리자] 라스트 페이지
	// ISSUE : 검색을 했을 때 totalCount 다르게 하기 해결
	public int selectLastPage(int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
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
		String sql = "";
		if(searchMemberId.equals("") == true) {
			sql = "SELECT COUNT(*) from member";
		} else {
			sql = "SELECT COUNT(*) from member WHERE member_id LIKE '%"+searchMemberId+"%'";
		}
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
	
	
	// [관리자] 회원목록 출력
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Member> list = new ArrayList<Member>();
	
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
						
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		/*		 
		 * SELECT member_no memberNo,
		 * member_id memberId,
		 * member_level memberLevel,
		 * member_name memberName,
		 * member_age memberAge,
		 * member_gender memberGender,
		 * update_date updateDate,
		 * create_date createDate
		 * FROM member
		 * ORDER BY create_date DESC LIMIT ?,?
		 */
		
		// 쿼리문 작성
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate "
				+ "FROM member ORDER BY create_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		System.out.println("rs : "+rs);
		
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
		}
	
	// [비회원] 회원가입
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		/*
		 * INSERT INTO member (
		 * member_id,
		 * member_pw, // 암호화
		 * member_level,
		 * member_name,
		 * member_age,
		 * member_gender,
		 * update_date,
		 * create_date)
		 * VALUES (
		 * ?, PASSWORD(?), 0, ?, ?, NOW(), NOW()
		 * )
		 */
		// 디버깅 코드
		System.out.println(member.getMemberId()+ " <--- memberId");
		System.out.println(member.getMemberPw()+ " <--- memberPw");
		System.out.println(member.getMemberName()+ " <---memberName");
		System.out.println(member.getMemberAge()+ " <--- memberAge");
		System.out.println(member.getMemberGender()+ " <--- memberGender");
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES(?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		stmt.executeUpdate();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	// [회원]
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		/*
		 * SELECT
		 * member_no memberNo,
		 * member_id memberId,
		 * member_level memberLevel
		 * FROM
		 * member
		 * WHERE member_id=? AND member_pw=PASSWORD(?)
		 */
		
		// 디버깅 코드
		System.out.println(member.getMemberId()+" <-- MemberDao.login param : memberId");
		System.out.println(member.getMemberPw()+" <-- MemberDao.login param : memberPw");
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문 작성
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_no memberNo FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		System.out.println("rs : "+rs);
		
		if(rs.next()) {
			Member returnMember = new Member();
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			returnMember.setMemberName(rs.getString("memberName"));
			returnMember.setMemberNo(rs.getInt("memberNo"));
			return returnMember;
		}
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return null;
	}
	
}
