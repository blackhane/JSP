package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBCP.DBConnPool;
import DTO.MemberDTO;

public class MemberDAO {
	
	public MemberDTO getMemberDTO(String id, String pass) {
		
		MemberDTO dto = new MemberDTO();
		
		try {
			Connection conn = DBConnPool.getConnection();
			PreparedStatement psmt = conn.prepareStatement("select * from `member` where `id`=? and `pass`=?");
			psmt.setString(1, id);
			psmt.setString(2, pass);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
