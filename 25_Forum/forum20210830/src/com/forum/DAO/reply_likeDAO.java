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
import com.forum.model.reply_like;

public class reply_likeDAO {

	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB2");//問老師
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<reply_like> getAll() {
		List<reply_like> list = new ArrayList<reply_like>();
		reply_like at = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from reply_like");
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				 at = new reply_like();
				 at.setLike_id(rs.getInt("like_id"));
				 at.setUser_id(rs.getInt("user_id"));
				 at.setReply_id(rs.getInt("reply_id"));
				 at.setLike_time(rs.getDate("like_id"));
				
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
