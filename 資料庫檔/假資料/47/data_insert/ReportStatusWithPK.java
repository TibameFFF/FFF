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
//更新所有status
	public class ReportStatusWithPK {
		public static void main(String[] args) throws SQLException, IOException {

			Connection con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			PreparedStatement insert_ps  = con.prepareStatement("INSERT INTO REPORT_STATUS(STATUS_ID, STATUS_NAME) VALUES(?, ?)");
			PreparedStatement upgrade_ps = con.prepareStatement("UPDATE REPORT_STATUS SET STATUS_NAME = ? WHERE STATUS_ID = ?");

			File statusFile = new File("src/data_insert/data/StatusList.txt");
			FileReader fileReader = new FileReader(statusFile);
			BufferedReader bufferReader = new BufferedReader(fileReader);
			String statusData="";
			int pk=1;
			while((statusData = bufferReader.readLine())!=null) {
				
				String[] statusList = statusData.split("、");
				for(String str:statusList)
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

