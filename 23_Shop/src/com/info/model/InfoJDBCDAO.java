 package com.info.model;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class InfoJDBCDAO implements InfoDAO_interface {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/Center?serverTimeZone=Asia/Taipei";
	public static final String USER = "Collin";
	public static final String PASSWORD = "123456";

	private static final String INSERT_INTO = "INSERT INTO info (user_nickname, user_name, account, email,"
			+ " bitrhday, password, sex, photo, intro,"
			+ "created_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,NOW())";
	private static final String GET_ALL = "SELECT * FROM info order by user_id";
	private static final String GET_ONE = "SELECT * FROM info where account = ?";
	private static final String UPDATE_INFO = "UPDATE info set user_nickname = ?, user_name= ? , password = ? , photo = ? where account = ?";
	private static final String UPDATE_MAPPING = "UPDATE info set mapping = ?, age_min= ? , age_max = ? , mapping_sex = ? , intro = ? where account = ?";

	@Override
	public void add(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_INTO);

			pstmt.setString(1, infoVO.getUser_nickname());
			pstmt.setString(2, infoVO.getUser_name());
			pstmt.setString(3, infoVO.getAccount());
			pstmt.setString(4, infoVO.getEmail());
			pstmt.setDate(5, infoVO.getBitrhday());
			pstmt.setString(6, infoVO.getPassword());
			pstmt.setInt(7, infoVO.getSex());
			pstmt.setBytes(8, infoVO.getPhoto());
			pstmt.setString(9, infoVO.getIntro());
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
	public void update_info(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_INFO);

			pstmt.setString(1, infoVO.getUser_nickname());
			pstmt.setString(2, infoVO.getUser_name());
			pstmt.setString(3, infoVO.getPassword());
			pstmt.setBytes(4, infoVO.getPhoto());
			pstmt.setString(5, infoVO.getAccount());

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
	public void update_mapping(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_MAPPING);

			pstmt.setInt(1, infoVO.getMapping());
			pstmt.setInt(2, infoVO.getAge_min());
			pstmt.setInt(3, infoVO.getAge_max());
			pstmt.setInt(4, infoVO.getMapping_sex());
			pstmt.setString(5, infoVO.getIntro());
			pstmt.setString(6, infoVO.getAccount());

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
	public InfoVO findByPrimaryKey(String account) {
		InfoVO infoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setString(1, account);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				infoVO = new InfoVO();
				infoVO.setUser_id(rs.getInt("user_id"));
				infoVO.setUser_status(rs.getInt("user_status"));
				infoVO.setUser_nickname(rs.getString("user_nickname"));
				infoVO.setUser_name(rs.getString("user_name"));
				infoVO.setAccount(rs.getString("account"));
				infoVO.setEmail(rs.getString("email"));
				infoVO.setBitrhday(rs.getDate("bitrhday"));
				infoVO.setPassword(rs.getString("password"));
				infoVO.setSex(rs.getInt("sex"));
				infoVO.setMapping(rs.getInt("mapping"));
				infoVO.setAge_min(rs.getInt("age_min"));
				infoVO.setAge_max(rs.getInt("age_max"));
				infoVO.setMapping_sex(rs.getInt("mapping_sex"));
				infoVO.setPhoto(rs.getBytes("photo"));
				infoVO.setIntro(rs.getString("intro"));
				infoVO.setCreated_time(rs.getTimestamp("created_time"));
				infoVO.setViolation_count(rs.getInt("violation_count"));
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
		return infoVO;
	}

	@Override
	public List<InfoVO> getAll() {
		List<InfoVO> list = new ArrayList<InfoVO>();
		InfoVO infoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				infoVO = new InfoVO();
				infoVO.setUser_id(rs.getInt("user_id"));
				infoVO.setUser_status(rs.getInt("user_status"));
				infoVO.setUser_nickname(rs.getString("user_nickname"));
				infoVO.setUser_name(rs.getString("user_name"));
				infoVO.setAccount(rs.getString("account"));
				infoVO.setEmail(rs.getString("email"));
				infoVO.setBitrhday(rs.getDate("bitrhday"));
				infoVO.setPassword(rs.getString("password"));
				infoVO.setSex(rs.getInt("sex"));
				infoVO.setMapping(rs.getInt("mapping"));
				infoVO.setAge_min(rs.getInt("age_min"));
				infoVO.setAge_max(rs.getInt("age_max"));
				infoVO.setMapping_sex(rs.getInt("mapping_sex"));
				infoVO.setPhoto(rs.getBytes("photo"));
				infoVO.setIntro(rs.getString("intro"));
				infoVO.setCreated_time(rs.getTimestamp("created_time"));
				infoVO.setViolation_count(rs.getInt("violation_count"));
				list.add(infoVO);
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
		
		FileInputStream fis = null;
		byte[] buffer = null;
		InfoJDBCDAO dao = new InfoJDBCDAO();

		for (int i = 1; i <= 20; i++) {
			InfoVO infoVO1 = new InfoVO();

			infoVO1.setUser_nickname("城" + i);
			infoVO1.setUser_name("城" + i);
			infoVO1.setAccount("test0" + i);
			infoVO1.setEmail("test0" + i + "@gmail.com");
			infoVO1.setBitrhday(java.sql.Date.valueOf("1989-06-04"));
			infoVO1.setPassword("123456");
			infoVO1.setSex(1);
			try {
				fis = new FileInputStream("WebContent/info/img/123.jpg");
				buffer = new byte[fis.available()];
				fis.read(buffer);
			} catch (IOException e) {
				e.getMessage();
			} finally {
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						e.getMessage();
					}

				}
			}

			infoVO1.setPhoto(buffer);
			infoVO1.setIntro("HelloWorld");

			dao.add(infoVO1);
		}


