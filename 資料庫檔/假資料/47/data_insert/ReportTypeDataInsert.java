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

	public class ReportTypeDataInsert {
		public static void main(String[] args) throws SQLException, IOException {

			Connection con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			PreparedStatement ps = con.prepareStatement("INSERT INTO REPORT_TYPE(TYPE_NAME) VALUES(?)");

			File typeFile = new File("src/data_insert/data/TypeList.txt");
			FileReader fileReader = new FileReader(typeFile);
			BufferedReader bufferReader = new BufferedReader(fileReader);
			String typeData="";
			while((typeData = bufferReader.readLine())!=null) {
				
				String[] typeList = typeData.split("、");
				for(String str:typeList)
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

