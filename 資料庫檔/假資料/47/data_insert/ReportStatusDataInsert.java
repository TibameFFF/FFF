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

	public class ReportStatusDataInsert {
		public static void main(String[] args) throws SQLException, IOException {

			Connection con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			PreparedStatement ps = con.prepareStatement("INSERT INTO REPORT_STATUS(STATUS_NAME) VALUES(?)");

			File statusFile = new File("src/data_insert/data/StatusList.txt");
			FileReader fileReader = new FileReader(statusFile);
			BufferedReader bufferReader = new BufferedReader(fileReader);
			String statusData="";
			
			while((statusData = bufferReader.readLine())!=null) {
				
				String[] statusList = statusData.split("、");
				for(String str:statusList)
				{
					ps.setString(1, str);
					ps.execute();			
				}
			}
			bufferReader.close();
			fileReader.close();
			ps.close();
			con.close();
		}
	}

