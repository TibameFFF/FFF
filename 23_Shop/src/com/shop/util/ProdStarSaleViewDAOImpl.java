package com.shop.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ProdStarSaleViewDAOImpl implements ProdStarSaleViewDAO {

	@Override
	public List<ProdStarSaleView> findByProdID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<ProdStarSaleView> list = new ArrayList<ProdStarSaleView>();
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("SELECT ps.prod_id, ps.prod_spec_id, op.eval_star, op.prod_num\r\n" + 
					"FROM SHOP.order_prod op \r\n" + 
					"	JOIN SHOP.prod_spec ps ON op.prod_spec_id = ps.prod_spec_id\r\n" + 
					"WHERE ps.prod_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ProdStarSaleView prodStarSaleView = new ProdStarSaleView();
				
				prodStarSaleView.setEval_star(rs.getInt("eval_star"));
				prodStarSaleView.setProd_id(rs.getInt("prod_id"));
				prodStarSaleView.setProd_num(rs.getInt("prod_num"));
				prodStarSaleView.setProd_spec_id(rs.getInt("prod_spec_id"));
				
			
				
				list.add(prodStarSaleView);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
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
	public Integer getNumComment(int id) {
		int total = 0;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement(
					"SELECT ps.prod_id, COUNT(op.eval_star) FROM order_prod op JOIN prod_spec ps ON ps.prod_spec_id = op.prod_spec_id WHERE op.eval_star != 0 AND ps.prod_id = ? GROUP BY ps.prod_id");
			ps.setInt(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				total= rs.getInt(2);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return total;
	}

	@Override
	public Integer getNumSale(int id) {
		int total = 0;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement(
					"SELECT ps.prod_id, SUM(op.prod_num) FROM order_prod op JOIN prod_spec ps ON ps.prod_spec_id = op.prod_spec_id WHERE ps.prod_id= ? GROUP BY ps.prod_id");
			ps.setInt(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				total= rs.getInt(2);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return total;
	}

	@Override
	public Double getStarRate(int id) {
		double total = 0;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement(
					"SELECT ps.prod_id, AVG(op.eval_star) FROM order_prod op JOIN prod_spec ps ON ps.prod_spec_id = op.prod_spec_id WHERE op.eval_star != 0 AND ps.prod_id = ? GROUP BY ps.prod_id");
			ps.setInt(1, id);

			rs = ps.executeQuery();
			
			while (rs.next()) {
				total= rs.getDouble(2);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return total;
	}
	
}
