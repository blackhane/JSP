package kr.co.farmstory2.db;

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
	
	//자동로그인
	public static final String SELECT_USER_BY_SESSID = "SELECT * FROM `board_users` WHERE `sessId`=? AND `sessLimitDate` > NOW()";
	
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
	
	//쿠키저장
	public static final String UPDATE_USER_FOR_SESSION = "UPDATE `board_users` SET `sessId`=?, `sessLimitDate`=DATE_ADD(NOW(), INTERVAL 3 DAY) WHERE `uid`=?";

	//쿠키삭제
	public static final String UPDATE_USER_FOR_SESSION_OUT = "UPDATE `board_users` SET `sessId`=NULL, `sessLimitDate`=NULL WHERE `uid`=?";
	
	//회원정보 수정
	public static final String UPDATE_USER = "UPDATE `board_users` SET `name`=?, `nick`=?, `email`=?, `hp`=?, `zip`=?, `addr1`=?, `addr2`=? WHERE `uid`=?";
	
	//회원탈퇴
	public static final String DELETE_USER = "UPDATE `board_users` SET `grade`= 0, `wdate`=NOW() WHERE `uid`=?";
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//글쓰기
	public static final String INSERT_ARTICLE = "INSERT INTO `board_article` SET "
																			+ "`title`=?,"
																			+ "`content`=?,"
																			+ "`file`=?,"
																			+ "`uid`=?,"
																			+ "`regip`=?,"
																			+ "`cate`=?, "
																			+ "`rdate`=NOW()";
	//제일 늦게 작성된 글 번호
	public static final String SELECT_MAX_NO = "SELECT MAX(`no`) FROM `board_article`";
	
	//전체 게시물 갯수 (페이징)
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article` WHERE `parent`=0 and `cate`=?";
		
	//파일쓰기
	public static final String INSERT_FILE = "INSERT INTO `board_file` SET "
																			+ "`parent`=?,"
																			+ "`newName`=?,"
																			+ "`oriName`=?,"
																			+ "`rdate`=NOW()";
	
	//댓글쓰기
	public static final String INSERT_COMMENT = "INSERT INTO `board_article`(`parent`, `content`, `uid`, `regip`, `rdate`) VALUES (?,?,?,?,NOW())";
	
	//리스트
	public static final String  SELECT_ARTICLES = "SELECT a.*, b.`nick` FROM `board_article` AS a JOIN `board_users` AS b ON a.uid = b.uid WHERE `parent`=0 AND `cate`=? ORDER BY `no` DESC LIMIT ?, 10";

	//리스트 (검색기능)
	public static final String  SELECT_ARTICLE_BY_KEYWORD = "SELECT a.*, b.`nick` FROM `board_article` AS a JOIN `board_users` AS b ON a.uid = b.uid WHERE `parent`=0 AND (`title` LIKE ? OR `nick` LIKE ?) ORDER BY `no` DESC";
	
	//글보기
	public static final String SELECT_ARTICLE = "SELECT a.*,b.`fno`,b.`oriName`,b.`download` FROM `board_article` AS a "
																			+ "LEFT JOIN `board_file` AS b "
																			+ "ON a.`no`=b.`parent` WHERE `no`=?";

	//메인화면 최신글 보기 (농작물리스트)
	public static final String SELECT_LATESTS  = "(SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='grow' ORDER BY `no` DESC LIMIT 5) "
										+ "UNION (SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='school' ORDER BY `no` DESC LIMIT 5) "
										+ "UNION (SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`='story' ORDER BY `no` DESC LIMIT 5) ";

	//메인화면 최신글 보기 (커뮤니티)
	public static final String SELECT_LATEST = "SELECT `no`,`title`,`rdate` FROM `board_article` WHERE `cate`=? ORDER BY `no` DESC LIMIT 3";
	
	//댓글 리스트
	public static final String SELECT_COMMENTS = "SELECT a.*, b.nick FROM `board_article` AS a "
																			+ "JOIN `board_users` AS b USING (`uid`) "
																			+ "WHERE `parent`=? ORDER BY `no` asc";
	
	//조회수
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit`=`hit`+1 WHERE `no`=?";
	
	//파일 다운로드+1
	public static final String UPDATE_FILE_HIT = "UPDATE `board_file` SET `download`=`download`+1 WHERE `fno`=?";
	
	//댓글+1
	public static final String UPDATE_COMMENT_HIT_UP = "UPDATE `board_article` SET  `comment` = `comment`+1 WHERE `no`= ?";
	
	//댓글-1
	public static final String UPDATE_COMMENT_HIT_DOWN = "UPDATE `board_article` SET `comment` = `comment`-1 WHERE `no`=?";
	
	//글수정
	public static final String UPDATE_ARTICLE = "UPDATE `board_article` SET `title`=?, `content`=?, `rdate`=NOW() WHERE `no`=?";
	
	//댓글수정
	public static final String UPDATE_COMMENT = "UPDATE `board_article` SET `content`=?, `rdate`=NOW() WHERE `no`=?";
	
	//글삭제
	public static final String DELETE_ARTICLE = "DELETE FROM `board_article` WHERE `no`=? OR `parent`=?";
	
	//파일삭제
	public static final String DELETE_FILE = "DELETE FROM `board_file` WHERE `parent`=?";
	
	//댓글삭제
	public static final String DELETE_COMMENT = "DELETE FROM `board_article` WHERE `no`=?";
	
	//실제 저장된 파일 삭제를 위한 저장된 파일명 가져오기
	public static final String SELECT_FILE_WITH_PARENT  = "SELECT * FROM `board_file` WHERE `parent`=?";
	
	//???
	public static final String SELECT_FILE = "SELECT * FROM `board_file` WHERE `fno`=?";

}
