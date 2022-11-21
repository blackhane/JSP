package mvcboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBHelper;
import db.Sql;

public class MVCBoardDAO extends DBHelper {
	
	//검색조건에 맞는 게시물 개수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String sql = Sql.SELECT_COUNT_BOARD;
		if(map.get("searchWord") != null) {
			sql += "where "+map.get("searchField")+" "
					+ " like '%"+map.get("searchWord")+"%'";
		}
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	//검색조건에 맞는 게시물 목록을 반환
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {
		List<MVCBoardDTO> board = new ArrayList<>();
		String sql = "select * from ("
				+ "select Tb.*, rownum rnum from ( "
				+ "select * from `mvcboard` ";
		if(map.get("searchWord") != null) {
			sql += "where "+map.get("searchField")+" like '%"+map.get("searchWord")+"%' ";
		}
		sql += "order by idx desc) Tb ) where rnum between ? and ?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setOrifile(rs.getString(6));
				dto.setNewfile(rs.getString(7));
				dto.setDownload(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				board.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	//글쓰기
	public void insertWire(MVCBoardDTO dto) {
		try {
			String sql = "insert into `mvcboard` (`name`,`title`,`content`,`orifile`,`newfile`,`pass`,`postdate`) values (?,?,?,?,?,?,now())";
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOrifile());
			psmt.setString(5, dto.getName());
			psmt.setString(6, dto.getPass());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
