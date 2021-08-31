package com.forum.controller;

import java.sql.Connection;
import java.util.Date;
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

import com.fake.data.CommonConection;
import com.forum.model.article_like;

public class Article_LikeDAOImp implements Article_LikeDAO {
	
	private Connection getConnection() throws SQLException {
		String serverName = "localhost";
		String database = "Forum";
		String url = "jdbc:mysql://" + serverName + "/" + database;
		// 帳號和密碼
		String user = "root";
		String password = "password";
		return DriverManager.getConnection(url, user, password);

	}

		private static final String INSERT_STMT = 
				"INSERT INTO article_like = (like_id, user_id, article_id, like_time) VALUES (?, ?, ?, ? )";
		
		
		private static final String INSERT_STMT2 = 
				"INSERT INTO Forum.article_like"+
		                "("+
						"user_id,"+
						"article_id,"+
						"like_time)"+
						"VALUES"+
						"(?,?,?)";
		
	
	private static final String GET_ALL_STMT =
			"SELECT article_like like_id, user_id, article_id, like_time FROM article_like order by like_id" ;
	private static final String GET_ONE_STMT =
			"SELECT article_like like_id, user_id, article_id, like_time FROM article_like where like_id = ? ";
	private static final String DELETE = 
			"DELETE FROM article_like where like_id = ?";
	private static final String UPDATE = 
			"UPDATE article_like set like_id=?, user_id=?, article_id=?, like_time=? where like_id";
	
	@Override
	public void insert(article_like article_like) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
			try {

				CommonConection connect = new CommonConection();//------>這排式連線
				con = connect.getConnection();//------>這排式連線
				pstmt = con.prepareStatement(INSERT_STMT2);
				
				
				pstmt.setInt(1, article_like.getUser_id());		
				pstmt.setInt(2, article_like.getArticle_id());
				long date=	article_like.getLike_time().getTime();
				pstmt.setDate(3, new java.sql.Date(date));
				
				
				pstmt.executeUpdate();
			} catch (SQLException se) {
				se.getStackTrace();
				System.out.println(se.getMessage());
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
	public void update(article_like article_like) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
	try {
		
//		con = ds.getConnection();
		pstmt = con.prepareStatement(UPDATE);
		
		pstmt.setInt(1, article_like.getLike_id());
		pstmt.setInt(2, article_like.getUser_id());		
		pstmt.setInt(3, article_like.getArticle_id());
		pstmt.setDate(4, (java.sql.Date) article_like.getLike_time());
		
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
			
		
//		con = ds.getConnection();
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
	public article_like article_likefindByPrimaryKey(Integer like_id) {
		
		article_like article_like = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, like_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				article_like = new article_like();	
				article_like.setLike_id(rs.getInt("like_id"));
				article_like.setUser_id(rs.getInt("user_id"));
				article_like.setArticle_id(rs.getInt("article_id"));
				article_like.setLike_time(rs.getDate("like_time"));
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
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
		return article_like;
	}

	@Override
	public List<article_like> getAll() {
		List<article_like> list = new ArrayList<article_like>();
		article_like article_like = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
//			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT like_id, user_id, article_id, like_time FROM article_like order by like_id");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				article_like = new article_like();
				article_like.setLike_id(rs.getInt("like_id"));
				article_like.setUser_id(rs.getInt("user_id"));
				article_like.setArticle_id(rs.getInt("article_id"));
				article_like.setLike_time(rs.getDate("like_time"));
				list.add(article_like);
			}
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			
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
	