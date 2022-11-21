package DAO;

import java.util.ArrayList;
import java.util.List;

import DBCP.DBConnPool;
import DTO.MyFileDTO;

public class MyFileDAO extends DBConnPool{

	//게시물 입력
	public int insertFile(MyFileDTO dto) {
		int applyResult = 0;
		try {
			String sql = "insert into `myfile` (`name`,`title`,`cate`,`ofile`,`sfile`,`postdate`) values (?,?,?,?,?,now())";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			applyResult = psmt.executeUpdate();
			
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return applyResult;
	}
	
	//게시물 리스트
	public List<MyFileDTO> myFileList(){
		
		List<MyFileDTO> fileList = new ArrayList();
		String sql = "select * from `myfile` order by `idx` desc";
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setCate(rs.getString(4));
				dto.setOfile(rs.getString(5));
				dto.setSfile(rs.getString(6));
				dto.setPostdate(rs.getString(7));
				fileList.add(dto);
			}
			
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return fileList;
	}
}
