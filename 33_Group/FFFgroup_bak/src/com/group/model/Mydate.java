package com.group.model;
import java.sql.Timestamp;
import java.util.Calendar;

public class Mydate {
	 public static Timestamp timestamp(int YEAR,int MONTH,int DAY,int HOUR,int MINUTE,int SECOND){
		 
			Calendar calender =Calendar.getInstance();
			calender.set(Calendar.YEAR, YEAR);
			calender.set(Calendar.MONTH, MONTH-1);
			calender.set(Calendar.DAY_OF_MONTH, DAY);
			calender.set(Calendar.HOUR_OF_DAY, HOUR);
			calender.set(Calendar.MINUTE, MINUTE);
			calender.set(Calendar.SECOND, SECOND);		
			Timestamp timestamp =new Timestamp(calender.getTimeInMillis());
		
			return timestamp;
	 }   
 }
	


	
//	String strDate="2050-01-07 08:09:10";  
//	
//	SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd- HH:mm:ss");
//	try {
//		java.util.Date date = simpleDateFormat.parse(strDate);
//		System.out.println(date);
//	} catch (ParseException e) {
//		e.printStackTrace();
//	}
//		/**
//		 * 將Date轉換成String
//		 * @param date
//		 * @return
//		 */
//		public String date2String(Date date) {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			String dateStr = sdf.format(date);
//			return dateStr;
//		}
//		
//		/**
//		 * 將Timestamp轉換成String
//		 * 用於MySql中的datetime
//		 * @param timestamp
//		 * @return
//		 */
//		public String time2String(Timestamp timestamp) {
//			Date date = new Date(timestamp.getTime());
//			String dateStr = date2String(date);
//			return dateStr;
//			}
//		public static void main(String[] args) {
//			
//		}


//	    public static void main(String[] args) throws ParseException {
//	    	
//	    	
//	    	        java.util.Date temp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
//	    	                .parse("2012-07-10 14:58:00");
//	    	        
//	    	        
//	    	        System.out.println(temp);
//	    	    }
	
	
	    	
//	    }
	
//import java.util.Date;
//import java.sql.Timestamp;
//import java.text.DateFormat;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//
//public class SimpleTesting {
//
//	public static void main(String[] args) {
//		try {
//		      DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
//		      Date date = dateFormat.parse("12/10/1990");
//		      Timestamp timeStampDate = new Timestamp(date.getTime());
//		      System.out.println(timeStampDate);
//		    } catch (ParseException e) {
//		      System.out.println(e);
//		    }
//	}
//}


