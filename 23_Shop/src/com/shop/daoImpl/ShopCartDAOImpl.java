package com.shop.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.ShopCartDAO;
import com.shop.model.ShopCart;
import com.shop.util.Util;


public class ShopCartDAOImpl implements ShopCartDAO {
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
	public void add(ShopCart shopCart) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.shop_cart(user_id, prod_spec_id, prod_num) VALUES(?, ?, ?)");
			
			ps.setInt(1, shopCart.getUser_id());
			ps.setInt(2, shopCart.getProd_spec_id());
			ps.setInt(3, shopCart.getProd_num());
			
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
	public void delete(ShopCart shopCart) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("DELETE FROM  shop.shop_cart WHERE user_id = ? AND prod_spec_id = ?");
			
			ps.setInt(1, shopCart.getUser_id());
			ps.setInt(2, shopCart.getProd_spec_id());
			
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
	public List<ShopCart> findByUserID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ShopCart> list = new ArrayList<>();
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM  shop.shop_cart WHERE user_id = ?");
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ShopCart shopCart = new ShopCart();
				shopCart.setProd_spec_id(rs.getInt("prod_spec_id"));
				shopCart.setProd_num(rs.getInt("prod_num"));
				
				list.add(shopCart);
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
	

	@Override
	public void update(ShopCart shopCart) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop_cart SET prod_num = ? WHERE prod_spec_id = ? AND user_id = ?");
			
			ps.setInt(1, shopCart.getProd_num());
			ps.setInt(2, shopCart.getProd_spec_id());
			ps.setInt(3, shopCart.getUser_id());
			
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
	
	public static void main(String[] args) {
		ShopCart shopCart = new ShopCart();
		
		shopCart.setProd_num(10);
		shopCart.setProd_spec_id(123);
		shopCart.setUser_id(1);
		
		ShopCartDAOImpl impl = new ShopCartDAOImpl();
		impl.update(shopCart);
	}

}
