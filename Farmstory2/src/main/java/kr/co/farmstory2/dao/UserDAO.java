package kr.co.farmstory2.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.Sql;
import kr.co.farmstory2.vo.TermsVo;
import kr.co.farmstory2.vo.UserVO;

public class UserDAO extends DBHelper {

	//싱글톤
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO () {}
	
	//로그
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//회원가입
	public void insertUser(UserVO vo){
		try {
			logger.info("insertUser start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_USER);
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getPass());
			psmt.setString(3, vo.getName());
			psmt.setString(4, vo.getNick());
			psmt.setString(5, vo.getEmail());
			psmt.setString(6, vo.getHp());
			psmt.setString(7, vo.getZip());
			psmt.setString(8, vo.getAddr1());
			psmt.setString(9, vo.getAddr2());
			psmt.setString(10, vo.getRegip());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//아이디 중복확인
	public int selectCountUid(String uid) {
		int result = 0;
		try {
			logger.info("selectCountUid start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_UID);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	//별명 중복확인
	public int selectCountNick(String nick) {
		int result = 0;
		try {
			logger.info("selectCountNick start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	//아이디 찾기
	public UserVO selectFindId(String name, String email) {
		UserVO vo = null;
		try {
			logger.info("selectFindId start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FIND_USER);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new UserVO();
				vo.setName(rs.getString(1));
				vo.setUid(rs.getString(2));
				vo.setEmail(rs.getString(3));
				vo.setRdate(rs.getString(4).substring(0,16));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	//비밀번호 찾기
	public int selectFindPw(String uid, String email) {
		int result = 0;
		try {
			logger.info("selectFindId start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FIND_PASSWORD);
			psmt.setString(1, uid);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}

	//로그인
	public UserVO selectUser(String uid, String pass) {
		UserVO vo = null;
		try {
			logger.info("selectUser start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getString(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	//약관
	public TermsVo selectTerms() {
		TermsVo vo = null;
		try {
			logger.info("selectTerms start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_TERMS);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new TermsVo();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	//비밀번호변경
	public int updateUserPass(String pass, String uid) {
		int result = 0;
		try {
			logger.info("updateUserPass start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_USER_PASSWORD);
			psmt.setString(1, pass);
			psmt.setString(2, uid);
			result = psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
		
	public void selectUsers(){}
	public void updateUser(){}
	public void deleteUser(){}
}
