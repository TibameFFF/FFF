package com.fake.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class Article_typeConnectJdbcTest {

	
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
					"INSERT INTO Forum.article_type"+
					"("+
					
					"article_type_name,"+
					
					"VALUES"+
					"(?,)");
			
			pstmt.setString(1, "1");
			
			
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


