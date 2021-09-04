package com.fake.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class CommonConection {

	public  Connection getConnectionShop() throws SQLException {
		String serverName = "localhost:3306";
		String database = "Shop";
		// 帳號和密碼
		String user = "root";
		String password = "password";
		String url = "jdbc:mysql://" + serverName + "/" + database+"?user="+user+"&password="+password+"&useUnicode=true&serverTimezone=Asia/Taipei&characterEncoding=UTF-8&autoReconnect=true&failOverReadOnly=true";
		return DriverManager.getConnection(url);                                                                                                 //&characterEncoding=UTF-8
	}
	
	
	public  Connection getConnection() throws SQLException {
		String serverName = "localhost:3306";
		String database = "Forum";
		// 帳號和密碼
		String user = "root";
		String password = "password";
		String url = "jdbc:mysql://" + serverName + "/" + database+"?user="+user+"&password="+password+"&useUnicode=true&serverTimezone=Asia/Taipei&characterEncoding=UTF-8&autoReconnect=true&failOverReadOnly=true";
		return DriverManager.getConnection(url);                                                                                                 //&characterEncoding=UTF-8
	}
	
	public  Connection getConnectionCenter() throws SQLException {
		String serverName = "localhost:3306";
		String database = "center";
		// 帳號和密碼
		String user = "root";
		String password = "password";
		String url = "jdbc:mysql://" + serverName + "/" + database+"?user="+user+"&password="+password+"&useUnicode=true&serverTimezone=Asia/Taipei&characterEncoding=UTF-8&autoReconnect=true&failOverReadOnly=true";
		return DriverManager.getConnection(url);
	}
}
