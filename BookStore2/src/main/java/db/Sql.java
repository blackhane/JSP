package db;

public class Sql {

	public static final String SELECT_BOOKS = "select * from `book`";

	public static final String SELECT_BOOK = "select * from `book` where `bookId`=?";
	
	public static final String SELECT_CUSTOMERS = "select * from `customer`";
	
	public static final String SELECT_CUSTOMER = "select * from `customer` where `custId`=?";
	
	public static final String INSERT_BOOK = "insert into `book` value (?,?,?,?)";

	public static final String INSERT_CUSTOMER = "insert into `customer` (`name`,`address`,`phone`) value (?,?,?)";

	public static final String UPDATE_BOOK = "update `book` set `bookName`=?, `publisher`=?, `price`=? where `bookId`=?";

	public static final String UPDATE_CUSTOMER = "update `customer` set `name`=?, `address`=?, `phone`=? where `custId`=?";

	public static final String DELETE_BOOK = "delete from `book` where `bookId`=?";

	public static final String DELETE_CUSTOMER = "delete from `customer` where `custId`=?";

}
