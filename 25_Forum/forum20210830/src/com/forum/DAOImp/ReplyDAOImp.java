package com.forum.DAOImp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fake.data.CommonConection;
import com.forum.DAO.ReplyDAO;
import com.forum.model.reply;

public class ReplyDAOImp implements ReplyDAO{

	
	private  Connection getConnection() throws SQLException {
		String serverName = "localhost";
		String database = "Forum";
		String url = "jdbc:mysql://" + serverName + "/" + database;
		// 帳號和密碼
		String user = "root";
		String password = "password";
		return DriverManager.getConnection(url, user, password);

	}
	
private Connection getConnectionBycenter() throws SQLException {
		
		String serverName = "localhost:3306";
		String database = "center";
		// 帳號和密碼
		String user = "root";
		String password = "password";
		String url = "jdbc:mysql://" + serverName + "/" + database+"?user="+user+"&password="+password+"&useUnicode=true&serverTimezone=Asia/Taipei&characterEncoding=gbk&autoReconnect=true&failOverReadOnly=true";
		return DriverManager.getConnection(url);

	}
	
	private static final String INSERT_STMT = "INSERT INTO reply (reply_id,article_id,reply_user_id,reply_content,reply_time,reply_like_count,reply_status,lastreplytime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String INSERT_STMT2 = "INSERT INTO Forum.reply" + "("+"article_id,"+"reply_user_id,"+"reply_content,"+"reply_time,"
					+"reply_like_count,"+"reply_status,"+"lastreplytime)" 
					+ "VALUES" + "(?,?,?,?,?,?,?)";
	
		private static final String GET_ALL_STMT = 
			"SELECT reply_id,article_id,reply_user_id,reply_content,reply_time,reply_like_count,reply_status,lastreplytime FROM reply order by reply_id";
		private static final String GET_ONE_STMT = 
			"SELECT reply_id,article_id,reply_user_id,reply_content,reply_time,reply_like_count,reply_status,lastreplytime FROM reply where reply_id = ?";
		private static final String DELETE = 
			"DELETE FROM reply where reply_id = ?";
		private static final String UPDATE = 
			"UPDATE reply set reply_id=?, article_id=?, reply_user_id=?, reply_content=?, reply_time=?, reply_like_count=?, reply_status=?, lastreplytime=? where reply_id = ?";

		
		
	@Override
	public void insert(reply reply) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			CommonConection connect = new CommonConection();
			con = connect.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT2);
			pstmt.setInt(1, reply.getArticle_id());
			pstmt.setInt(2, reply.getReply_user_id());
			pstmt.setString(3, reply.getReply_content());
			
			long date=	reply.getReply_time().getTime();
			pstmt.setDate(4, new java.sql.Date(date));
			
			pstmt.setInt(5, reply.getReply_like_count());
			pstmt.setString(6, reply.getReply_status());
			
