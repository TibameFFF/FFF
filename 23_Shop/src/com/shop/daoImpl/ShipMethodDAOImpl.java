package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.ShipMethodDAO;
import com.shop.model.ShipMethod;
import com.shop.util.Util;


public class ShipMethodDAOImpl implements ShipMethodDAO{
	static Context ctx;
	static DataSource ds;

	
	static {
		try {
			ctx = new javax.naming.InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Shop"); //�e���i�]�bstatic{}��init()�̭�
		
		} catch (NamingException e) {
			e.printStackTrace();
		} 
	}
	@Override
	public void add(ShipMethod shipMethod) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.ship_method(ship_no, ship_name, ship_fee) VALUES(?, ?, ?)");
			
			ps.setInt(1, shipMethod.getShip_no());
			ps.setString(2, shipMethod.getShip_name());
			ps.setInt(3, shipMethod.getShip_fee());
			
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
	public void update(ShipMethod shipMethod) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.ship_method SET ship_name=?, ship_fee=? WHERE ship_no=?");
			
			ps.setString(1, shipMethod.getShip_name());
			ps.setInt(2, shipMethod.getShip_fee());
			ps.setInt(3, shipMethod.getShip_no());
			
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
			con = ds.getConnection();
			ps = con.prepareStatement("DELETE FROM shop.ship_method WHERE ship_no=?");
			
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
	public ShipMethod findByPK(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ShipMethod shipMethod = new ShipMethod();
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.ship_method WHERE ship_no=?");
			
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				shipMethod.setShip_name(rs.getString("ship_name"));
				shipMethod.setShip_fee(rs.getInt("ship_fee"));
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
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
		return shipMethod;
	}

	@Override
	public List<ShipMethod> getAll() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		List<ShipMethod> list = new ArrayList<>();
		
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs=st.executeQuery("SELECT * FROM shop.ship_method");
			
			while(rs.next()) {
				ShipMethod shipMethod = new ShipMethod();
				shipMethod.setShip_no(rs.getInt("ship_no"));
				shipMethod.setShip_name(rs.getString("ship_name"));
				shipMethod.setShip_fee(rs.getInt("ship_fee"));
				
				list.add(shipMethod);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
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

}
