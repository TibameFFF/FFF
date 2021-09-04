package com.forum.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fake.data.CommonConection;
import com.forum.DAO.Article_TypeDAO;
import com.forum.model.article_type;

public class Article_TypeDAOImp implements Article_TypeDAO {
	


	private static final String INSERT_STMT =
			"INSERT INTO article_type (article_type_num, article_type_name) VALUES (?,?)  ";
	
	
	private static final String INSERT_STMT2 = 
			"INSERT INTO Forum.article_type"+
					"("+
					"article_type_name,"+
					"article_type_num,"+
					"VALUES"+
					"(?,?)";
		
	
	private static final String GET_ALL_STMT = 
			"SELECT article_type_num, article_type_name FROM article_type order by article_type_name";
	private static final String GET_ONE_STMT =
			"SELECT article_type_num, article_type_name FROM article_type where article_type_num = ?";
	private static final String DELETE =
			"DELETE FROM article_type where article_type_num = ?";
	private static final String UPDATE =
			"UPDATE article_type set article_type_num=?, article_type_name? where empno = ?";
	
	
	public List<article_type>  getArticle_Type_Num(){
	List<article_type> list = new ArrayList<article_type>();
	article_type article_type = null;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	 
	try {
		CommonConection commonConection = new CommonConection();
		con = commonConection.getConnection();
		pstmt = con.prepareStatement("select * from article_type order by article_type_num ");
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			
			article_type  = new article_type();
			article_type.setArticle_type_num(rs.getInt("article_type_num"));
			article_type.setArticle_type_name(rs.getString("article_type_name"));
			list.add(article_type);
	}
	}catch (SQLException se) {
		se.getStackTrace();
	}finally {
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
	public void insert(article_type article_type) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			CommonConection commonConection = new CommonConection();
			con = commonConection.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, article_type.getArticle_type_num());
			pstmt.setString(2, article_type.getArticle_type_name());
			
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
	public void update(article_type article_type) { 
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
	//		con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, article_type.getArticle_type_num());
			pstmt.setString(2, article_type.getArticle_type_name());
			
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
	public void delete(Integer article_type_num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

	//		con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, article_type_num);
			
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
	public article_type findByPrimaryKey(Integer article_type_num) {
		
		article_type article_type = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

	//		con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setInt(1, article_type_num);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
			
				article_type = new article_type();
				article_type.setArticle_type_num(rs.getInt("article_type_num"));
				article_type.setArticle_type_name(rs.getString("article_type_name"));
				
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
		return article_type;
	}

	@Override
	public List<article_type> getAll() {
		List<article_type> list = new ArrayList<article_type>();
		article_type article_type = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
//			con = ds.getConnection();
			pstmt = con.prepareStatement("article_type_num,article_type_name FROM article_type order by article_type_num");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				article_type = new article_type();
				article_type.setArticle_type_num(rs.getInt("article_type_num"));
				article_type.setArticle_type_name(rs.getString("article_type_name"));
				list.add(article_type);
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