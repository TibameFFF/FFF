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

import com.shop.dao.ProdSpecDAO;
import com.shop.model.ProdSpec;
import com.shop.util.Util;


public class ProdSpecDAOImpl implements ProdSpecDAO {
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
	public void add(ProdSpec prodSpec) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.prod_spec(prod_id, spec_name, stock, prod_price) VALUES(?, ?, ?, ?)");
			
			ps.setInt(1, prodSpec.getProd_id());
			ps.setString(2, prodSpec.getSpec_name());
			ps.setInt(3, prodSpec.getStock());
			ps.setInt(4, prodSpec.getProd_price());
			
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
	public void update(ProdSpec prodSpec) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.prod_spec SET prod_id =? , spec_name =?, stock =?, prod_price=? WHERE prod_spec_id=?");
			
			ps.setInt(1, prodSpec.getProd_id());
			ps.setString(2, prodSpec.getSpec_name());
			ps.setInt(3, prodSpec.getStock());
			ps.setInt(4, prodSpec.getProd_price());
			ps.setInt(5, prodSpec.getProd_spec_id());
			
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
			ps = con.prepareStatement("DELETE FROM shop.prod_spec WHERE prod_spec_id=?");
			
			
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
	public ProdSpec findByPK(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ProdSpec prodSpec = new ProdSpec();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.prod_spec WHERE prod_spec_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				prodSpec.setProd_price(rs.getInt("prod_price"));
				prodSpec.setProd_id(rs.getInt("prod_id"));
				prodSpec.setSpec_name(rs.getString("spec_name"));
				prodSpec.setStock(rs.getInt("stock"));
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
		return prodSpec;
	}

	@Override
	public List<ProdSpec> findByProdID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<ProdSpec> list = new ArrayList<ProdSpec>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.prod_spec WHERE prod_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProdSpec prodSpec = new ProdSpec();
				prodSpec.setProd_spec_id(rs.getInt("prod_spec_id"));
				prodSpec.setProd_price(rs.getInt("prod_price"));
				prodSpec.setProd_id(rs.getInt("prod_id"));
				prodSpec.setSpec_name(rs.getString("spec_name"));
				prodSpec.setStock(rs.getInt("stock"));
				
				list.add(prodSpec);
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
