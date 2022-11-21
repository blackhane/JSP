package kr.co.jboard1.db;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCP {

	public static Connection getConnection() throws NamingException, SQLException {
		//1단계 - JNDI 서비스 객체생성
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		//2단계 - 커넥션 풀에서 커넥션 얻기
		DataSource ds = (DataSource)ctx.lookup("dbcp_java1_board");
		
		return ds.getConnection();
	}
}
