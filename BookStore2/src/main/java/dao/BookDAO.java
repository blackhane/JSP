package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import db.Sql;
import vo.BookVO;

public class BookDAO extends DBHelper {
	
	//싱글톤
	private static BookDAO instance = new BookDAO();
	public static BookDAO getInstance() {
		return instance;
	}
	private BookDAO () {}
	
	public void insertBook(BookVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_BOOK);
			psmt.setString(1, vo.getBookId());
			psmt.setString(2, vo.getBookName());
			psmt.setString(3, vo.getBookPublisher());
			psmt.setString(4, vo.getBookPrice());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public BookVO selectBook(String bookId) {
		BookVO vo = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_BOOK);
			psmt.setString(1, bookId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new BookVO();
				vo.setBookId(rs.getString(1));
				vo.setBookName(rs.getString(2));
				vo.setBookPublisher(rs.getString(3));
				vo.setBookPrice(rs.getString(4));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public List<BookVO> selectBooks() {
		List<BookVO> books = new ArrayList<>();
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_BOOKS);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BookVO book = new BookVO();
				book.setBookId(rs.getString(1));
				book.setBookName(rs.getString(2));
				book.setBookPublisher(rs.getString(3));
				book.setBookPrice(rs.getString(4));
				books.add(book);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return books;
	}
	public void updateBook(BookVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_BOOK);
			psmt.setString(1, vo.getBookName());
			psmt.setString(2, vo.getBookPublisher());
			psmt.setString(3, vo.getBookPrice());
			psmt.setString(4, vo.getBookId());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteBook(String bookId) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.DELETE_BOOK);
			psmt.setString(1, bookId);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
