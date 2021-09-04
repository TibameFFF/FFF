package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.fake.data.CommonConection;
import com.shop.dao.OrderProdDAO;
import com.shop.model.OrderProd;


public class OrderProdDAOImpl implements OrderProdDAO{
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
	public void add(Connection connection, OrderProd orderProd) throws SQLException{
		Connection con = connection;
		PreparedStatement ps = null;
		
		try {
//			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.order_prod(ord_no, prod_spec_id, hist_prod_name, hist_prod_spec, hist_prod_price, hist_prod_pic, prod_num) VALUES(?, ?, ?, ?,?,?,?)");
			
			ps.setInt(1, orderProd.getOrd_no());
			ps.setInt(2, orderProd.getProd_spec_id());
			ps.setString(3, orderProd.getHist_prod_name());
			ps.setString(4, orderProd.getHist_prod_spec());
			ps.setInt(5, orderProd.getHist_prod_price());
			ps.setBytes(6, orderProd.getHist_prod_pic());
			ps.setInt(7, orderProd.getProd_num());
			
			ps.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException();
		} finally {
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
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
	public void updateComment(OrderProd orderProd) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.order_prod SET eval_star=?, eval_text=? WHERE ord_prod_id=?");
			
			ps.setInt(1, orderProd.getEval_star());
			ps.setString(2, orderProd.getEval_text());
			ps.setInt(3, orderProd.getOrd_prod_id());
			
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
	public List<OrderProd> findByOrdNo(int ordNo) {
		Connection con = null;
		PreparedStatement ps = null;
		List<OrderProd> list = new ArrayList<OrderProd>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.order_prod WHERE ord_no=?");
			ps.setInt(1, ordNo);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				OrderProd orderProd = new OrderProd();
				
				orderProd.setEval_star(rs.getInt("eval_star"));
				orderProd.setEval_text(rs.getString("eval_text"));
				orderProd.setHist_prod_name(rs.getString("hist_prod_name"));
//				orderProd.setHist_prod_pic(rs.getBytes("hist_prod_pic"));
				orderProd.setHist_prod_price(rs.getInt("hist_prod_price"));
				orderProd.setHist_prod_spec(rs.getString("hist_prod_spec"));
				orderProd.setOrd_no(rs.getInt("ord_no"));
				orderProd.setOrd_prod_id(rs.getInt("ord_prod_id"));
				orderProd.setProd_num(rs.getInt("prod_num"));
				orderProd.setProd_spec_id(rs.getInt("prod_spec_id"));
				orderProd.setRe_ex_detail(rs.getString("re_ex_detail"));
				orderProd.setRe_ex_num(rs.getInt("re_ex_num"));
				orderProd.setRe_ex_pic(rs.getBytes("re_ex_pic"));
				orderProd.setRe_ex_price(rs.getInt("re_ex_price"));
				orderProd.setRe_ex_reason(rs.getString("re_ex_reason"));
				
			
				
				list.add(orderProd);
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
	public List<OrderProd> findByProdSpec(int specID) {
		Connection con = null;
		PreparedStatement ps = null;
		List<OrderProd> list = new ArrayList<OrderProd>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.order_prod WHERE prod_spec_id=?");
			ps.setInt(1, specID);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				OrderProd orderProd = new OrderProd();
				
				orderProd.setEval_star(rs.getInt("eval_star"));
				orderProd.setEval_text(rs.getString("eval_text"));
				orderProd.setHist_prod_name(rs.getString("hist_prod_name"));
				orderProd.setHist_prod_pic(rs.getBytes("hist_prod_pic"));
				orderProd.setHist_prod_price(rs.getInt("hist_prod_price"));
				orderProd.setHist_prod_spec(rs.getString("hist_prod_spec"));
				orderProd.setOrd_no(rs.getInt("ord_no"));
				orderProd.setOrd_prod_id(rs.getInt("ord_prod_id"));
				orderProd.setProd_num(rs.getInt("prod_num"));
				orderProd.setProd_spec_id(rs.getInt("prod_spec_id"));
				orderProd.setRe_ex_detail(rs.getString("re_ex_detail"));
				orderProd.setRe_ex_num(rs.getInt("re_ex_num"));
				orderProd.setRe_ex_pic(rs.getBytes("re_ex_pic"));
				orderProd.setRe_ex_price(rs.getInt("re_ex_price"));
				orderProd.setRe_ex_reason(rs.getString("re_ex_reason"));
				
			
				
				list.add(orderProd);
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

	
	public List<OrderProd> getProd_Num() {
		List<OrderProd> list3 = new ArrayList<OrderProd>();
		OrderProd orderProd = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			CommonConection commonConection = new CommonConection();
			con = commonConection.getConnectionShop();
			pstmt = con.prepareStatement("select * from shop.order_prod order by prod_num desc limit 10 ");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				orderProd = new OrderProd();
				orderProd.setEval_star(rs.getInt("eval_star"));
				orderProd.setEval_text(rs.getString("eval_text"));
				orderProd.setHist_prod_name(rs.getString("hist_prod_name"));
				orderProd.setHist_prod_pic(rs.getBytes("hist_prod_pic"));
				orderProd.setHist_prod_price(rs.getInt("hist_prod_price"));
				orderProd.setHist_prod_spec(rs.getString("hist_prod_spec"));
				orderProd.setOrd_no(rs.getInt("ord_no"));
				orderProd.setOrd_prod_id(rs.getInt("ord_prod_id"));
				orderProd.setProd_num(rs.getInt("prod_num"));
				orderProd.setProd_spec_id(rs.getInt("prod_spec_id"));
				orderProd.setRe_ex_detail(rs.getString("re_ex_detail"));
				orderProd.setRe_ex_num(rs.getInt("re_ex_num"));
				orderProd.setRe_ex_pic(rs.getBytes("re_ex_pic"));
				orderProd.setRe_ex_price(rs.getInt("re_ex_price"));
				orderProd.setRe_ex_reason(rs.getString("re_ex_reason"));
				
				list3.add(orderProd);
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
			
			if(pstmt != null) {
				try {
					pstmt.close();
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
		return list3;
	}
	
}
