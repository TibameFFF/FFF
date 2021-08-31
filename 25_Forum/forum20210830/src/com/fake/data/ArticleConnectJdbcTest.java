package com.fake.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;


public class ArticleConnectJdbcTest {

	public static void main(String[] args) throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver loaded!");
		} catch (ClassNotFoundException e) {
			System.out.println("找不到驅動程式類別");
			e.printStackTrace();
		}
		Connection connection = null;
		PreparedStatement pstmt = null;
		Statement statement = null;
		try {

			CommonConection commonConection = new CommonConection();
			connection = commonConection.getConnection();
			statement = connection.createStatement();
			// 查詢city表
			pstmt = connection.prepareStatement(
					"INSERT INTO Forum.article"+
					"("+
					"user_id,"+
					"article_type_num,"+
					"title,"+
					"article_content,"+
					"pageviews,"+
					"article_num_count,"+
					"article_status,"+
					"article_time)"+
					"VALUES"+
					"(?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, 1);
			pstmt.setInt(2, 1);
			pstmt.setString(3, "1");
			pstmt.setString(4, "1");
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 1);
			pstmt.setString(7, "1");
			pstmt.setDate(8, new java.sql.Date( new Date().getTime()));
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			connection.rollback();
			e.printStackTrace();
		} finally {
			connection.close();
			pstmt.close();
			statement.close();
		}
	}

}
