package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.QnaComment;

public class QnaCommentDao {

	// [관리자] QnA 댓글 쓰기
	public void insertCommentDao(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, create_date, update_date) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
 		conn.close();
	}
	
	// [회원, 비회원] QnA 게시판 댓글 읽기 페이지
	public ArrayList<QnaComment> selectQnaCommentList(int qnaNo, int commentbeginRow, int commentrowPerPage) throws ClassNotFoundException, SQLException {
	ArrayList<QnaComment> list = new ArrayList<QnaComment>();
	
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT qna_no qnaNo, qna_comment_content qnaCommentContent, member_no memberNo, create_date createdate, update_date updateDate FROM qna_comment WHERE qna_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.setInt(2, commentbeginRow);
		stmt.setInt(3, commentrowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			QnaComment qnacomment = new QnaComment();
			qnacomment.setQnaNo(rs.getInt("qnaNo"));
			qnacomment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnacomment.setMemberNo(rs.getInt("memberNo"));
			qnacomment.setCreateDate(rs.getString("createDate"));
			qnacomment.setUpdateDate(rs.getString("updateDate"));
			list.add(qnacomment);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