//		InfoVO infoVO2 = new InfoVO();
//
//		infoVO2.setUser_status(0);
//		infoVO2.setUser_nickname("Collin");
//		infoVO2.setUser_name("㏄現晶");
//		infoVO2.setAccount("g35151");
//		infoVO2.setEmail("g35151@yahoo.com.tw");
//		infoVO2.setBitrhday(java.sql.Date.valueOf("1996-05-19"));
//		infoVO2.setPassword("123456");
//		infoVO2.setSex(0);
//		infoVO2.setMapping(1);
//		infoVO2.setAge_min(18);
//		infoVO2.setAge_max(30);
//
//		try {
//			fis = new FileInputStream("img/123.jpg");
//			buffer = new byte[fis.available()];
//			fis.read(buffer);
//		} catch (IOException e) {
//			e.getMessage();
//		} finally {
//			if (fis != null) {
//				try {
//					fis.close();
//				} catch (IOException e) {
//					e.getMessage();
//				}
//
//			}
//		}
//
//		infoVO2.setPhoto(buffer);
//		infoVO2.setIntro("HelloWorld");
//		infoVO2.setViolation_count(0);
//
//		dao.add(infoVO2);

//		// э
//		InfoVO infoVO3 = new InfoVO();
//
//		infoVO3.setUser_status(0);
//		infoVO3.setUser_nickname("Peter");
//		infoVO3.setUser_name("┘眔");
//		infoVO3.setAccount("wu55688");
//		infoVO3.setEmail("wu55688@gmail.com");
//		infoVO3.setBitrhday(java.sql.Date.valueOf("1996-05-19"));
//		infoVO3.setPassword("123456");
//		infoVO3.setSex(0);
//		infoVO3.setMapping(1);
//		infoVO3.setAge_min(18);
//		infoVO3.setAge_max(30);
//		infoVO3.setMapping_sex(2);
//
//		try {
//			fis = new FileInputStream("items/FC_Bayern.png");
//			buffer = new byte[fis.available()];
//			fis.read(buffer);
//		} catch (IOException e) {
//			e.getMessage();
//		} finally {
//			if (fis != null) {
//				try {
//					fis.close();
//				} catch (IOException e) {
//					e.getMessage();
//				}
//
//			}
//		}
//
//		infoVO3.setPhoto(buffer);
//		infoVO3.setIntro("HelloWorld");
//		infoVO3.setViolation_count(0);
//		infoVO3.setUser_id(2);
//
//		dao.update(infoVO3);

//		// 埃
//		dao.delete(1);
//
//		// 琩高
//		InfoVO infoVO4 = dao.findByPrimaryKey(4);
//		System.out.println(infoVO4);
//		System.out.println("---------------------");
//
//		// 琩高
		List<InfoVO> list = dao.getAll();
		for (InfoVO ainfo : list) {
			System.out.println(ainfo);
			System.out.println();
		}
	}
}
