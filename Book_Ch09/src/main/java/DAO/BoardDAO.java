package DAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.management.BadAttributeValueExpException;

import DTO.BoardDTO;
import db.DBHelper;

public class BoardDAO extends DBHelper {
	
	//싱글톤 선언
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		try {
			String sql = "insert into `board` (`title`,`content`,`id`,`visitcount`,`postdate`) values (?,?,?,0,now())";
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			result = psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		
		String sql = "select count(*) from `board`";
		if(map.get("serchWord") != null) {
			sql += " where " + map.get("searchField") + " like '%" + map.get("searchWord") +"%'";
		}
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			totalCount = rs.getInt(1);
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> bbs = new ArrayList();
		String sql = "select * from `board`";
		if(map.get("searchWord") != null) {
			sql += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
		}
		sql += " order by num desc";
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostDate(rs.getString("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				bbs.add(dto);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		
		String sql = "SELECT b.*,a.`name` FROM `member` AS a "
				+ "INNER JOIN `board` AS b "
				+ "ON a.id = b.id "
				+ "WHERE `num`=?";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostDate(rs.getString(5));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public void updateVisitCount(String num) {
		
		String sql = "update `board` set `visitcount`=`visitcount`+1 where `num`=?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, num);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateEdit(BoardDTO dto) {
		
		String sql = "update `board` set `title`=?, `content`=? where `num`=?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deletePost(String num) {
		
		String sql = "delete from `board` where `num`=?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, num);
			psmt.executeUpdate();
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public List<BoardDTO> selectListPage(int start) {
		List<BoardDTO> bbs = new Vector<>();
		
		try {
			conn = getConnection();
			String sql = "select * from `board` ORDER BY `num` DESC LIMIT ?, 10";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start-1);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostDate(rs.getString(5));
				dto.setVisitcount(rs.getString(6));
				bbs.add(dto);
			}
			close();
		}catch(Exception e) {
			System.out.println("에러발생");
			e.printStackTrace();
		}
		return bbs;
	}
}
