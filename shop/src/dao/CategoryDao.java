package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// [관리자] 카테고리 사용 유/무 수정
	public void updateCategoryState(Category category) throws SQLException, ClassNotFoundException {
		
		// 디버깅 코드
		System.out.println(category.getCategoryName()+ " <-- categoryName");
		System.out.println(category.getCategoryState()+ " <-- categoryState");
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "UPDATE category SET category_state=?, update_date=NOW()  WHERE category_name=? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryState());
		stmt.setString(2, category.getCategoryName());
		stmt.executeUpdate();
		
		// 디버깅 코드
		System.out.println("stmt : "+stmt);
		
		// 연결 끊기
		stmt.close();
		conn.close();
	}
	
	// [관리자] 카테고리 이름 중복 검사
	public String SelectCategoryName(String categoryNameCheck) throws SQLException, ClassNotFoundException {
		
		// 변수 선언
		String categoryName = null;
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);
		ResultSet rs = stmt.executeQuery();
		
		// categoryNameCheck 값 넣기
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		
		// null이 나오면 사용가능한 카테고리
		// null이 아니면 이미 사용중인 카테고리
		return categoryName;
	}

	// [관리자] 카테고리 리스트
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException {
		ArrayList<Category> CategoryList = new ArrayList<Category>();
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
								
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "SELECT category_name categoryName, update_date updateDate, create_date createDate, category_state categoryState FROM category ORDER BY create_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
		
		// 카테고리 값 가져오기
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryName(rs.getString("CategoryName"));
			category.setUpdateDate(rs.getString("UpdateDate"));
			category.setCreateDate(rs.getString("CreateDate"));
			category.setCategoryState(rs.getString("CategoryState"));
			CategoryList.add(category);
		}
		
		// 연결 끊기
		rs.close();
		stmt.close();
		conn.close();
		
		return CategoryList;
	}
	
	
	// [관리자] 카테고리 추가
	public void insertCategory(Category category) throws ClassNotFoundException, SQLException {
		
		// 디버깅 코드
		System.out.println(category.getCategoryName()+ " <-- categoryName");
		
		// MariaDB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 디버깅 코드
		System.out.println("conn : "+conn);
		
		// 쿼리문 작성
		String sql = "INSERT INTO category(category_name, update_date, create_date, category_state) VALUES(?, NOW(), NOW(), 'Y')";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.executeUpdate();
		
		// 디버깅 코드	
		System.out.println("stmt : "+stmt);
				
		// 연결 끊기
		stmt.close();
		conn.close();
	
	}

}
