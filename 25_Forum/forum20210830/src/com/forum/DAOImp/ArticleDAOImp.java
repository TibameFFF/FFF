package com.forum.DAOImp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fake.data.CommonConection;
import com.forum.DAO.ArticleDAO;
import com.forum.model.article;
import com.forum.model.article_type;

public class ArticleDAOImp implements ArticleDAO {

	
	private Connection getConnection() throws SQLException {
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

	private static final String INSERT_STMT = "INSERT INTO article (article_id,user_id,article_type,title,article_content,article_time,pageviews,article_num_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	private static final String INSERT_STMT2 = "INSERT INTO Forum.article" + "(" + "user_id," + "article_type_num,"
			+ "title," + "article_content," + "pageviews," + "article_num_count," + "article_status," + "article_time)"
			+ "VALUES" + "(?,?,?,?,?,?,?,?)";

	private static final String GET_ALL_STMT = "SELECT article_id,user_id,article_type_num,title,article_content,article_time,pageviews,article_num_count,article_status FROM article order by article_id";
	private static final String GET_ONE_STMT = "SELECT article_id,user_id,article_type,title,article_content,article_time,pageviews,article_num_count,article_status FROM article where article_id = ?";
	private static final String DELETE = "DELETE FROM article where article_id = ?";
	private static final String UPDATE = "UPDATE article set article_id=?, user_id=?, article_type_num=?, title=?, article_content=?, article_time=?, pageviews=?, article_num_count=?, article_status=? where article_id=?,";

//	article_time
	public List<article> getArticle_Time() {
		List<article> list2 =  new ArrayList<article>();
		article article2 = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			CommonConection commonConection = new CommonConection();
			con = commonConection.getConnection();
			pstmt = con.prepareStatement("select * from forum.article order by article_time desc limit 10 ");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
	
				article2 = new article ();
				article2.setArticle_id(rs.getInt("article_id"));
				article2.setUser_id(rs.getInt("user_id"));
				article2.setArticle_type_num(rs.getInt("article_type_num"));
				article2.setTitle(rs.getString("title"));
				article2.setArticle_content(rs.getString("article_content"));
				article2.setArticle_time(rs.getDate("article_time"));
				article2.setPageviews(rs.getInt("pageviews"));
				article2.setArticle_num_count(rs.getInt("article_num_count"));
				article2.setArticle_status(rs.getString("article_status"));
				list2.add(article2);
			}		
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
			return list2;
		}
			
			
			
	//	pageviews
	public List<article> getPageviews() {
		List<article> list1 =  new ArrayList<article>();
		article article1 = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			CommonConection commonConection = new CommonConection();
			con = commonConection.getConnection();
			pstmt = con.prepareStatement("select * from forum.article order by pageviews desc limit 10 ");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				article1 = new article ();
				article1.setArticle_id(rs.getInt("article_id"));
				article1.setUser_id(rs.getInt("user_id"));
				article1.setArticle_type_num(rs.getInt("article_type_num"));
				article1.setTitle(rs.getString("title"));
				article1.setArticle_content(rs.getString("article_content"));
				article1.setArticle_time(rs.getDate("article_time"));
				article1.setPageviews(rs.getInt("pageviews"));
				article1.setArticle_num_count(rs.getInt("article_num_count"));
				article1.setArticle_status(rs.getString("article_status"));
				list1.add(article1);
			}		
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
			return list1;
		}
	
	
	
