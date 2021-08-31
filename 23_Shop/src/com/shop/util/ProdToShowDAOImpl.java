package com.shop.util;

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

import com.shop.model.Prod;


public class ProdToShowDAOImpl implements ProdToShowDAO {
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
	public List<ProdToShow> getAll() {
		Connection con = null;
		Statement ps = null;
		List<ProdToShow> list = new ArrayList<ProdToShow>();
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			ps = con.createStatement();
			rs = ps.executeQuery("SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price), pr.prod_status FROM prod pr JOIN prod_spec ps ON ps.prod_id = pr.prod_id WHERE pr.prod_status = 1 GROUP BY pr.prod_id");
			
			while(rs.next()) {
				ProdToShow prodToShow = new ProdToShow();
				
				prodToShow.setProd_id(rs.getInt(1));
				prodToShow.setProd_name(rs.getString(2));
				prodToShow.setPrice(rs.getInt(3));
				prodToShow.setStatus(rs.getByte(4));
				
				list.add(prodToShow);
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
	public ProdToShow getByPk(int id) {
		ProdToShow prodToShow = new ProdToShow();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price), pr.prod_status FROM prod pr JOIN prod_spec ps ON ps.prod_id = pr.prod_id WHERE pr.prod_id=? GROUP BY pr.prod_id ");
			ps.setInt(1, id);
			
			rs= ps.executeQuery();
			
			rs.next();
			prodToShow.setProd_id(rs.getInt(1));
			prodToShow.setProd_name(rs.getString(2));
			prodToShow.setPrice(rs.getInt(3));
			prodToShow.setStatus(rs.getByte(4));
			
			
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
		
		return prodToShow;
	}

	@Override
	public List<ProdToShow> getBySearch(String search) {
		List<ProdToShow> prodList = new ArrayList<>();
		
		
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		int type =0;
		switch (search) {
		case "生活休閒":
			type=1;
			break;
		case "美妝保養":
			type=2;
			break;
		case "風格穿搭":
			type=3;
			break;
		case "3C家電":
			type=4;
			break;
		}
		try {
			con = ds.getConnection();
			if(type == 0) {
				st = con.prepareStatement("SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price) FROM prod pr JOIN prod_spec ps ON ps.prod_id = pr.prod_id WHERE (pr.prod_name LIKE ? OR pr.prod_text LIKE ?) AND pr.prod_status = 1 GROUP BY pr.prod_id ");
				st.setString(1, "%"+search+"%");
				st.setString(2, "%"+search+"%");
			} else {
				st = con.prepareStatement("SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price) FROM prod pr JOIN prod_spec ps ON ps.prod_id = pr.prod_id WHERE pr.prod_type_no = ? AND pr.prod_status = 1  GROUP BY pr.prod_id ");
				st.setInt(1, type);
			}
			
			rs=st.executeQuery();
			
			while (rs.next()) {
				ProdToShow prod = new ProdToShow();
				prod.setProd_id(rs.getInt(1));
				prod.setProd_name(rs.getString(2));
				prod.setPrice(rs.getInt(3));
				
				prodList.add(prod);
				
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
		
		return prodList;
	}
//	SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price)
//	FROM prod_spec ps
//	    JOIN prod pr ON pr.prod_id = ps.prod_id
//	    JOIN prod_ships pship ON pr.prod_id = pship.prod_id
//	WHERE ps.prod_price BETWEEN 500 AND 999999 商品價格篩選
//	WHERE pr.prod_type_no = 1 OR pr.prod_type_no = 2 商品分類篩選
//	WHERE pship.ship_no = 1 OR pship.ship_no = 2 商品運送篩選
//	GROUP BY pr.prod_id
	@Override
	public List<ProdToShow> filterByPriceTypeShip(List<Integer> price, List<Integer> typeList, List<Integer> ship,
			String search) {
		List<ProdToShow> prodList = new ArrayList<ProdToShow>();
		//create sql statement
				StringBuilder sql = new StringBuilder();
				sql.append("SELECT DISTINCT pr.prod_id, pr.prod_name, MIN(ps.prod_price) FROM prod_spec ps ")
					.append("JOIN prod pr ON pr.prod_id = ps.prod_id ")
					.append("JOIN prod_ships pship ON pr.prod_id = pship.prod_id WHERE pr.prod_status = 1 ");
				
				if(price.size()!=0) {
					sql .append(" AND (ps.prod_price BETWEEN ")
						.append(price.get(0))
						.append(" AND ")
						.append(price.get(1))
						.append(")");
				
				}
				
				if(typeList.size()!=0) {
					sql.append(" AND ( pr.prod_type_no =");
					for(int i=0; i<typeList.size(); i++) {
						sql.append(typeList.get(i));
						if(i != typeList.size()-1) {
							sql.append(" OR pr.prod_type_no = ");
						}
					}
					sql.append(")");
				}
				
				if(ship.size()!=0) {
					sql.append(" AND ( pship.ship_no = ");
					for(int i=0; i<ship.size(); i++) {
						sql.append(ship.get(i));
						if(i != ship.size()-1) {
							sql.append("  OR pship.ship_no = ");
						}
					}
					sql.append(")");
				}
				
				
				int type =0;
				switch (search) {
				case "生活休閒":
					type=1;
					break;
				case "美妝保養":
					type=2;
					break;
				case "風格穿搭":
					type=3;
					break;
				case "3C家電":
					type=4;
					break;
				}
				
				if(type == 0) {
					sql.append("AND ( pr.prod_name LIKE '%")
					.append(search)
					.append("%' OR pr.prod_text LIKE '%")
					.append(search)
					.append("%')");
				} else {
					sql.append(" AND pr.prod_type_no = ").append(type);
				}
				
				sql.append(" GROUP BY pr.prod_id");
				
//				System.out.println(sql);
				
				
				Connection con = null;
				Statement st = null;
				ResultSet rs = null;
				try {
					con = ds.getConnection();
					st = con.createStatement();
					rs = st.executeQuery(sql.toString());
			
					while (rs.next()) {
						ProdToShow prod = new ProdToShow();
						prod.setProd_id(rs.getInt(1));
						prod.setProd_name(rs.getString(2));
						prod.setPrice(rs.getInt(3));
						
						prodList.add(prod);
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
				
				
				return prodList;
	}

}
