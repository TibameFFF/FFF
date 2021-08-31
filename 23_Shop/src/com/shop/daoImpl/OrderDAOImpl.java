package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.OrderDAO;
import com.shop.model.Order;
import com.shop.util.Util;

public class OrderDAOImpl implements OrderDAO{
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
	public int add(Connection connection, Order order) throws SQLException {
		Connection con = connection;
		PreparedStatement ps = null;
		ResultSet resultSet = null;
		try {
//			con = ds.getConnection();
			String[] col = {"ord_no"};
			ps = con.prepareStatement("INSERT INTO shop.order(user_id, support_admin_id, ord_time, ord_status, ord_total, ship_method, ship_info, ship_fee) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", col);
			
			ps.setInt(1, order.getUser_id());
			ps.setInt(2, order.getSupport_admin_id());
			ps.setTimestamp(3, order.getOrd_time());
			ps.setString(4, order.getOrd_status());
			ps.setInt(5, order.getOrd_total());
			ps.setString(6, order.getShip_method());
			ps.setString(7, order.getShip_info());
			ps.setInt(8, order.getShip_fee());
			ps.execute();
			
			resultSet = ps.getGeneratedKeys();
			resultSet.next();
			
			return resultSet.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(1);
			throw new SQLException();
		} finally {
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
//			
//			if(con != null) {
//				try {
//					con.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
		}
		
	}

	@Override
	public void update(Order order) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.order SET  ord_status=?, ord_total=?  WHERE ord_no=?");
			
//			ps.setInt(1, order.getUser_id());
//			ps.setInt(1, order.getSupport_admin_id());
//			ps.setTimestamp(3, order.getOrd_time());
			ps.setString(1, order.getOrd_status());
			ps.setInt(2, order.getOrd_total());
//			ps.setString(6, order.getShip_method());
//			ps.setString(7, order.getShip_info());
//			ps.setInt(8, order.getShip_fee());
			ps.setInt(3, order.getOrd_no());
			
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
	public void delete(int pk) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("DELETE FROM shop.order WHERE ord_no=?");
			
			ps.setInt(1, pk);
			
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
	public Order findByPK(int pk) {
		Connection con = null;
		PreparedStatement ps = null;
		Order order = new Order();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.order WHERE ord_no=?");
			ps.setInt(1, pk);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				order.setOrd_status(rs.getString("ord_status"));
				order.setOrd_time(rs.getTimestamp("ord_time"));
				order.setOrd_total(rs.getInt("ord_total"));
				order.setShip_fee(rs.getInt("ship_fee"));
				order.setShip_info(rs.getString("ship_info"));
				order.setShip_method(rs.getString("ship_method"));
				order.setSupport_admin_id(rs.getInt("support_admin_id"));
				order.setUser_id(rs.getInt("user_id"));
				order.setOrd_no(pk);
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
		return order;
	}

	@Override
	public List<Order> findByUser(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<Order> list = new ArrayList<Order>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.order WHERE user_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Order order = new Order();
				order.setOrd_status(rs.getString("ord_status"));
				order.setOrd_time(rs.getTimestamp("ord_time"));
				order.setOrd_total(rs.getInt("ord_total"));
				order.setShip_fee(rs.getInt("ship_fee"));
				order.setShip_info(rs.getString("ship_info"));
				order.setShip_method(rs.getString("ship_method"));
				order.setSupport_admin_id(rs.getInt("support_admin_id"));
				order.setUser_id(rs.getInt("user_id"));
				order.setOrd_no(rs.getInt("ord_no"));
				
				list.add(order);
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
	public List<Order> getAll() {
		Connection con = null;
		Statement st = null;
		List<Order> list = new ArrayList<Order>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs = st.executeQuery("SELECT * FROM shop.order");
			
			while(rs.next()) {
				Order order = new Order();
				order.setOrd_status(rs.getString("ord_status"));
				order.setOrd_time(rs.getTimestamp("ord_time"));
				order.setOrd_total(rs.getInt("ord_total"));
				order.setShip_fee(rs.getInt("ship_fee"));
				order.setShip_info(rs.getString("ship_info"));
				order.setShip_method(rs.getString("ship_method"));
				order.setSupport_admin_id(rs.getInt("support_admin_id"));
				order.setUser_id(rs.getInt("user_id"));
				order.setOrd_no(rs.getInt("ord_no"));
				
				list.add(order);
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
	

}
