package com.forum.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.fake.data.CommonConection;
import com.forum.model.reply_like;

public class Reply_LikeDAOImp implements Reply_LikeDAO {
	
	private  Connection getConnection() throws SQLException {
		String serverName = "localhost";
		String database = "Forum";
		String url = "jdbc:mysql://" + serverName + "/" + database;
		// 帳號和密碼
		String user = "root";
		String password = "password";
		return DriverManager.getConnection(url, user, password);

	}

	private static final String INSERT_STMT = 
			"INSERT INTO reply_like (like_id, user_id, reply_id, like_time) VALUES (?, ?, ?, ?)";
		
	private static final String INSERT_STMT2 = 
			"INSERT INTO Forum.reply_like"+
					"("+
					"user_id,"+
					"reply_id,"+
					"like_time)"+
					"VALUES"+
					"(?,?,?)";
	
	private static final String GET_ALL_STMT = 
			"SELECT like_id, user_id, reply_id, like_time FROM reply_like order by like_id";
		private static final String GET_ONE_STMT = 
			"SELECT like_id, user_id, reply_id, like_time FROM reply_like where like_id = ?";
		private static final String DELETE = 
			"DELETE FROM reply_like where like_id = ?";
		private static final String UPDATE = 
			"UPDATE reply_like set like_id=?, user_id=?, reply_id=?, like_time=? where like_id =?";              
			 
		
		 
	@Override
	public void insert(reply_like reply_like) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			CommonConection connect = new CommonConection();//------>這排式連線
			con = connect.getConnection();//------>這排式連線
			pstmt = con.prepareStatement(INSERT_STMT2);

		
			pstmt.setInt(1, reply_like.getUser_id());
			pstmt.setInt(2, reply_like.getReply_id());
			long date=	reply_like.getLike_time().getTime();
			pstmt.setDate(3, new java.sql.Date(date));
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			se.getStackTrace();
			System.out.println(se.getMessage());
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
	public void update(reply_like reply_like) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1,  reply_like.getLike_id());
			pstmt.setInt(2, reply_like.getUser_id());
			pstmt.setInt(3, reply_like.getReply_id());
			pstmt.setDate(4, (java.sql.Date) reply_like.getLike_time());
			
			pstmt.executeUpdate();

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
	public void delete(Integer like_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, like_id);
			
			pstmt.executeUpdate();

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
	public reply_like findByPrimaryKey(Integer like_id) {
		
		reply_like reply_like = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, like_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				reply_like = new reply_like();
				reply_like.setLike_id(rs.getInt("like_id"));
				reply_like.setUser_id(rs.getInt("user_id"));
				reply_like.setReply_id(rs.getInt("reply_id"));
				reply_like.setLike_time(rs.getDate("like_time"));
			}

			// Handle any driver errors
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
		return reply_like;
	}
	
	@Override
	public List<reply_like> getAll() {
		
		List<reply_like> list = new ArrayList<reply_like>();
		reply_like reply_like = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement("like_id, user_id, reply_id, like_time FROM reply_like order by like_id");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				reply_like = new reply_like();
				reply_like.setLike_id(rs.getInt("like_id"));
				reply_like.setLike_time(rs.getDate("like_time"));
				reply_like.setReply_id(rs.getInt("reply_id"));
				reply_like.setUser_id(rs.getInt("user_id"));
				list.add(reply_like);
				
			}
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
}