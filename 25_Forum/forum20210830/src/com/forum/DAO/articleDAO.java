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

import com.forum.model.article;

public class articleDAO {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");//問老師
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<article> getAll() {
		List<article> list = new ArrayList<article>();
		article at = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from article");
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				 at = new article();
				 at.setArticle_id(rs.getInt("article_id"));
				 at.setUser_id(rs.getInt("user_id"));
				 at.setArticle_type_num(rs.getInt("article_type_num"));
				 at.setTitle(rs.getString("title"));
				 at.setArticle_content(rs.getString("article_content"));
				 at.setArticle_time(rs.getDate("article_time"));
				 at.setPageviews(rs.getInt("pageviews"));
				 at.setArticle_num_count(rs.getInt("article_num_count"));
				 at.setArticle_status(rs.getString("article_status"));
				list.add(at); 
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

