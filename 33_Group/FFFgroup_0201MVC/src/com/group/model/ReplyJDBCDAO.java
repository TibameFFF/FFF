package com.group.model;

import java.util.*;
import java.sql.*;
import java.sql.Timestamp;

public class ReplyJDBCDAO implements ReplyDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/group1?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123";
	//ReplyVO ReplyVO Reply_no, user_id, Reply_time, Reply, comment_no
	private static final String INSERT_STMT = 
		"INSERT INTO group1.reply (user_id, Reply_time, Reply, comment_no) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT Reply_no, user_id, Reply_time, Reply, comment_no FROM group1.Reply order by Reply_no";
	private static final String GET_ONE_STMT = 
		"SELECT Reply_no, user_id, Reply_time, Reply, comment_no FROM group1.Reply where Reply_no = ?";
	private static final String DELETE = 
		"DELETE FROM group1.Reply where Reply_no = ?";
	private static final String UPDATE = 
		"UPDATE group1.Reply set  Reply_time=?, Reply=? where Reply_no = ?";

	@Override
	public void insert(ReplyVO ReplyVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, ReplyVO.getUser_id());
			pstmt.setTimestamp(2, ReplyVO.getReply_time());
			pstmt.setString(3, ReplyVO.getReply());
			pstmt.setInt(4, ReplyVO.getComment_no());


			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void update(ReplyVO ReplyVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);


			pstmt.setTimestamp(1, ReplyVO.getReply_time());
			pstmt.setString(2, ReplyVO.getReply());
			pstmt.setInt(3, ReplyVO.getReply_no());



			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void delete(Integer Reply_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, Reply_no);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public ReplyVO findByPrimaryKey(Integer Reply_no) {

		ReplyVO ReplyVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, Reply_no);

			rs = pstmt.executeQuery();

			
			

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				ReplyVO = new ReplyVO();
				ReplyVO.setReply_no(rs.getInt("Reply_no"));
				ReplyVO.setUser_id(rs.getInt("user_id"));
				ReplyVO.setReply_time(rs.getTimestamp("Reply_time"));
				ReplyVO.setReply(rs.getString("Reply"));
				ReplyVO.setComment_no(rs.getInt("comment_no"));

			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return ReplyVO;
	}

	@Override
	public List<ReplyVO> getAll() {
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		ReplyVO ReplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

						
			while (rs.next()) {
				// empVO 也稱為 Domain objects
				ReplyVO = new ReplyVO();
				ReplyVO.setReply_no(rs.getInt("Reply_no"));
				ReplyVO.setUser_id(rs.getInt("user_id"));
				ReplyVO.setReply_time(rs.getTimestamp("Reply_time"));
				ReplyVO.setReply(rs.getString("Reply"));
				ReplyVO.setComment_no(rs.getInt("comment_no"));

				list.add(ReplyVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	
//	private Integer Reply_no;
//	private Integer user_id;
//	private Date Reply_time;
//	private String Reply;
//	private Integer comment_no;
//	ReplyVO ReplyVO
	public static void main(String[] args) {

		ReplyJDBCDAO dao = new ReplyJDBCDAO();

		// 新增
		ReplyVO ReplyVO1 = new ReplyVO();
		ReplyVO1.setUser_id(1);
		ReplyVO1.setReply_time(Mydate.timestamp(2021, 10, 6, 12, 34, 56));
		ReplyVO1.setReply("你好啊");
		ReplyVO1.setComment_no(1);
		
		dao.insert(ReplyVO1);
 
		// 修改

		ReplyVO ReplyVO2 = new ReplyVO();
		ReplyVO2.setReply_time(Mydate.timestamp(2021, 1, 1, 12, 34, 56));
		ReplyVO2.setReply("回覆1");
		ReplyVO2.setReply_no(1);
		dao.update(ReplyVO2);

		// 刪除
//		dao.delete(1);

		// 查詢
		ReplyVO ReplyVO3 = dao.findByPrimaryKey(1);
		System.out.print(ReplyVO3.getReply_no() + ",");
		System.out.print(ReplyVO3.getUser_id() + ",");
		System.out.print(ReplyVO3.getReply_time() + ",");
		System.out.print(ReplyVO3.getReply() + ",");
		System.out.println(ReplyVO3.getComment_no() + ",");
		System.out.println("---------------------");

		// 查詢
		
		
		List<ReplyVO> list = dao.getAll();
		for (ReplyVO aReply : list) {
			System.out.print(aReply.getReply_no() + ",");
			System.out.print(aReply.getUser_id() + ",");
			System.out.print(aReply.getReply_time() + ",");
			System.out.print(aReply.getReply() + ",");
			System.out.println(aReply.getComment_no() + ",");
			System.out.println();
		}
	}
}