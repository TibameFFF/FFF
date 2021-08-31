package com.fake.data;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

//import sun.misc.BASE64Decoder;
//import sun.misc.BASE64Encoder;

public class pic {

	public static void main(String[] args) {
	

		String path1 = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\1.png"; 
																				
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			CommonConection connect = new CommonConection();// ------>這排式連線
			con = connect.getConnection();// ------>這排式連線
			pstmt = con.prepareStatement(
					" INSERT INTO article_picture  "
					+ "(`article_id`,`image`) "
					+ "VALUES ( ?, ? ) ");
			pstmt.setInt(1, 7);
			File file = new File(path1);
			FileInputStream is2 = new FileInputStream(file);
//			InputStream is2 = getPictureStream(path1);
			pstmt.setBinaryStream(2, is2,is2.available());
			pstmt.executeUpdate();
		} catch (Exception se) {
			se.getStackTrace();
			System.out.println(se.getMessage());
			System.out.println(se.getStackTrace());
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

	// 使用InputStream資料流方式
	public static InputStream getPictureStream(String path) throws IOException {
		FileInputStream fis = new FileInputStream(path);
		return fis;
	}



}
