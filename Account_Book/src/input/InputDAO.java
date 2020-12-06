package input;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class InputDAO {
	private Connection conn;
	private PreparedStatement pstmt;//보안을 위해 사용
	private ResultSet rs;
	
	public InputDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:/";
			String dbID = "";
			String dbPassword = "";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int inputinsert(String userID, String category, String content, int money, String Date) {
		String SQL = "insert into input values(?, ?, ?, ?, ?, ?)";
		
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
		String SQL = "select inputid from input order by inputid desc";
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
	
	public ArrayList<Input> getList(int pageNumber, String userID){
		String SQL = "select * from input where inputID < ? and id = ? order by inputID desc limit 10";
		ArrayList<Input> list = new ArrayList<Input>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);//게시글 갯수
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Input input = new Input();
				input.setInputid(rs.getInt(1));
				input.setUserID(rs.getString(2));
				input.setCategory(rs.getString(3));
				input.setContent(rs.getString(4));
				input.setMoney(rs.getInt(5));
				input.setWebDate(rs.getString(6));
				list.add(input);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}//게시글 불러오기
	
	public boolean nextPage(int pageNumber, String userID) {
		String SQL = "select * from input where inputid < ? and id = ?";// order by bbsID desc limit 10";
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
	
	public Input getInput(int inputID) {
		String SQL = "select * from input where inputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, inputID);//클릭한 게시글 읽기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Input input = new Input();
				input.setInputid(rs.getInt(1));
				input.setUserID(rs.getString(2));
				input.setCategory(rs.getString(3));
				input.setContent(rs.getString(4));
				input.setMoney(rs.getInt(5));
				input.setWebDate(rs.getString(6));
				return input;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int delete(int inputID, String userID) {
		String SQL = "delete from input where inputID = ? and id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, inputID);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int update(int inputID, String category, String content, int money, String webDate) {
		String SQL = "update input set category = ?, content = ?, money = ?, date = ? where inputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setString(2, content);
			pstmt.setInt(3, money);
			pstmt.setString(4, webDate);
			pstmt.setInt(5, inputID);
			return pstmt.executeUpdate(); //첫번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int getmoney(int inputid) {
		String SQL = "select money from input where inputid = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, inputid);
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
