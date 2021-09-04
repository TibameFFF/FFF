package com.shop.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.shop.dao.ProdDAO;
import com.shop.model.Prod;
import com.shop.util.Util;


public class ProdDAOImpl implements ProdDAO {
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
	public void add(Prod prod) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("INSERT INTO shop.prod(prod_type_no, prod_name, prod_text, prod_on_time, prod_off_time, prod_status) VALUES(?, ?, ?, ?, ?, ?)");
			ps.setInt(1, prod.getProd_type_no());
			ps.setString(2, prod.getProd_name());
			ps.setString(3, prod.getProd_text());
			ps.setTimestamp(4, prod.getProd_on_time());
			ps.setTimestamp(5, prod.getProd_off_time());
			ps.setByte(6, prod.getProd_status());
			
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
	public void update(Prod prod) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("UPDATE shop.prod SET prod_type_no=? , prod_name=?, prod_text=?, prod_on_time=?, prod_off_time=?, prod_status=? WHERE prod_id=?");
			ps.setInt(1, prod.getProd_type_no());
			ps.setString(2, prod.getProd_name());
			ps.setString(3, prod.getProd_text());
			ps.setTimestamp(4, prod.getProd_on_time());
			ps.setTimestamp(5, prod.getProd_off_time());
			ps.setByte(6, prod.getProd_status());
			ps.setInt(7, prod.getProd_id());
			
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
			ps = con.prepareStatement("DELETE FROM shop.prod WHERE prod_id = ?");
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
	public Prod findByPK(int id) {
		Prod prod = new Prod();
		prod.setProd_id(id);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			ps = con.prepareStatement("SELECT * FROM shop.prod WHERE prod_id = ?");
			ps.setInt(1, id);
			
			rs= ps.executeQuery();
			
			rs.next();
			prod.setProd_name(rs.getString("prod_name"));
			prod.setProd_off_time(rs.getTimestamp("prod_off_time"));
			prod.setProd_on_time(rs.getTimestamp("prod_on_time"));
			prod.setProd_status(rs.getByte("prod_status"));
			prod.setProd_text(rs.getString("prod_text"));
			prod.setProd_type_no(rs.getInt("prod_type_no"));
			
			
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
		
		return prod;
	}

	@Override
	public List<Prod> getAll() {
		
		List<Prod> prodList = new ArrayList<>();
		
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs=st.executeQuery("SELECT * FROM shop.prod WHERE prod_status = 1" );
			
			while (rs.next()) {
				Prod prod = new Prod();
				prod.setProd_id(rs.getInt("prod_id"));
				prod.setProd_name(rs.getString("prod_name"));
				prod.setProd_off_time(rs.getTimestamp("prod_off_time"));
				prod.setProd_on_time(rs.getTimestamp("prod_on_time"));
				prod.setProd_status(rs.getByte("prod_status"));
				prod.setProd_text(rs.getString("prod_text"));
				prod.setProd_type_no(rs.getInt("prod_type_no"));
				
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
	

	@Override
	public List<Prod> getBySearch(String str) {
		List<Prod> prodList = new ArrayList<>();
		
		
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		int type =0;
		switch (str) {
		case "��暑隡��":
			type=1;
			break;
		case "蝢����":
			type=2;
			break;
		case "憸冽蝛踵":
			type=3;
			break;
		case "3C摰園":
			type=4;
			break;
		}
		try {
			con = ds.getConnection();
			if(type == 0) {
				st = con.prepareStatement("SELECT * FROM SHOP.prod WHERE (prod_name LIKE ? or prod_text LIKE ?) AND prod_status = 1");
				st.setString(1, "%"+str+"%");
				st.setString(2, "%"+str+"%");
			} else {
				st = con.prepareStatement("SELECT * FROM shop.prod WHERE prod_type_no =? AND prod_status =1 AND prod_status = 1");
				st.setInt(1, type);
			}
			
			rs=st.executeQuery();
			
			while (rs.next()) {
				Prod prod = new Prod();
				prod.setProd_id(rs.getInt("prod_id"));
				prod.setProd_name(rs.getString("prod_name"));
				prod.setProd_off_time(rs.getTimestamp("prod_off_time"));
				prod.setProd_on_time(rs.getTimestamp("prod_on_time"));
				prod.setProd_status(rs.getByte("prod_status"));
				prod.setProd_text(rs.getString("prod_text"));
				prod.setProd_type_no(rs.getInt("prod_type_no"));
				
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
	
//	SELECT  DISTINCT pr.*
//	FROM prod_spec ps
//	    JOIN prod pr ON pr.prod_id = ps.prod_id
//	    JOIN prod_ships pship ON pr.prod_id = pship.prod_id
//	    -- WHERE ps.prod_price BETWEEN 500 AND 999999; ��蝭拚
//	    -- WHERE pr.prod_type_no = 1 OR pr.prod_type_no = 2 �����祟�
//	    -- WHERE pship.ship_no = 1 OR pship.ship_no = 2 �����祟�
	
	public List<Prod> filterByPriceTypeShip(List<Integer> price, List<Integer> typeList, List<Integer> ship, String search ) {
		List<Prod> prodList = new ArrayList<Prod>();
		
		//create sql statement
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT  DISTINCT pr.* FROM prod_spec ps ")
			.append("JOIN prod pr ON pr.prod_id = ps.prod_id ")
			.append("JOIN prod_ships pship ON pr.prod_id = pship.prod_id WHERE 1 = 1");
		
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
		case "��暑隡��":
			type=1;
			break;
		case "蝢����":
			type=2;
			break;
		case "憸冽蝛踵":
			type=3;
			break;
		case "3C摰園":
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
		
		sql.append(" AND pr.prod_status =1");
		
//		System.out.println(sql);
		
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs = st.executeQuery(sql.toString());
	
			while (rs.next()) {
				Prod prod = new Prod();
				prod.setProd_id(rs.getInt("prod_id"));
				prod.setProd_name(rs.getString("prod_name"));
				prod.setProd_off_time(rs.getTimestamp("prod_off_time"));
				prod.setProd_on_time(rs.getTimestamp("prod_on_time"));
				prod.setProd_status(rs.getByte("prod_status"));
				prod.setProd_text(rs.getString("prod_text"));
				prod.setProd_type_no(rs.getInt("prod_type_no"));
				
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
	
	public static void main(String[] args) {
		ProdDAOImpl dao = new ProdDAOImpl();
		List<Integer> price = new ArrayList<Integer>();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Integer> ship = new ArrayList<Integer>();
		price.add(1);
		price.add(2);
		typeList.add(2);
		ship.add(1);
		ship.add(2);
		ship.add(3);
		
		
//		System.out.println(dao.filterByPriceTypeShip(price, typeList, ship, "1"));
	}

	@Override
	public Integer findProdTotalNum() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int result =0;
		try {
			con = ds.getConnection();
			st = con.createStatement();
			rs=st.executeQuery("SELECT COUNT(prod_id) FROM SHOP.prod WHERE prod_status = 1" );
			
			rs.next();
			result = rs.getInt(1);
			
			
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
		return result;
	}

}
