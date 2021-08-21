package com.group.model;

import java.util.*;
import java.sql.*;
import java.sql.Date;

public class CommentJDBCDAO implements CommentDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/group1?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123";
	//CommentVO commentVO comment_no, user_id, comment_time, comment, g_no
	private static final String INSERT_STMT = 
		"INSERT INTO group1.comment (user_id, comment_time, comment, g_no) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT comment_no, user_id, comment_time, comment, g_no FROM group1.comment order by comment_no";
	private static final String GET_ONE_STMT = 
		"SELECT comment_no, user_id, comment_time, comment, g_no FROM group1.comment where comment_no = ?";
	private static final String DELETE = 
		"DELETE FROM group1.comment where comment_no = ?";
	private static final String UPDATE = 
		"UPDATE group1.comment set  comment_time=?, comment=? where comment_no = ?";

	@Override
	public void insert(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, commentVO.getUser_id());
			pstmt.setTimestamp(2, commentVO.getComment_time());
			pstmt.setString(3, commentVO.getComment());
			pstmt.setInt(4, commentVO.getG_no());


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
	public void update(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);


			pstmt.setTimestamp(1, commentVO.getComment_time());
			pstmt.setString(2, commentVO.getComment());
			pstmt.setInt(3, commentVO.getComment_no());



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
	public void delete(Integer comment_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, comment_no);

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
	public CommentVO findByPrimaryKey(Integer comment_no) {

		CommentVO commentVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, comment_no);

			rs = pstmt.executeQuery();

			
			

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				commentVO = new CommentVO();
				commentVO.setComment_no(rs.getInt("comment_no"));
				commentVO.setUser_id(rs.getInt("user_id"));
				commentVO.setComment_time(rs.getTimestamp("comment_time"));
				commentVO.setComment(rs.getString("comment"));
				commentVO.setG_no(rs.getInt("g_no"));

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
		return commentVO;
	}

	@Override
	public List<CommentVO> getAll() {
		List<CommentVO> list = new ArrayList<CommentVO>();
		CommentVO commentVO = null;

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
				commentVO = new CommentVO();
				commentVO.setComment_no(rs.getInt("comment_no"));
				commentVO.setUser_id(rs.getInt("user_id"));
				commentVO.setComment_time(rs.getTimestamp("comment_time"));
				commentVO.setComment(rs.getString("comment"));
				commentVO.setG_no(rs.getInt("g_no"));

				list.add(commentVO); // Store the row in the list
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

	
//	private Integer comment_no;
//	private Integer user_id;
//	private Date comment_time;
//	private String comment;
//	private Integer g_no;
//	CommentVO commentVO
	public static void main(String[] args) {

		CommentJDBCDAO dao = new CommentJDBCDAO();

		// 新增
		CommentVO commentVO1 = new CommentVO();
		commentVO1.setUser_id(1);
		commentVO1.setComment_time(Mydate.timestamp(2021, 1, 1, 12, 34, 56));
		commentVO1.setComment("你好啊");
		commentVO1.setG_no(1);
		
		dao.insert(commentVO1);

		// 修改
		CommentVO commentVO2 = new CommentVO();
		commentVO2.setComment_time(Mydate.timestamp(2021, 1, 1, 12, 34, 56));
		commentVO2.setComment("留言1");
		commentVO2.setComment_no(1);
		dao.update(commentVO2);

		// 刪除
//		dao.delete(1);

		// 查詢
		CommentVO commentVO3 = dao.findByPrimaryKey(1);
		System.out.print(commentVO3.getComment_no() + ",");
		System.out.print(commentVO3.getUser_id() + ",");
		System.out.print(commentVO3.getComment_time() + ",");
		System.out.print(commentVO3.getComment() + ",");
		System.out.println(commentVO3.getG_no() + ",");
		System.out.println("---------------------");

		// 查詢
		
		
		List<CommentVO> list = dao.getAll();
		for (CommentVO aComment : list) {
			System.out.print(aComment.getComment_no() + ",");
			System.out.print(aComment.getUser_id() + ",");
			System.out.print(aComment.getComment_time() + ",");
			System.out.print(aComment.getComment() + ",");
			System.out.println(aComment.getG_no() + ",");
			System.out.println();
		}
	}
}