package config;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCP {

	public static Connection getJava1dbConnection() throws NamingException, SQLException {
		//1단계 - JNDI 서비스 객체생성
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		//2단계 - 커넥션 풀에서 커넥션 얻기
		DataSource ds = (DataSource)ctx.lookup("dbcp_java1db");
		return ds.getConnection();
	}
	
	public static Connection getCustomerConnection() throws NamingException, SQLException {
		//1단계 - JNDI 서비스 객체생성
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		//2단계 - 커넥션 풀에서 커넥션 얻기
		DataSource ds = (DataSource)ctx.lookup("dbcp_java1db_Shopping");
		return ds.getConnection();
	}
}
