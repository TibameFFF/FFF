package data_insert;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.back.controller.AdminDaoImp;
import com.back.controllerDao.AdminDao;
import com.back.model.Admin;

import util.Util;

public class AdminDataInsert {
	
	public static void main(String[] args) throws SQLException, IOException {
		Connection con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
		
		File file = new File("src/data_insert/data/AdminList.txt");
		FileReader fr = new FileReader(file);
		BufferedReader br = new BufferedReader(fr);
		String adminData = "";
		AdminDao dao = new AdminDaoImp();
		while((adminData = br.readLine())!=null) {
			
			String[] adminElement = adminData.split(",");
			Admin admin = new Admin.Builder()
			.Account(adminElement[0])
			.Password(adminElement[1])
			.Name(adminElement[2])
			.Join(Timestamp.valueOf(adminElement[3]))
			.Left(Timestamp.valueOf(adminElement[4]))
			.Level(Integer.parseInt(adminElement[5]))
			.Status(Integer.parseInt( adminElement[6]))
			.build();
			dao.add(admin);

		}
		
		br.close();
		fr.close();
		con.close();
		

	}
}
