package kr.co.farmstory1.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory1.bean.ArticleBean;
import kr.co.farmstory1.bean.FileBean;
import kr.co.farmstory1.db.DBHelper;
import kr.co.farmstory1.db.Sql;

public class ArticleDAO extends DBHelper {
	//로그
	Logger logger = LoggerFactory.getLogger(this.getClass());
	//싱글톤
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO () {}
		
	//글쓰기
	public int insertArticle(ArticleBean article) {
		int parent = 0;
		try {
			logger.debug("insertArticle Start");
			conn = getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, article.getCate());
			psmt.setString(2, article.getTitle());
			psmt.setString(3, article.getContent());
			psmt.setInt(4, article.getFname() == null ? 0:1);
			psmt.setString(5, article.getUid());
			psmt.setString(6, article.getRegip());
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			conn.commit();
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("insertArticle End");
		return parent;
	}
	//파일등록
	public void insertFile(int parent, String fname, String newFname) {
		try {
			conn = getConnection();
			logger.debug("insertFile Start");
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newFname);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("insertFile End");
	}
	//글보기
	public ArticleBean selectArticle(String no) {
		ArticleBean article = null;
		try {
			conn = getConnection();
			logger.debug("selectArticle Start");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `board_article` where `no`="+no);
			if(rs.next()) {
				article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectArticle End");
		return article;
	}
	//파일 속성불러오기
	public FileBean selectFile(String no) {
		FileBean fb = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			if(rs.next()) {
				fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return fb;
	}
	//Index 최신글보기
	public List<ArticleBean> selectLatest() {
		List<ArticleBean> latest = new ArrayList<>();
		try {
			logger.debug("selectLatest Start");
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_LATESTS);
			while(rs.next()) {
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setTitle(rs.getString(2));
				ab.setRdate(rs.getString(3).substring(2,10));
				latest.add(ab);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectLatest End : " + latest.size());
		return latest;
	}
	//Index 최신글보기2
	public List<ArticleBean> selectLatest(String cate){
		List<ArticleBean> latest = new ArrayList<>();
		try {
			logger.debug("selectLatest2 Start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_LATEST);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setTitle(rs.getString(2));
				ab.setRdate(rs.getString(3).substring(2,10));
				latest.add(ab);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectLatest2 End : " + latest.size());
		return latest;
	}
	//조회수
	public void updateArticleHit(String no) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	//다운로드횟수
	public void updateFileHit(String fno) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_FILE_HIT);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	//글목록
	public List<ArticleBean> selectArticles(String cate,int start) {
		List<ArticleBean> articles = new ArrayList<>();
		try {
			conn = getConnection();
			logger.debug("selectArticles Start");
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, start);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleBean article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				articles.add(article);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectArticles End");
		return articles;
	}
	//전체 게시물 갯수
	public int selectCountTotal(String cate) {
		int result = 0;
		try {
			conn = getConnection();
			logger.debug("selectCountTotal Start");
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("selectCountTotal End");
		return result;
	}
	//글수정
	public void updateArticle(ArticleBean article) {
		try {
			conn = getConnection();
			logger.debug("updateArticle Start");
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getNo());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("updateArticle End");
	}
	//글삭제
	public void deleteArticle(String no) {
		try {
			conn = getConnection();
			logger.debug("deleteArticle Start");
			psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			psmt.close();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("deleteArtice End");
	}
	//파일삭제
	public String deleteFile(String no) {
		logger.debug("delete File Start");
		String newName = null;
		try {
			conn = getConnection();
			logger.debug("deleteFile Start");
			conn.setAutoCommit(false);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			psmt = conn.prepareStatement(Sql.DELETE_FILE);
			psmt2.setString(1, no);
			psmt.setString(1, no);
			rs = psmt2.executeQuery();
			psmt.executeUpdate();
			conn.commit();
			if(rs.next()) {
				newName = rs.getString(3);
			}
			psmt2.close();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("delete File : "+newName);
		return newName;
	}
}
