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
import com.forum.model.reply;

public class replyDAO {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");//問老師
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<reply> getAll() {
		List<reply> list = new ArrayList<reply>();
		reply at = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from reply");
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				 at = new reply();
				 at.setReply_id(rs.getInt("reply_id"));
				 at.setArticle_id(rs.getInt("article_id"));
				 at.setReply_user_id(rs.getInt("reply_user_id"));
				 at.setReply_content(rs.getString("reply_content"));
				 at.setReply_time(rs.getDate("reply_time"));
				 at.setReply_like_count(rs.getInt("reply_like_count"));
				 at.setReply_status(rs.getString("reply_status"));
				 at.setLastreplytime(rs.getDate("lastreplytime"));
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
