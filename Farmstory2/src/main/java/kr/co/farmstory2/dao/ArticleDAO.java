package kr.co.farmstory2.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.swing.tree.ExpandVetoException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.Sql;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;



public class ArticleDAO extends DBHelper {

	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO () {}
	
	//로거 생성
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//글쓰기
	public int insertArticle(ArticleVO vo) {
		int parent = 0;
		try {
			logger.info("insertArticle start");
			conn = getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setInt(3, vo.getFname() == null ? 0:1);
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			psmt.setString(6, vo.getCate());
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			conn.commit();
			if(rs.next()) {
				parent = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("parent : " + parent);
		return parent;
	}
	
	//파일쓰기
	public void insertFile(int parent, String fname, String newFname) {
		try {
			logger.info("insertFile start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newFname);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	public void insertFile(String parent, String fname, String newFname) {
		try {
			logger.info("insertFile start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setString(1, parent);
			psmt.setString(2, newFname);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//댓글쓰기
	public int insertComment(String parent, String content, String uid, String regip) {
		int result = 0;
		try {
			logger.info("insertComment start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_COMMENT);
			psmt.setString(1, parent);
			psmt.setString(2, content);
			psmt.setString(3, uid);
			psmt.setString(4, regip);
			result = psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	//글보기
	public ArticleVO selectArticle(String no) {
		ArticleVO vo = null;
		try {
			logger.info("selectArticle start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setFno(rs.getInt(12));
				vo.setOriName(rs.getString(13));
				vo.setDownload(rs.getInt(14));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	//메인화면 최신글 보기 (농작물이야기)
	public List<ArticleVO> selectLatest(String cate) {
		List<ArticleVO> latest = new ArrayList<>();
		try {
			logger.debug("selectLatest Start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_LATESTS);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
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
	
	//메인화면 최신글 보기 (커뮤니티)
	public List<ArticleVO> selectLatest2(String cate){
		List<ArticleVO> latest = new ArrayList<>();
		try {
			logger.debug("selectLatest2 Start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_LATEST2);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
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
	
	//파일다운로드
	public FileVO selectFile(String fno) {

		FileVO fb = null;
		try{
			logger.info("selectFile start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, fno);
			rs =  psmt.executeQuery();
			if(rs.next()){
				fb = new FileVO();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setrDate(rs.getString(6));
			}
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return fb;
	}
	
	//다운로드 카운트+1
	public void updateFileDownload(String fno) {
		try{
			logger.info("updateFileDownload start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_FILE_HIT);
			psmt.setString(1, fno);
			psmt.executeUpdate();
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	
	//댓글목록
	public List<ArticleVO> selectComment(String no) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectComment start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(2,10));
				vo.setNick(rs.getString(12));
				articles.add(vo);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("articles : " + articles.size());
		return articles;
	}
	
	//게시물리스트
	public List<ArticleVO> selectArticles(String cate, int start) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticles start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, start);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(0,10));
				vo.setNick(rs.getString(12));
				articles.add(vo);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	 
	//전체 게시물 개수
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
		return result;
	}
	
	public int selectCountTotal(String cate, String search) {
		int result = 0;
		try {
			conn = getConnection();
			logger.debug("selectCountTotal Start");
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_BY_KEYWORD);
			psmt.setString(1, "%"+search+"%");
			psmt.setString(2, cate);
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
	
	//게시물리스트(검색)
	public List<ArticleVO> selectArticleByKeyWord(String cate, int start, String keyword) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticleByKeyWord start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLE_BY_KEYWORD);
			psmt.setString(1, "%"+keyword+"%");
			psmt.setString(2, "%"+keyword+"%");
			psmt.setString(3, cate);
			psmt.setInt(4, start);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11).substring(0,10));
				vo.setNick(rs.getString(12));
				articles.add(vo);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	//조회수
	public void updateArticleHit(String no) {
		try {
			logger.info("updateArticleHit start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//댓글수+1
	public void updateCommentHit(String no) {
		try {
			logger.info("updateCommentHit start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_COMMENT_HIT_UP);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//댓글수-1
	public void updateCommentHitDown(String no) {
		try {
			logger.info("updateCommentHitDown start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_COMMENT_HIT_DOWN);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//글수정
	public void updateArticle(String no, String title, String content) {
		try {
			logger.info("updateArticle start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//글수정시 파일 추가
	public void updateArticleFile(String no) {
		try {
			logger.info("updateArticleFile start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_FILE);
			psmt.setString(1, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//댓글수정
	public int updateComment(String content, String no) {
		int result = 0;
		
		try {
			conn = getConnection();
			psmt  = conn.prepareStatement(Sql.UPDATE_COMMENT);
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
	
	//글삭제
	public void deleteArticle(String no) {
		try {
			logger.info("deleteArticle start");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//파일삭제 + 저장된 파일 이름 가져오기
	public String deleteFile(String no) {
		String newName = null;
		try {
			logger.info("deleteFile start");
			conn = getConnection();
			conn.setAutoCommit(false);
			psmt = conn.prepareStatement(Sql.DELETE_FILE);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.SELECT_FILE_WITH_PARENT);
			psmt.setString(1, no);
			psmt2.setString(1, no);
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
		logger.debug("newName : " + newName);
		return newName;
	}
	
	//댓글 삭제
	public int deleteComment(String no,String parent) {
		int result = 0;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_COMMENT_HIT_DOWN);
			psmt.setString(1, no);
			psmt2.setString(1, parent);
			psmt2.executeUpdate();
			result = psmt.executeUpdate();
			psmt2.close();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
