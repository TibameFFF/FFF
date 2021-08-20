package com.shop.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.FavProdDAO;
import com.shop.model.FavProd;
import com.shop.util.Util;


public class FavProdDAOImpl implements FavProdDAO {
	static {
		
	}
	@Override
	public void add(FavProd favProd) {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("INSERT INTO shop.fav_prod (user_id,prod_id) VALUES(?,?)");

			ps.setInt(1, favProd.getUser_id());
			ps.setInt(2, favProd.getProd_id());

			ps.execute();

		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
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

	}

	@Override
	public void delete(FavProd favProd) {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("DELETE FROM shop.fav_prod WHERE user_id = ? AND prod_id = ?");

			ps.setInt(1, favProd.getUser_id());
			ps.setInt(2, favProd.getProd_id());

			ps.execute();

		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
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

	}

	@Override
	public List<FavProd> findByUserID(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<FavProd> list = new ArrayList<>();
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			ps = con.prepareStatement("SELECT * FROM shop.fav_prod WHERE user_id = ?");

			ps.setInt(1, id);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				FavProd fp = new FavProd();
				fp.setProd_id(rs.getInt("prod_id"));
				fp.setProd_fav_id(rs.getInt("prod_fav_id"));
				
				list.add(fp);
			}

		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
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
		return list;
	}


}
