package com.group.model;

import java.util.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;

public class GroupJDBCDAO implements GroupDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/group1?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123";

	private static final String INSERT_STMT = 
		"INSERT INTO group1.group (g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url)"
		+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT g_no, g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url FROM group1.group order by g_no";
//		"SELECT * FROM group1.group order by g_no";
	private static final String GET_ONE_STMT = 
		"SELECT g_no, g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url FROM group1.group where g_no = ?";
//		"SELECT * FROM group1.group where g_no=?";
	private static final String DELETE = 
		"DELETE FROM group1.group where g_no = ?";
	private static final String UPDATE = 
		"UPDATE group1.group set g_name=? , g_type_no=? , g_content=? , g_start_time=? , g_end_time=? , "
		+ "apply_start_time=? , apply_end_time=? , place=? , number_lower=? , number_upper=? , "
		+ "number_total=? , user_id=? , introduce=? , phone=? , email=? , state_no=? , g_flow_cause=? , "
		+ "photo=? , g_url=?  where g_no =?";

	@Override
	public void insert(GroupVO groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, groupVO.getG_name());
			pstmt.setInt(2, groupVO.getG_type_no());
			pstmt.setString(3, groupVO.getG_content());
			pstmt.setTimestamp(4, groupVO.getG_start_time());
			pstmt.setTimestamp(5, groupVO.getG_end_time());
			pstmt.setTimestamp(6, groupVO.getApply_start_time());
			pstmt.setTimestamp(7, groupVO.getApply_end_time());
			pstmt.setString(8, groupVO.getPlace());
			pstmt.setInt(9, groupVO.getNumber_lower());
			pstmt.setInt(10, groupVO.getNumber_upper());
			pstmt.setInt(11, groupVO.getNumber_total());
			pstmt.setInt(12, groupVO.getUser_id());
			pstmt.setString(13, groupVO.getIntroduce());
			pstmt.setString(14, groupVO.getPhone());
			pstmt.setString(15, groupVO.getEmail());
			pstmt.setInt(16, groupVO.getState_no());
			pstmt.setString(17, groupVO.getG_flow_cause());
			pstmt.setBytes(18, groupVO.getPhoto());
			pstmt.setString(19, groupVO.getG_url());

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
	public void update(GroupVO groupVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			

			pstmt.setString(1, groupVO.getG_name());
			pstmt.setInt(2, groupVO.getG_type_no());
			pstmt.setString(3, groupVO.getG_content());
			pstmt.setTimestamp(4, groupVO.getG_start_time());
			pstmt.setTimestamp(5, groupVO.getG_end_time());
			pstmt.setTimestamp(6, groupVO.getApply_start_time());
			pstmt.setTimestamp(7, groupVO.getApply_end_time());
			pstmt.setString(8, groupVO.getPlace());
			pstmt.setInt(9, groupVO.getNumber_lower());
			pstmt.setInt(10, groupVO.getNumber_upper());
			pstmt.setInt(11, groupVO.getNumber_total());
			pstmt.setInt(12, groupVO.getUser_id());
			pstmt.setString(13, groupVO.getIntroduce());
			pstmt.setString(14, groupVO.getPhone());
			pstmt.setString(15, groupVO.getEmail());
			pstmt.setInt(16, groupVO.getState_no());
			pstmt.setString(17, groupVO.getG_flow_cause());
			pstmt.setBytes(18, groupVO.getPhoto());
			pstmt.setString(19, groupVO.getG_url());
			pstmt.setInt(20, groupVO.getG_no());
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
	public void delete(Integer g_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, g_no);

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
	public GroupVO findByPrimaryKey(Integer g_no) {

		GroupVO groupVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, g_no);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// groupVo 也稱為 Domain objects

				groupVO =new GroupVO();
				groupVO.setG_no(rs.getInt("g_no"));
				groupVO.setG_name(rs.getString("g_name"));
				groupVO.setG_type_no(rs.getInt("g_type_no"));
				groupVO.setG_content(rs.getString("g_content"));
				groupVO.setG_start_time(rs.getTimestamp("g_start_time"));
				groupVO.setG_end_time(rs.getTimestamp("g_end_time"));
				groupVO.setApply_start_time(rs.getTimestamp("apply_start_time"));
				groupVO.setApply_end_time(rs.getTimestamp("apply_end_time"));
				groupVO.setPlace(rs.getString("place"));
				groupVO.setNumber_lower(rs.getInt("number_lower"));
				groupVO.setNumber_upper(rs.getInt("number_upper"));
				groupVO.setNumber_total(rs.getInt("number_total"));
				groupVO.setUser_id(rs.getInt("user_id"));
				groupVO.setIntroduce(rs.getString("introduce"));
				groupVO.setPhone(rs.getString("phone"));
				groupVO.setEmail(rs.getString("email"));
				groupVO.setState_no(rs.getInt("state_no"));
				groupVO.setG_flow_cause(rs.getString("g_flow_cause"));
				groupVO.setPhoto(rs.getBytes("photo"));
				groupVO.setG_url(rs.getString("g_url")); 			
						
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
		return groupVO;
	}

	@Override
	public List<GroupVO> getAll() {
		List<GroupVO> list = new ArrayList<GroupVO>();
		GroupVO groupVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// groupVO 也稱為 Domain objects			
				groupVO =new GroupVO();
				groupVO.setG_no(rs.getInt("g_no"));
				groupVO.setG_name(rs.getString("g_name"));
				groupVO.setG_type_no(rs.getInt("g_type_no"));
				groupVO.setG_content(rs.getString("g_content"));
				groupVO.setG_start_time(rs.getTimestamp("g_start_time"));
				groupVO.setG_end_time(rs.getTimestamp("g_end_time"));
				groupVO.setApply_start_time(rs.getTimestamp("apply_start_time"));
				groupVO.setApply_end_time(rs.getTimestamp("apply_end_time"));
				groupVO.setPlace(rs.getString("place"));
				groupVO.setNumber_lower(rs.getInt("number_lower"));
				groupVO.setNumber_upper(rs.getInt("number_upper"));
				groupVO.setNumber_total(rs.getInt("number_total"));
				groupVO.setUser_id(rs.getInt("user_id"));
				groupVO.setIntroduce(rs.getString("introduce"));
				groupVO.setPhone(rs.getString("phone"));
				groupVO.setEmail(rs.getString("email"));
				groupVO.setState_no(rs.getInt("state_no"));
				groupVO.setG_flow_cause(rs.getString("g_flow_cause"));
				groupVO.setPhoto(rs.getBytes("photo"));
				groupVO.setG_url(rs.getString("g_url")); 
				
				list.add(groupVO); // Store the row in the list
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
		GroupJDBCDAO dao = new GroupJDBCDAO();

		// 新增
		GroupVO groupVO1 = new GroupVO();

		groupVO1.setG_name("活動名稱10");
		groupVO1.setG_type_no(2);
		groupVO1.setG_content("這是活動5內容");
		groupVO1.setG_start_time(Mydate.timestamp(2021, 2, 2, 2, 2, 2));
		groupVO1.setG_end_time(Mydate.timestamp(2021, 1, 1, 1, 1, 1));
		groupVO1.setApply_start_time(Mydate.timestamp(2021, 3, 3, 3, 3, 3));
		groupVO1.setApply_end_time(Mydate.timestamp(2021, 4, 4, 4, 4, 4));
		groupVO1.setPlace("台北");
		groupVO1.setNumber_lower(1);
		groupVO1.setNumber_upper(3);
		groupVO1.setNumber_total(3);
		groupVO1.setUser_id(2);
		groupVO1.setIntroduce("介紹2");
		groupVO1.setPhone("0922222222");
		groupVO1.setEmail("aa@gmail.com");
		groupVO1.setState_no(1);
		groupVO1.setG_flow_cause(null);

		try {
			byte[] pic = getPictureByteArray("WebContent/group/bunny/b6.jpg");
		groupVO1.setPhoto(pic);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		groupVO1.setG_url(null);
		
	
		dao.insert(groupVO1);

		// 修改
//		GroupVO groupVO2 = new GroupVO();
//			
//		groupVO2.setG_name("活動名稱1");
//		groupVO2.setG_type_no(1);
//		groupVO2.setG_content("這是活動1內容");
//		groupVO2.setG_start_time(Mydate.timestamp(2021, 1, 1, 1, 1, 1));
//		groupVO2.setG_end_time(Mydate.timestamp(2021, 2, 2, 2, 2, 2));
//		groupVO2.setApply_start_time(Mydate.timestamp(2021, 1, 1, 1, 1, 1));
//		groupVO2.setApply_end_time(Mydate.timestamp(2021, 2, 2, 2, 2, 1));
//		groupVO2.setPlace("台北");
//		groupVO2.setNumber_lower(1);
//		groupVO2.setNumber_upper(3);
//		groupVO2.setNumber_total(3);
//		groupVO2.setUser_id(2);
//		groupVO2.setIntroduce("介紹2");
//		groupVO2.setPhone("0922222222");
//		groupVO2.setEmail("bb@gmail.com");
//		groupVO2.setState_no(1);
//		groupVO2.setG_flow_cause("原因");
//		try {
//			byte[] pic = getPictureByteArray("WebContent/group/bunny/b4.jpg");
//		groupVO2.setPhoto(pic);
//		} catch (IOException e1) {
//			e1.printStackTrace();
//		}
//		groupVO2.setG_url("aa@gmail.com"); 
//		
//		groupVO2.setG_no(1);
//
//		
//		dao.update(groupVO2);
//		刪除
//		dao.delete(5);

		// 查詢
		GroupVO groupVO3 = dao.findByPrimaryKey(1);
	
		System.out.print(groupVO3.getG_no() + ",");
		System.out.print(groupVO3.getG_name() + ",");
		System.out.print(groupVO3.getG_type_no() + ",");
		System.out.print(groupVO3.getG_content() + ",");
		System.out.print(groupVO3.getG_start_time() + ",");
		System.out.print(groupVO3.getG_end_time() + ",");
		System.out.print(groupVO3.getApply_start_time() + ",");
		System.out.print(groupVO3.getApply_end_time() + ",");
		System.out.print(groupVO3.getPlace() + ",");
		System.out.print(groupVO3.getNumber_lower() + ",");
		System.out.print(groupVO3.getNumber_upper() + ",");
		System.out.print(groupVO3.getNumber_total() + ",");
		System.out.print(groupVO3.getUser_id() + ",");
		System.out.print(groupVO3.getIntroduce() + ",");
		System.out.print(groupVO3.getPhone() + ",");
		System.out.print(groupVO3.getEmail() + ",");
		System.out.print(groupVO3.getState_no() + ",");
		System.out.print(groupVO3.getG_flow_cause() + ",");
		System.out.print(groupVO3.getPhoto() + ",");
		System.out.println(groupVO3.getG_url() + ",");

		System.out.println("---------------------------------------------");

		// 查詢
		List<GroupVO> list = dao.getAll();
		for (GroupVO agroup : list) {
//			System.out.println(agroup);
//			System.out.println();
						
			System.out.print(agroup.getG_no() + ",");
			System.out.print(agroup.getG_name() + ",");
			System.out.print(agroup.getG_type_no() + ",");
			System.out.print(agroup.getG_content() + ",");
			System.out.print(agroup.getG_start_time() + ",");
			System.out.print(agroup.getG_end_time() + ",");
			System.out.print(agroup.getApply_start_time() + ",");
			System.out.print(agroup.getApply_end_time() + ",");
			System.out.print(agroup.getPlace() + ",");
			System.out.print(agroup.getNumber_lower() + ",");
			System.out.print(agroup.getNumber_upper() + ",");
			System.out.print(agroup.getNumber_total() + ",");
			System.out.print(agroup.getUser_id() + ",");
			System.out.print(agroup.getIntroduce() + ",");
			System.out.print(agroup.getPhone() + ",");
			System.out.print(agroup.getEmail() + ",");
			System.out.print(agroup.getState_no() + ",");
			System.out.print(agroup.getG_flow_cause() + ",");
			System.out.print(agroup.getPhoto() + ",");
			System.out.print(agroup.getG_url() + ","); 	
			System.out.println();
			
			
		}
	}
	public static byte[] getPictureByteArray(String path) throws IOException {
		FileInputStream fis = new FileInputStream(path);
		byte[] buffer = new byte[fis.available()];
		fis.read(buffer);
		fis.close();
		return buffer;
	}
}