	@Override
	public void insert(article article) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			CommonConection connect =new CommonConection();
			con = connect.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT2);
			pstmt.setInt(1, article.getUser_id());
			pstmt.setInt(2, article.getArticle_type_num());
			pstmt.setString(3, article.getTitle());
			pstmt.setString(4, article.getArticle_content());
			pstmt.setInt(5, article.getPageviews());
			pstmt.setInt(6, article.getArticle_num_count());
			pstmt.setString(7, article.getArticle_status());
			long date = article.getArticle_time().getTime();
			pstmt.setDate(8, new java.sql.Date(date));

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
	public void update(article article) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, article.getArticle_id());
			pstmt.setInt(2, article.getUser_id());
			pstmt.setInt(3, article.getArticle_type_num());
			pstmt.setString(4, article.getTitle());
			pstmt.setString(5, article.getArticle_content());
			pstmt.setDate(6, (java.sql.Date) article.getArticle_time());
			pstmt.setInt(7, article.getPageviews());
			pstmt.setInt(8, article.getArticle_num_count());
			pstmt.setString(9, article.getArticle_status());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void delete(Integer article_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, article_id);

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public article findByPrimaryKey(Integer article_id) {

		article article = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, article_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				article = new article();
				article.setArticle_id(rs.getInt("article_id"));
				article.setUser_id(rs.getInt("user_id"));
				article.setArticle_type_num(rs.getInt("article_type_num"));
				article.setTitle(rs.getString("title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setArticle_time(rs.getDate("article_time"));
				article.setPageviews(rs.getInt("pageviews"));
				article.setArticle_num_count(rs.getInt("article_num_count"));
				article.setArticle_status(rs.getString("article_status"));
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return article;
	}

	@Override
	public List<article> getAll() {
		List<article> list = new ArrayList<article>();
		article article = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(
					"article_id,user_id,article_type,title,article_content,article_time,pageviews,article_num_count,article_status");
			rs = pstmt.executeQuery();

			while (rs.next()) {

				article = new article();
				article.setArticle_id(rs.getInt("article_id"));
				article.setUser_id(rs.getInt("user_id"));
				article.setArticle_type_num(rs.getInt("article_type_num"));
				article.setTitle(rs.getString("title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setArticle_time(rs.getDate("article_time"));
				article.setPageviews(rs.getInt("pageviews"));
				article.setArticle_num_count(rs.getInt("article_num_count"));
				article.setArticle_status(rs.getString("article_status"));
				list.add(article);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public List<article> queryByArticle(article article) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<article> articleList = new ArrayList<article>();

		try {
			CommonConection connect = new CommonConection();
			con = connect.getConnection();
			pstmt = con.prepareStatement("select *from article where user_id = " + article.getUser_id());

			rs = pstmt.executeQuery();

			while (rs.next()) {

				article = new article();
				article.setArticle_id(rs.getInt("article_id"));
				article.setUser_id(rs.getInt("user_id"));
				article.setArticle_type_num(rs.getInt("article_type_num"));
				article.setTitle(rs.getString("title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setArticle_time(rs.getDate("article_time"));
				article.setPageviews(rs.getInt("pageviews"));
				article.setArticle_num_count(rs.getInt("article_num_count"));
				article.setArticle_status(rs.getString("article_status"));
				articleList.add(article);
			}
		} catch (SQLException se) {
			System.out.println(se.getMessage());
//			throw new RuntimeException(" database error occured. " + se.getMessage());
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
		return articleList;
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
//			throw new RuntimeException(" database error occured. " + se.getMessage());
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
	public List<article> queryAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<article> articleList = new ArrayList<article>();

		try {
			CommonConection connect = new CommonConection();
			con = connect.getConnection();
			pstmt = con.prepareStatement("select *from article " );

			rs = pstmt.executeQuery();
			article article=null;
			while (rs.next()) {

				article = new article();
				article.setArticle_id(rs.getInt("article_id"));
				article.setUser_id(rs.getInt("user_id"));
				article.setArticle_type_num(rs.getInt("article_type_num"));
				article.setTitle(rs.getString("title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setArticle_time(rs.getDate("article_time"));
				article.setPageviews(rs.getInt("pageviews"));
				article.setArticle_num_count(rs.getInt("article_num_count"));
				article.setArticle_status(rs.getString("article_status"));
				articleList.add(article);
			}
		} catch (SQLException se) {
			System.out.println(se.getMessage());
//			throw new RuntimeException(" database error occured. " + se.getMessage());
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
		return articleList;
	}

}