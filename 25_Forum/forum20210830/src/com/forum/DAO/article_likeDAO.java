package com.forum.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.forum.model.article_like;

public class article_likeDAO {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");//問老師
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<article_like> getAll() {
		List<article_like> list = new ArrayList<article_like>();
		article_like atl = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from article_like");
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				 atl = new article_like();
				 atl.setLike_id(rs.getInt("like_id"));
				 atl.setUser_id(rs.getInt("user_id"));
				 atl.setArticle_id(rs.getInt("article_id"));
				 atl.setLike_time(rs.getDate("like_time"));
				list.add(atl); 
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
		return list;
	}
}


