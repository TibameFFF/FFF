package com.info.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class InfoDAO implements InfoDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB3");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_INTO = "INSERT INTO info (user_nickname, user_name, account, email,"
			+ " bitrhday, password, sex,photo, intro, created_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	private static final String GET_ALL = "SELECT * FROM info order by user_id";
	private static final String GET_ONE = "SELECT * FROM info where account = ?";
	private static final String UPDATE_INFO = "UPDATE info set user_nickname = ?, user_name= ? , password = ? , photo = ? where account = ?";
	private static final String UPDATE_MAPPING = "UPDATE info set mapping = ?, age_min= ? , age_max = ? , mapping_sex = ? , intro = ? where account = ?";

	@Override
	public void add(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());

		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
	}

	@Override
	public void update_info(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_INFO);

			pstmt.setString(1, infoVO.getUser_nickname());
			pstmt.setString(2, infoVO.getUser_name());
			pstmt.setString(3, infoVO.getPassword());
			pstmt.setBytes(4, infoVO.getPhoto());
			pstmt.setString(5, infoVO.getAccount());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
	}

	@Override
	public void update_mapping(InfoVO infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MAPPING);

			pstmt.setInt(1, infoVO.getMapping());
			pstmt.setInt(2, infoVO.getAge_min());
			pstmt.setInt(3, infoVO.getAge_max());
			pstmt.setInt(4, infoVO.getMapping_sex());
			pstmt.setString(5, infoVO.getIntro());
			pstmt.setString(6, infoVO.getAccount());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}

				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace();
					}
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
			con = ds.getConnection();
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
			con = ds.getConnection();
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

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}

		}
		return list;
	}
}
