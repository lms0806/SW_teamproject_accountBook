package input;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class InputDAO {
	private Connection conn;
	private PreparedStatement pstmt;//보안을 위해 사용
	private ResultSet rs;
	
	public InputDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/account_book?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "3510";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int inputinsert(String userID, String category, String Content, int money, String Date) {
		String SQL = "insert into input values(?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, category);
			pstmt.setString(3, Content);
			pstmt.setInt(4, money);
			pstmt.setString(5, Date);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
}
