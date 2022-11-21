package JDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletContext;

public class JDBC {
	public Connection conn;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	public JDBC() {
		try {
			//드라이버로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			//데이터베이스 연결
			String url = "jdbc:mysql://127.0.0.1:3306/book_database";
			String id = "root";
			String pwd = "1234";
			
			conn = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공1!!!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public JDBC(String driver, String url, String id, String pwd) {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공2!!!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public JDBC(ServletContext application) {
		try {
			
			String driver = application.getInitParameter("MySqlDriver");
			Class.forName(driver);
			
			String url = application.getInitParameter("MySqlURL");
			String id = application.getInitParameter("MySqlId");
			String pwd= application.getInitParameter("MySqlPwd");
			conn = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공3!!!");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(psmt != null)
				psmt.close();
			if(conn != null)
				conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
