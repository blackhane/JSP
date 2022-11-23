package kr.co.jboard2.db;

public class Sql {

	//회원가입
	public static final String INSERT_USER = "INSERT INTO `board_users` SET "
																			+ "`uid`=?,"
																			+ "`pass`=SHA2(?,256),"
																			+ "`name`=?,"
																			+ "`nick`=?,"
																			+ "`email`=?,"
																			+ "`hp`=?,"
																			+ "`zip`=?,"
																			+ "`addr1`=?,"
																			+ "`addr2`=?,"
																			+ "`regip`=?,"
																			+ "`rdate`=now()";
	
	//약관내용
	public static final String SELECT_TERMS = "SELECT * FROM  `board_terms`";
		
	//로그인 아이디, 비밀번호 체크
	public static final String SELECT_USER = "SELECT * FROM `board_users`  WHERE  `uid`=? AND `pass`=SHA2(?,256)";
	
	//아이디 중복체크
	public static final String SELECT_COUNT_UID = "SELECT COUNT(`uid`) FROM `board_users` WHERE `uid`=?";
	
	//별명 중복체크
	public static final String SELECT_COUNT_NICK = "SELECT COUNT(`nick`) FROM `board_users` WHERE `nick`=?";
	
	//아이디찾기
	public static final String SELECT_FIND_USER = "SELECT `name`,`uid`,`email`,`rdate` FROM `board_users` WHERE `name`=? AND `email`=?";
	
	//비밀번호찾기
	public static final String SELECT_FIND_PASSWORD = "SELECT COUNT(`uid`) FROM `board_users` WHERE `uid`=? AND `email`=?";
	
	//비밀번호변경
	public static final String UPDATE_USER_PASSWORD = "update `board_users` set `pass`=SHA2(?,256) where `uid`=?";
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//글쓰기
	public static final String INSERT_ARTICLE = "INSERT INTO `board_article` SET "
																			+ "`title`=?,"
																			+ "`content`=?,"
																			+ "`file`=?,"
																			+ "`uid`=?,"
																			+ "`regip`=?,"
																			+ "`rdate`=NOW()";
	
	//리스트
	public static final String  SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `board_article` AS a JOIN `board_users` AS b ON a.uid = b.uid WHERE `parent`=0 ORDER BY `no` DESC";
	
	
	
	
	
	
	
	
	
	
	public static final String INSERT_FILE = "INSERT INTO `board_file` SET "
																			+ "`parent`=?,"
																			+ "`newName`=?,"
																			+ "`oriName`=?,"
																			+ "`rdate`=NOW()";
	
	public static final String INSERT_COMMENT = "";
	
	public static final String SELECT_MAX_NO = "SELECT MAX(`no`) FROM `board_article`";
	//전체 게시물 갯수
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article` WHERE `parent`=0 and `cate`=?";
	
	
	public static final String SELECT_ARTICLE = "SELECT a.*,b.`fno`,b.`oriName`,b.`download` "
																			+ "FROM `board_article` AS a "
																			+ "LEFT JOIN `board_file` AS b "
																			+ "ON a.`no` = b.`parent`"
																			+ "WHERE `no`= ?";
	
	public static final String SELECT_COMMENTS = "SELECT a.*, b.nick FROM `board_article` AS a "
																			+ "JOIN `board_users` AS b USING (`uid`) "
																			+ "WHERE `parent`=? ORDER BY `no` asc";
	
	public static final String SELECT_LATESTS  = "(SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='grow' ORDER BY `no` DESC LIMIT 5) "
														+ "UNION (SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='school' ORDER BY `no` DESC LIMIT 5) "
														+ "UNION (SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='story' ORDER BY `no` DESC LIMIT 5) ";
	
	public static final String SELECT_LATEST = "SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`=? ORDER BY `no` DESC LIMIT 3";
	
	public static final String SELECT_FILE = "SELECT * FROM `board_file` WHERE `fno`=?";

	public static final String SELECT_FILE_WITH_PARENT  = "SELECT * FROM `board_file` WHERE `parent`=?";
	//조회수
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit`=`hit`+1 WHERE `no`=?";
	//다운로드횟수
	public static final String UPDATE_FILE_HIT = "update `board_file` set `download`=`download`+1 where `fno`=?";
	
	public static final String UPDATE_COMMENT_HIT_UP = "UPDATE `board_article` SET  `comment` = `comment`+1 WHERE `no`= ?";
	
	public static final String UPDATE_COMMENT_HIT_DOWN = "UPDATE `board_article` SET `comment` = `comment`-1 WHERE `no`=?";
	
	public static final String UPDATE_FILE_DOWNLOAD = "UPDATE `board_file` SET `download`=`download`+1 WHERE `fno`=?";	

	public static final String UPDATE_COMMENT = "UPDATE `board_article` SET `content`=?, `rdate`=NOW() WHERE `no`=?";

	public static final String UPDATE_ARTICLE = "UPDATE `board_article` SET `title`=?, `content`=?, `rdate`=NOW() WHERE `no`=?";
	
	public static final String DELETE_COMMENT = "DELETE FROM `board_article` WHERE `no`=?";

	public static final String DELETE_ARTICLE = "DELETE FROM `board_article` WHERE `no`=? OR `parent`=?";
	
	public static final String DELETE_FILE = "DELETE FROM `board_file` WHERE `parent`=?";
	
}
