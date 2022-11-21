package kr.co.farmstory1.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory1.bean.ArticleBean;
import kr.co.farmstory1.bean.TermsBean;
import kr.co.farmstory1.bean.UserBean;
import kr.co.farmstory1.db.DBHelper;
import kr.co.farmstory1.db.Sql;

public class UserDAO extends DBHelper {
	//로그
	Logger logger = LoggerFactory.getLogger(this.getClass());
	//싱글톤
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO () {}
	
	//회원가입
	public void insertUser(UserBean user) {
		try {
			logger.debug("회원가입 Start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_USER);
			psmt.setString(1, user.getUid());
			psmt.setString(2, user.getPass());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getNick());
			psmt.setString(5, user.getEmail());
			psmt.setString(6, user.getHp());
			psmt.setString(7, user.getZip());
			psmt.setString(8, user.getAddr1());
			psmt.setString(9, user.getAddr2());
			psmt.setString(10, user.getRegip());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			logger.debug(e.getMessage());
		}
		logger.debug("회원가입 End");
	}
	//로그인 확인
	public UserBean selectUser(String uid, String pass) {
		UserBean user = null;
		try {
			logger.debug("로그인체크 Start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			if(rs.next()) {
				user = new UserBean();
				user.setUid(rs.getString(1));
				user.setPass(rs.getString(2));
				user.setName(rs.getString(3));
				user.setNick(rs.getString(4));
				user.setEmail(rs.getString(5));
				user.setHp(rs.getString(6));
				user.setGrade(rs.getInt(7));
				user.setZip(rs.getString(8));
				user.setAddr1(rs.getString(9));
				user.setAddr2(rs.getString(10));
				user.setRegip(rs.getString(11));
				user.setRdate(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("로그인성공 : "+user);
		return user;
	}
	//약관 가져오기
	public TermsBean selectTerms() {
		TermsBean terms = null;
		try {
			logger.debug("selectTerms Start");
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_TERMS);
			if(rs.next()) {
				terms = new TermsBean();
				terms.setTerms(rs.getString(1));
				terms.setPrivacy(rs.getString(2));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectTerms End");
		return terms;
	}
}
