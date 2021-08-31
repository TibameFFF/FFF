package com.forum.controller;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
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
import com.forum.model.article_picture;

public class Article_PictureDAOImp implements Article_PictureDAO {

	private Connection getConnection() throws SQLException {
		String serverName = "localhost";
		String database = "Forum";
		String url = "jdbc:mysql://" + serverName + "/" + database;
		// 帳號和密碼
		String user = "root";
		String password = "password";
		return DriverManager.getConnection(url, user, password);

	}

	private static final String INSERT_STMT = "INSERT INTO article_picture (pic_id,article_id,image) VALUES (?, ?, ?)";

	private static final String INSERT_STMT2 = 
			"INSERT INTO article_picture " + "(" +
			"article_id," + "image"
			+ ")" 
			+ "VALUES" 
			+ "(?,?)";

	private static final String GET_ALL_STMT = "SELECT pic_id,article_id,image FROM article_picture order by pic_id";
	private static final String GET_ONE_STMT = "SELECT pic_id,article_id,image FROM article_picture where pic_id = ?";
	private static final String DELETE = "DELETE FROM article_picture where pic_id =?";
	private static final String UPDATE = "UPDATE article_picture set pic_id=?, article_id=? ,image=? where pic_id = ?";

	@Override
	public void insert(article_picture article_picture, int count) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			CommonConection connect = new CommonConection();// ------>這排式連線
			con = connect.getConnection();// ------>這排式連線

			String path1 = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\" + String.valueOf(count) + ".png";
			File file = new File(path1);
			FileInputStream is2 = new FileInputStream(file);
			pstmt = con.prepareStatement(INSERT_STMT2);

			pstmt.setInt(1, article_picture.getArticle_id());
			pstmt.setBinaryStream(2, is2, is2.available());
			pstmt.executeUpdate();
		} catch (Exception se) {
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
	public void update(article_picture article_picture) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, article_picture.getPic_id());
			pstmt.setInt(2, article_picture.getArticle_id());
			pstmt.setBlob(3, article_picture.getImage());

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
	public void delete(Integer pic_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// con = ds.getConnection();

			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, pic_id);

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());

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
	public article_picture findByPrimaryKey(Integer pic_id) {

		article_picture article_picture = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, pic_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				article_picture = new article_picture();
				article_picture.setPic_id(rs.getInt("pic_id"));
				article_picture.setArticle_id(rs.getInt("article_id"));
				article_picture.setImage(rs.getBlob("image"));
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
		return article_picture;
	}

	@Override
	public List<article_picture> getAll() {
		List<article_picture> list = new ArrayList<article_picture>();
		article_picture article_picture = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// con = ds.getConnection();
			pstmt = con.prepareStatement("pic_id,article_id,image");
			rs = pstmt.executeQuery();

			while (rs.next()) {

				article_picture = new article_picture();
				article_picture.setPic_id(rs.getInt("pic_id"));
				article_picture.setArticle_id(rs.getInt("article_id"));
				article_picture.setImage(rs.getBlob("image"));
				list.add(article_picture);
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
}
