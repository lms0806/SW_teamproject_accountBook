package output;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class OutputDAO {
	private Connection conn;
	private PreparedStatement pstmt;//보안을 위해 사용
	private ResultSet rs;
	
	public OutputDAO() {
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
	
	public int outputinsert(String userID, String category, String content, int money, String Date) {
		String SQL = "insert into output values(?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, category);
			pstmt.setString(4, content);
			pstmt.setInt(5, money);
			pstmt.setString(6, Date);
			System.out.println(content);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "select outputid from output order by outputid desc";
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
	
	public ArrayList<Output> getList(int pageNumber, String userID){
		String SQL = "select * from output where outputID < ? and id = ? order by outputID desc limit 10";
		ArrayList<Output> list = new ArrayList<Output>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);//게시글 갯수
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Output output = new Output();
				output.setOutputid(rs.getInt(1));
				output.setUserID(rs.getString(2));
				output.setCategory(rs.getString(3));
				output.setContent(rs.getString(4));
				output.setMoney(rs.getInt(5));
				output.setWebDate(rs.getString(6));
				list.add(output);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}//게시글 불러오기
	
	public boolean nextPage(int pageNumber, String userID) {
		String SQL = "select * from output where outputid < ? and id = ?";// order by bbsID desc limit 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);//게시글 갯수
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}//다음 게시글이 없으면 안넘어감
	
	public Output getOutput(int outputID) {
		String SQL = "select * from output where outputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, outputID);//클릭한 게시글 읽기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Output output = new Output();
				output.setOutputid(rs.getInt(1));
				output.setUserID(rs.getString(2));
				output.setCategory(rs.getString(3));
				output.setContent(rs.getString(4));
				output.setMoney(rs.getInt(5));
				output.setWebDate(rs.getString(6));
				return output;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int outputID, String userID) {
		String SQL = "delete from output where outputID = ? and id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, outputID);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int update(int outputID, String category, String content, int money, String webDate) {
		String SQL = "update output set category = ?, content = ?, money = ?, date = ? where outputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setString(2, content);
			pstmt.setInt(3, money);
			pstmt.setString(4, webDate);
			pstmt.setInt(5, outputID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getmoney(int outputid) {
		String SQL = "select money from output where outputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, outputid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}//게시판 순서 번호
}
