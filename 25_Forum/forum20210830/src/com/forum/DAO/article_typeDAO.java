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

import com.emp.model.EmpVO;
import com.forum.model.article_type;

public class article_typeDAO {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");//問老師
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<article_type> getAll() {
		List<article_type> list = new ArrayList<article_type>();
		article_type at = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from article_type");
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				 at = new article_type();
				 at.setArticle_type_num(rs.getInt("article_type_num"));
				 at.setArticle_type_name(rs.getString("article_type_name"));
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

