package com.block_list.model;

import java.sql.*;
import java.util.*;

public class Block_ListJDBCDAO implements Block_ListDAO_interface {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/Center?serverTimeZone=Asia/Taipei";
	public static final String USER = "Collin";
	public static final String PASSWORD = "123456";

	private static final String INSERT_INTO = "INSERT INTO block_list (user_id, block_user_id, block_time) VALUES (?, ?, NOW())";
	private static final String GET_ALL = "SELECT * FROM block_list order by user_id";
	private static final String GET_ONE = "SELECT * FROM block_list where user_id = ? and block_user_id = ?";
	private static final String DELETE = "DELETE FROM block_list where user_id = ? and block_user_id = ?";

	@Override
	public void insert(Block_ListVO block_listVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_INTO);

			pstmt.setInt(1, block_listVO.getUser_id());
			pstmt.setInt(2, block_listVO.getBlock_user_id());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException ce) {
			ce.getMessage();
		} catch (SQLException se) {
			se.getMessage();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

		}

	}

	@Override
	public void delete(Integer user_id, Integer block_user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, user_id);
			pstmt.setInt(2, block_user_id);

			pstmt.executeUpdate();

		} catch (ClassNotFoundException ce) {
			ce.getMessage();
		} catch (SQLException se) {
			se.getMessage();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

		}

	}

	@Override
	public Block_ListVO findByPrimaryKey(Integer user_id, Integer block_user_id) {
		Block_ListVO block_ListVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, user_id);
			pstmt.setInt(2, block_user_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				block_ListVO = new Block_ListVO();
				block_ListVO.setSerial_no(rs.getInt("serial_no"));
				block_ListVO.setUser_id(rs.getInt("block_user_id"));
				block_ListVO.setBlock_user_id(rs.getInt("block_user_id"));
				block_ListVO.setBlock_time(rs.getTimestamp("block_time"));
			}

		} catch (ClassNotFoundException ce) {
			ce.getMessage();
		} catch (SQLException se) {
			se.getMessage();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

		}
		return block_ListVO;
	}

	@Override
	public List<Block_ListVO> getAll() {
		List<Block_ListVO> list = new ArrayList<Block_ListVO>();
		;
		Block_ListVO block_ListVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				block_ListVO = new Block_ListVO();
				block_ListVO.setSerial_no(rs.getInt("serial_no"));
				block_ListVO.setUser_id(rs.getInt("block_user_id"));
				block_ListVO.setBlock_user_id(rs.getInt("block_user_id"));
				block_ListVO.setBlock_time(rs.getTimestamp("block_time"));
				list.add(block_ListVO);
			}

		} catch (ClassNotFoundException ce) {
			ce.getMessage();
		} catch (SQLException se) {
			se.getMessage();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.getMessage();
				}
			}

		}
		return list;
	}

	public static void main(String[] args) {
		Block_ListJDBCDAO dao = new Block_ListJDBCDAO();
		
		// 新增
//		Block_ListVO block_ListVO1 = new Block_ListVO();
//		
//		block_ListVO1.setUser_id(1);
//		block_ListVO1.setBlock_user_id(2);
//		dao.insert(block_ListVO1);

//		// 刪除
//		dao.delete(1, 2);

//		// 查詢
		Block_ListVO block_ListVO3 = dao.findByPrimaryKey(1, 2);
//		System.out.print(block_ListVO3.getSerial_no() + ",");
//		System.out.print(block_ListVO3.getUser_id() + ",");
//		System.out.print(block_ListVO3.getBlock_user_id() + ",");
//		System.out.print(block_ListVO3.getBlock_time() + ",");
		System.out.println(block_ListVO3);
		System.out.println("---------------------");
//
		// 查詢
		List<Block_ListVO> list = dao.getAll();
		for (Block_ListVO block : list) {
			System.out.print(block.getSerial_no() + ",");
			System.out.print(block.getUser_id() + ",");
			System.out.print(block.getBlock_user_id() + ",");
			System.out.print(block.getBlock_time() + ",");
			System.out.println();
		}
	}
}