			if(reply.getLastreplytime()==null) {
				pstmt.setDate(7, null);
			}else {
				long date1=	reply.getLastreplytime().getTime();
				pstmt.setDate(7, new java.sql.Date(date1));
			}
			
			
			
			
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
	public void update(reply reply) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, reply.getReply_id());
			pstmt.setInt(2, reply.getArticle_id());
			pstmt.setInt(3, reply.getReply_user_id());
			pstmt.setString(4, reply.getReply_content());
			pstmt.setDate(5, (java.sql.Date) reply.getReply_time());
			pstmt.setInt(6, reply.getReply_like_count());
			pstmt.setString(7, reply.getReply_status());   
			pstmt.setDate(8, (java.sql.Date)reply.getLastreplytime());
			
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
	public void delete(Integer reply_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

	//		con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, reply_id);
			
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
	public reply findByPrimaryKey(Integer reply_id) {
		
		reply reply = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, reply_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				reply = new reply();
				reply.setReply_id(rs.getInt("reply_id"));
				reply.setArticle_id(rs.getInt("article_id"));
				reply.setReply_user_id(rs.getInt("reply_user_id"));
				reply.setReply_content(rs.getString("reply_content"));
				reply.setReply_time(rs.getDate("reply_time"));
				reply.setReply_like_count(rs.getInt("reply_like_count"));
				reply.setLastreplytime(rs.getDate("getLastreplytime"));
				reply.setReply_status(rs.getString("reply_status"));       
			
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
		return reply;
	}


	@Override
	public List<reply> getAll() {
		List<reply> list = new ArrayList<reply>();
		reply reply = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
	//		con = ds.getConnection();
			pstmt = con.prepareStatement("reply_id,article_id,reply_user_id,reply_content,reply_time,reply_like_count, getLastreplytime,reply_status FROM reply order by reply_id");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				reply = new reply();
				reply.setReply_id(rs.getInt("reply"));
				reply.setArticle_id(rs.getInt("article_id"));
				reply.setReply_user_id(rs.getInt("reply_user_id"));
				reply.setReply_content(rs.getString("reply_content"));
				reply.setReply_time(rs.getDate("reply_time"));
				reply.setReply_like_count(rs.getInt("reply_like_count"));
				reply.setLastreplytime(rs.getDate("lastreplytime"));
				reply.setReply_status(rs.getString("reply_status"));
				
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

	@Override
public List<reply> queryByReply(reply reply) {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	List<reply> replyList = new ArrayList<reply>();

	try {
		CommonConection connect = new CommonConection();
		con = connect.getConnection();
		pstmt = con.prepareStatement("select *from reply where rply_id = " + reply.getReply_id());

		rs = pstmt.executeQuery();

		while (rs.next()) {

			reply = new reply();
			reply.setReply_id(rs.getInt("Reply_id"));
			reply.setArticle_id(rs.getInt("Article_id"));
			reply.setReply_user_id(rs.getInt("Reply_user_id"));
			reply.setReply_content(rs.getString("Reply_content"));
			reply.setReply_time(rs.getDate("Reply_time"));
			reply.setReply_like_count(rs.getInt("Reply_like_count"));
			reply.setLastreplytime(rs.getDate("Lastreplytime"));
			reply.setReply_status(rs.getString("Reply_status"));
			replyList.add(reply);
		}
	} catch (SQLException se) {
		System.out.println(se.getMessage());
//		throw new RuntimeException(" database error occured. " + se.getMessage());
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
	return replyList;
}

public int selectCenter(String string) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int userid = 0;
	try {
		CommonConection connect = new CommonConection();
		con = connect.getConnectionCenter();
		pstmt = con.prepareStatement("select *from info where account = " + "'"+string+"'");

		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			userid = rs.getInt("user_id");
		}
	} catch (SQLException se) {
		System.out.println(se.getMessage());
//		throw new RuntimeException(" database error occured. " + se.getMessage());
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
	return userid;
}

@Override
public List<reply> queryAll() {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	List<reply> replyList = new ArrayList<reply>();

	try {
		CommonConection connect = new CommonConection();
		con = connect.getConnection();
		pstmt = con.prepareStatement("select *from reply " );

		rs = pstmt.executeQuery();
		reply reply=null;
		while (rs.next()) {

			reply = new reply();
			reply.setReply_id(rs.getInt("Reply_id"));
			reply.setArticle_id(rs.getInt("Article_id"));
			reply.setReply_user_id(rs.getInt("Reply_user_id"));
			reply.setReply_content(rs.getString("Reply_content"));
			reply.setReply_time(rs.getDate("Reply_time"));
			reply.setReply_like_count(rs.getInt("Reply_like_count"));
			reply.setLastreplytime(rs.getDate("Lastreplytime"));
			reply.setReply_status(rs.getString("Reply_status"));
			replyList.add(reply);
		}
	} catch (SQLException se) {
		System.out.println(se.getMessage());
//		throw new RuntimeException(" database error occured. " + se.getMessage());
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
	return replyList;
}

}