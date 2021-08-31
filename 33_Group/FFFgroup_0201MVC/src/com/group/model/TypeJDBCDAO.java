package com.group.model;

import java.util.*;
import java.sql.*;

public class TypeJDBCDAO implements TypeDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/group1?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123";

	private static final String INSERT_STMT = 
		"INSERT INTO group1.type (g_type) VALUES (?)";
	private static final String GET_ALL_STMT = 
		"SELECT g_type_no,g_type FROM group1.type order by g_type_no";
	private static final String GET_ONE_STMT = 
		"SELECT g_type_no,g_type FROM group1.type where g_type_no = ?";
	private static final String DELETE = 
		"DELETE FROM group1.type where g_type_no = ?";
	private static final String UPDATE = 
		"UPDATE group1.type set g_type=? where g_type_no = ?";

	@Override
	public void insert(TypeVO typeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, typeVO.getG_type());


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
	public void update(TypeVO typeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, typeVO.getG_type());
			pstmt.setInt(2, typeVO.getG_type_no());

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
	public void delete(Integer getG_type_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);


			pstmt.setInt(1, getG_type_no);

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
	public TypeVO findByPrimaryKey(Integer getG_type_no) {

		TypeVO typeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, getG_type_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// typeVo 也稱為 Domain objects
				typeVO = new TypeVO();
				typeVO.setG_type_no(rs.getInt("g_type_no"));
				typeVO.setG_type(rs.getString("g_type"));
	
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
		return typeVO;
	}

	@Override
	public List<TypeVO> getAll() {
		List<TypeVO> list = new ArrayList<TypeVO>();
		TypeVO typeVO = null;

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
				typeVO = new TypeVO();
				typeVO.setG_type_no(rs.getInt("g_type_no"));
				typeVO.setG_type(rs.getString("g_type"));
				list.add(typeVO); // Store the row in the list
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

	public static void main(String[] args) {

		TypeJDBCDAO dao = new TypeJDBCDAO();

		// 新增
		TypeVO typeVO1 = new TypeVO();
		typeVO1.setG_type("旅遊");

		dao.insert(typeVO1);

		// 修改
		TypeVO typeVO2 = new TypeVO();
		typeVO2.setG_type_no(3);
		typeVO2.setG_type("可愛寵物");

		dao.update(typeVO2);

		// 刪除
		dao.delete(6);

		// 查詢
		TypeVO typeVO3 = dao.findByPrimaryKey(1);
		System.out.print(typeVO3.getG_type_no() + ",");
		System.out.println(typeVO3.getG_type() + ",");

		System.out.println("---------------------");

		// 查詢
		List<TypeVO> list = dao.getAll();
		for (TypeVO aType : list) {
			System.out.print(aType.getG_type_no() + ",");
			System.out.print(aType.getG_type() + ",");
			System.out.println();
		}
	}
}