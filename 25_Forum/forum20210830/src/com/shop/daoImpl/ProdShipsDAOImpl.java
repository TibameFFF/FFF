package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.ProdShipsDAO;
import com.shop.model.ProdShips;
import com.shop.model.ProdSpec;
import com.shop.util.Util;


public class ProdShipsDAOImpl implements ProdShipsDAO{
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
	public void add(ProdShips prodShips) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.prod_ships(prod_id, ship_no) VALUES(?, ?)");
			
			ps.setInt(1, prodShips.getProd_id());
			ps.setInt(2, prodShips.getShip_no());
			
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
	public void update(ProdShips prodShips) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.prod_ships SET prod_id =?, ship_no=? WHERE prod_ship_id=?");
			
			ps.setInt(1, prodShips.getProd_id());
			ps.setInt(2, prodShips.getShip_no());
			ps.setInt(3, prodShips.getProd_ship_id());
			
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
			ps = con.prepareStatement("DELETE FROM shop.prod_ships WHERE prod_ship_id=?");
			
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
	public List<ProdShips> findByProdID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<ProdShips> list = new ArrayList<ProdShips>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.prod_ships WHERE prod_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProdShips prodShips = new ProdShips();
				prodShips.setProd_id(rs.getInt("prod_id"));
				prodShips.setShip_no(rs.getInt("ship_no"));
				
				list.add(prodShips);
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
	public List<ProdShips> findByShipNo(int no) {
		Connection con = null;
		PreparedStatement ps = null;
		List<ProdShips> list = new ArrayList<ProdShips>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.prod_ships WHERE ship_no=?");
			ps.setInt(1, no);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProdShips prodShips = new ProdShips();
				prodShips.setProd_id(rs.getInt("prod_id"));
				prodShips.setShip_no(rs.getInt("ship_no"));
				
				list.add(prodShips);
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
