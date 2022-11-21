package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBC {

	private static JDBC instance = new JDBC();
	
	public static JDBC getInstance() {
		return instance;
	}
	private JDBC(){}
	
	private final String HOST = "jdbc:mysql://127.0.0.1:3306/java1_shop";
	private final String USER = "root";
	private final String PASS = "1234";
	
	public Connection getConnetction() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(HOST, USER, PASS);
	}
}
