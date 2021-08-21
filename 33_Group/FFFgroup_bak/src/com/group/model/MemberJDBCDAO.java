package com.group.model;

import java.util.*;
import java.sql.*;


public class MemberJDBCDAO implements MemberDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/group1?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123";

	private static final String INSERT_STMT = 
		"INSERT INTO group1.member (role, user_id, g_no, join_time) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT join_no, role, user_id, g_no, join_time FROM group1.member order by join_no";
	private static final String GET_ONE_STMT = 
		"SELECT join_no, role, user_id, g_no, join_time FROM group1.member where join_no= ?";
	private static final String DELETE = 
		"DELETE FROM group1.member where join_no= ?";
	private static final String UPDATE = 
		"UPDATE group1.member set role=?, join_time=? where join_no =?";

	@Override
	public void insert(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, memberVO.getRole());
			pstmt.setInt(2, memberVO.getUser_id());
			pstmt.setInt(3, memberVO.getG_no());
			pstmt.setTimestamp(4, memberVO.getJoin_time());
			

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
	public void update(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, memberVO.getRole());
//			pstmt.setInt(2, memberVO.getUser_id());
//			pstmt.setInt(3, memberVO.getG_no());
			pstmt.setTimestamp(2, memberVO.getJoin_time());
			pstmt.setInt(3, memberVO.getJoin_no());

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
	public void delete(Integer join_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, join_no);

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
//MemberVO memberVO
	@Override
	public MemberVO findByPrimaryKey(Integer join_no) {

		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, join_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				//  也稱為 Domain objects
				memberVO = new MemberVO();
				memberVO.setJoin_no(rs.getInt("join_no"));
				memberVO.setRole(rs.getInt("role"));
				memberVO.setUser_id(rs.getInt("user_id"));
				memberVO.setG_no(rs.getInt("g_no"));
				memberVO.setJoin_time(rs.getTimestamp("join_time"));
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
		return memberVO;
	}
	//MemberVO memberVO
	@Override
	public List<MemberVO> getAll() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				//  也稱為 Domain objects
				memberVO = new MemberVO();
				memberVO.setJoin_no(rs.getInt("join_no"));
				memberVO.setRole(rs.getInt("role"));
				memberVO.setUser_id(rs.getInt("user_id"));
				memberVO.setG_no(rs.getInt("g_no"));
				memberVO.setJoin_time(rs.getTimestamp("join_time"));

				list.add(memberVO); // Store the row in the list
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
	//MemberVO memberVO
	public static void main(String[] args) {

		MemberJDBCDAO dao = new MemberJDBCDAO();
		
		//Java中使用java.sql.Date
//		Date ctime = new java.sql.Date(date.getTime());        
//		pstmt.setDate(1, ctime);
		//資料庫中存入：2050-01-07 00:00:00

//		String strDate="2050-01-07 08:09:10";  
//		
//		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd- HH:mm:ss");
//		try {
//			java.util.Date date = simpleDateFormat.parse(strDate);
//			System.out.println(date);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
		// 新增	
		MemberVO memberVO1 = new MemberVO();
		memberVO1.setRole(1);
		memberVO1.setUser_id(8);
		memberVO1.setG_no(4);
		memberVO1.setJoin_time(Mydate.timestamp(2021, 1, 1, 12, 34, 56));
		dao.insert(memberVO1);
		
		// 修改
		MemberVO memberVO2 = new MemberVO();
		memberVO2.setJoin_no(1);
		memberVO2.setRole(0);
//		memberVO2.setUser_id(1);
//		memberVO2.setG_no(1);
		memberVO2.setJoin_time(Mydate.timestamp(2021, 1, 1, 12, 34, 56));
		dao.update(memberVO2);

		// 刪除
//		dao.delete(0);

		// 查詢
		MemberVO memberVO3 = dao.findByPrimaryKey(1);
		System.out.print(memberVO3.getJoin_no() + ",");
		System.out.print(memberVO3.getRole() + ",");
		System.out.print(memberVO3.getUser_id() + ",");
		System.out.print(memberVO3.getG_no() + ",");
		System.out.println(memberVO3.getJoin_time() + ",");
		System.out.println("---------------------");

		// 查詢
		List<MemberVO> list = dao.getAll();
		for (MemberVO aMember : list) {
			System.out.print(aMember.getJoin_no() + ",");
			System.out.print(aMember.getRole() + ",");
			System.out.print(aMember.getUser_id() + ",");
			System.out.print(aMember.getG_no() + ",");
			System.out.println(aMember.getJoin_time() + ",");
			System.out.println();
		}
	}

}