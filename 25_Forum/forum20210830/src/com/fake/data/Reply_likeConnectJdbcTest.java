package com.fake.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;



public class Reply_likeConnectJdbcTest {

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
					"INSERT INTO Forum.reply_like"+
					"("+
					"user_id,"+
					"reply_id,"+
					"like_time),"+
				    "VALUES"+
					"(?,?,?,)");
			pstmt.setInt(1, 1);
			pstmt.setInt(2, 1);
	//		pstmt.setDate(3, new java.sql.Date( new Date().getTime()));
		pstmt.setDate(3,new java.sql.Date(new Date().getTime()));	
			
			
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
