package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.bean.FileBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.Sql;

public class ArticleDAO {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	//싱글톤
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getinstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	//기본 CRUD
	public int insertArticle(ArticleBean article) {
		int parent = 0;
		try{
			logger.info("insertArticle Start...");
			Connection conn = DBCP.getConnection();
			//트랜잭션
			conn.setAutoCommit(false); 
			
			Statement stmt = conn.createStatement();
			PreparedStatement psmt = conn. prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFname() == null ? 0 : 1);
			psmt.setString(4, article.getUid());
			psmt.setString(5, article.getRegip());
			
			psmt.executeUpdate(); //INSERT
			ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_NO); //SELECT
			
			conn.commit(); 
			//트랜잭션
			
			if(rs.next()){
				parent = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return parent;
	}
	
	public void insertFile(int parent, String newFname, String fname) {
		try{
			logger.info("insertFile Start...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt= conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);//글번호
			psmt.setString(2, newFname);//새파일이름
			psmt.setString(3, fname);//기존파일이름
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public ArticleBean insertComment(ArticleBean comment) {
		
		ArticleBean article = null;
		
		try{
			Connection conn = DBCP.getConnection();
			
			conn.setAutoCommit(false);
			
			String sql1 = "INSERT INTO `board_article`(`parent`, `content`, `uid`, `regip`, `rdate`) VALUES (?,?,?,?,NOW())";
			String sql2 = "SELECT a.*, b.nick FROM `board_article` AS a JOIN `board_users` AS b USING (`uid`) WHERE `parent` !=0 ORDER BY `no` DESC LIMIT 1";
			
			PreparedStatement psmt = conn.prepareStatement(sql1);
			Statement stmt = conn.createStatement();
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_HIT_UP);
			
			psmt.setInt(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			psmt2.setInt(1, comment.getParent());
			psmt.executeUpdate();
			psmt2.executeUpdate();
			ResultSet rs =  stmt.executeQuery(sql2);

			conn.commit();
			
			if(rs.next()) {
				article = new ArticleBean();
				article.setNo(rs.getInt(1));
				article.setParent (rs.getInt(2));
				article.setContent(rs.getString(6));
				article.setrDate(rs.getString(11).substring(2,10));
				article.setNick(rs.getString(12));
			}
			
			rs.close();
			stmt.close();
			psmt.close();
			psmt2.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return article;
	}
	
	public List<ArticleBean> selectArticles(int start) {
		List<ArticleBean> articles = new ArrayList<>();
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1, start);
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setrDate(rs.getString(11));
				ab.setNick(rs.getString(12));
				articles.add(ab);
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articles;
	}
	
	public ArticleBean selectArticle(String no) {
		ArticleBean article = null;
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()){
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
				article.setrDate(rs.getString(11));
				article.setFno(rs.getInt(12));
				article.setOriName(rs.getString(13));
				article.setDownload(rs.getInt(14));
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return article;
	}
	
	//전체 게시물 카운트
	public int selectCountTotal() {
		int total = 0;
		try {
			Connection conn =  DBCP.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			if(rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return total;
	}
	
	public FileBean selectFile(String fno) {

		FileBean fb = null;
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fno);
			ResultSet rs =  psmt.executeQuery();
			if(rs.next()){
				fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setrDate(rs.getString(6));
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return fb;
	}
	
	public List<ArticleBean> selectComments(String parent) {
		List<ArticleBean> comments = null;
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			ResultSet rs = psmt.executeQuery();
			comments = new ArrayList<>();
			while(rs.next()) {
				ArticleBean comment = new ArticleBean();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setrDate(rs.getString(11).substring(2,10));
				comment.setNick(rs.getString(12));
				comments.add(comment);
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return comments;
	}
	
	public void updateArticleHit(String no) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void updateFileDownload(String fno) {
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int updateComment(String content, String no) {
		int result = 0;
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt  = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
			result = psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public void updateArticle(String no,String title, String content) {
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int deleteComment(String no,String parent) {
		int result = 0;
		try {
			Connection conn  = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_HIT_DOWN);
			psmt.setString(1, no);
			psmt2.setString(1, parent);
			psmt2.executeUpdate();
			result = psmt.executeUpdate();
			psmt.close();
			psmt2.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public void deleteArticle(String no) {
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String deleteFile(String no) {
		String newName = null;
		try {
			Connection conn = DBCP.getConnection();
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.DELETE_FILE);
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			ResultSet rs = psmt1.executeQuery();
			psmt2.executeUpdate();
			conn.commit();
			if(rs.next()) {
				newName = rs.getString(3);
			}
			psmt1.close();
			psmt2.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return newName;
	}

}
