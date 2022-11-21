package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import db.Sql;
import vo.BookVO;
import vo.CustomerVO;

public class CustomerDAO extends DBHelper {
	
	//싱글톤
	private static CustomerDAO instance = new CustomerDAO();
	public static CustomerDAO getInstance() {
		return instance;
	}
	private CustomerDAO () {}
	
	public void insertCustomer(CustomerVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_CUSTOMER);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddress());
			psmt.setString(3, vo.getPhone());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public CustomerVO selectCustomer(String custId) {
		CustomerVO vo = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_CUSTOMER);
			psmt.setString(1, custId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new CustomerVO();
				vo.setCustId(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setAddress(rs.getString(3));
				vo.setPhone(rs.getString(4));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public List<CustomerVO> selectCustomers() {
		List<CustomerVO> customers = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_CUSTOMERS);
			rs = psmt.executeQuery();
			while(rs.next()) {
				CustomerVO cust = new CustomerVO();
				cust.setCustId(rs.getInt(1));
				cust.setName(rs.getString(2));
				cust.setAddress(rs.getString(3));
				cust.setPhone(rs.getString(4));
				customers.add(cust);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return customers;
	}
	public void updateCustomer(CustomerVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_CUSTOMER);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddress());
			psmt.setString(3, vo.getPhone());
			psmt.setInt(4, vo.getCustId());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteCustomer(String custId) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_CUSTOMER);
			psmt.setString(1, custId);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
