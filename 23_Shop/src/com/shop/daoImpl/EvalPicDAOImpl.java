package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dao.EvalPicDAO;
import com.shop.model.EvalPic;
import com.shop.model.ProdSpec;
import com.shop.util.Util;


public class EvalPicDAOImpl implements EvalPicDAO{

	@Override
	public void add(EvalPic evalPic) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("INSERT INTO shop.eval_pic(ord_prod_id, eval_pic) VALUES(?, ?)");
			
			ps.setInt(1, evalPic.getOrd_prod_id());
			ps.setBytes(2, evalPic.getEval_pic());
			
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
	public List<EvalPic> findByProdID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		List<EvalPic> list = new ArrayList<EvalPic>();
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("SELECT * FROM shop.eval_pic WHERE eval_pic_id=?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				EvalPic evalPic = new EvalPic();
				evalPic.setEval_pic(rs.getBytes("eval_pic"));
				evalPic.setOrd_prod_id(rs.getInt("ord_prod_id"));
				evalPic.setEval_pic_id(rs.getInt("eval_pic_id"));
				list.add(evalPic);
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
	
	public static void main(String[] args) {
		EvalPicDAOImpl dao = new EvalPicDAOImpl();
		List<EvalPic> evalPics = dao.findByProdID(2);
		System.out.println(evalPics);
	}

}
