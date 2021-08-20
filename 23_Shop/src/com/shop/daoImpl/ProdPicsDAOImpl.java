package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dao.ProdPicsDAO;
import com.shop.model.EvalPic;
import com.shop.model.Prod;
import com.shop.model.ProdPics;
import com.shop.util.Util;


public class ProdPicsDAOImpl implements ProdPicsDAO{

	@Override
	public void add(ProdPics prodPics) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("INSERT INTO shop.prod_pics(prod_id, prod_pic) VALUES(?, ?)");
			
			ps.setInt(1, prodPics.getProd_id());
			ps.setBytes(2, prodPics.getProd_pic());
			
			ps.execute();
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			
			if(ps != null) {
				try {
					ps.close();
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
		
	}

	@Override
	public void update(ProdPics prodPics) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("UPDATE shop.prod_pics SET prod_id=? prod_pic=? WHERE prod_pic_id=?");
			
			ps.setInt(1, prodPics.getProd_id());
			ps.setBytes(2, prodPics.getProd_pic());
			ps.setInt(3, prodPics.getProd_pic_id());
			ps.execute();
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			
			if(ps != null) {
				try {
					ps.close();
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
		
	}

	@Override
	public void delete(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("DELETE FROM shop.prod_pics WHERE prod_pic_id=?");
			
			ps.setInt(1, id);
			ps.execute();
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			
			if(ps != null) {
				try {
					ps.close();
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
		
	}

	@Override
	public List<ProdPics> findByProdID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<ProdPics> list = new ArrayList<ProdPics>();
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("SELECT * FROM shop.prod_pics WHERE prod_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProdPics prodPics = new ProdPics();
				prodPics.setProd_id(id);
				prodPics.setProd_pic(rs.getBytes("prod_pic"));
				prodPics.setProd_pic_id(rs.getInt("prod_pic_id"));
				
				list.add(prodPics);
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
			
			if(ps != null) {
				try {
					ps.close();
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
}
