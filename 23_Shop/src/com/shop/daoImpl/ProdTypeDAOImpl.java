package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.ProdTypeDAO;
import com.shop.model.ProdType;
import com.shop.util.Util;


public class ProdTypeDAOImpl implements ProdTypeDAO {
	static Context ctx;
	static DataSource ds;

	
	static {
		try {
			ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Shop"); //前兩行可包在static{}或init()裡面
		
		} catch (NamingException e) {
			e.printStackTrace();
		} 
	}

	@Override
	public List<ProdType> getAll() {
		List<ProdType> list = new ArrayList<>();
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs = st.executeQuery("SELECT * FROM shop.prod_type");
			
			while(rs.next()) {
				ProdType prodType = new ProdType();
				prodType.setProd_type_no(rs.getInt("prod_type_no"));
				prodType.setType_name(rs.getString("type_name"));
				
				list.add(prodType);
			}
			
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(st != null) {
				try {
					st.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public static void main(String[] args) {
		ProdTypeDAOImpl aa= new ProdTypeDAOImpl();
		List<ProdType> list = aa.getAll();
		System.out.println(list);
	}

}
