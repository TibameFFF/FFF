package data_insert;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.Util;
//更新所有type
	public class ReportTypeWithPK {
		public static void main(String[] args) throws SQLException, IOException {

			Connection con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			PreparedStatement insert_ps  = con.prepareStatement("INSERT INTO REPORT_TYPE(TYPE_ID, TYPE_NAME) VALUES(?, ?)");
			PreparedStatement upgrade_ps = con.prepareStatement("UPDATE REPORT_TYPE SET TYPE_NAME = ? WHERE TYPE_ID = ?");

			File typeFile = new File("src/data_insert/data/TypeList.txt");
			FileReader fileReader = new FileReader(typeFile);
			BufferedReader bufferReader = new BufferedReader(fileReader);
			String typeData="";
			int pk=1;
			while((typeData = bufferReader.readLine())!=null) {
				
				String[] typeList = typeData.split("、");
				for(String str:typeList)
				{
					try {
						insert_ps.setInt(1, pk);
						insert_ps.setString(2, str);
						insert_ps.execute();					
					}catch(SQLException se) {
						upgrade_ps.setString(1, str);
						upgrade_ps.setInt(2, pk);
						upgrade_ps.executeUpdate();							
					}
					pk++;
				}
			}
			bufferReader.close();
			fileReader.close();
			insert_ps.close();
			upgrade_ps.close();
			con.close();
		}
	}

