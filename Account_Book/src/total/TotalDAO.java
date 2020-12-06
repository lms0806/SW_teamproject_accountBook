package total;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TotalDAO {
	private Connection conn;
	private PreparedStatement pstmt;//보안을 위해 사용
	private ResultSet rs;
	
	public TotalDAO() {
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
	
	public int insert(String userID) {
		String SQL = "insert into total values(?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, 0);
			pstmt.setInt(4, 0);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getinputmoney(String userID) {
		String SQL = "select inputmoney from total where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}//게시판 순서 번호
	
	public int updateinput(int money, String userID, int choice) {
		String SQL = "update total set inputmoney = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			if(choice == 1) {
				pstmt.setInt(1, getinputmoney(userID)+money);
			}
			else {
				pstmt.setInt(1, getinputmoney(userID)-money);
			}
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getoutputmoney(String userID) {
		String SQL = "select outputmoney from total where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}//게시판 순서 번호
	
	public int updateoutput(int money, String userID, int choice) {
		String SQL = "update total set outputmoney = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			if(choice == 1) {
				pstmt.setInt(1, getoutputmoney(userID)+money);
			}
			else {
				pstmt.setInt(1, getoutputmoney(userID)-money);
			}
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int changeinput(String userID, int firstmoney, int latermoney) {
		String SQL = "update total set inputmoney = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getinputmoney(userID) + latermoney - firstmoney);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int changeoutput(String userID, int firstmoney, int latermoney) {
		String SQL = "update total set outputmoney = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getoutputmoney(userID) + latermoney - firstmoney);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "select totalid from total order by totalid desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}//게시판 순서 번호
	
	public ArrayList<Total> getList(int pageNumber){
		String SQL = "select * from total where totalID < ? order by totalID desc limit 10";
		ArrayList<Total> list = new ArrayList<Total>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);//게시글 갯수
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Total total = new Total();
				total.setTotalid(rs.getInt(1));
				total.setId(rs.getString(2));
				total.setInputmoney(rs.getInt(3));
				total.setOutputmoney(rs.getInt(4));
				list.add(total);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}//게시글 불러오기
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from total where totalid < ?";// order by bbsID desc limit 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);//게시글 갯수
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}//다음 게시글이 없으면 안넘어감
}
