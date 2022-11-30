package DAO;

import DTO.MemberDTO;
import db.DBHelper;

public class MemberDAO extends DBHelper {
	
	
	public MemberDTO getMemberDTO(String uid, String pass) {
		MemberDTO dto = new MemberDTO();
		
		try {
			conn = getConnection();
			String sql = "select * from `member` where `id`=? and `pass`=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
