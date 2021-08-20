package com.shop.util;
//http://localhost:8081/FFF/OrderProdImage?id=1
import java.io.BufferedInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/OrderProdImage")
public class OrderProdImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
       
	public void init(ServletConfig config) throws ServletException {
	
		try {
			Context ctx = new InitialContext();
			//¶³ºÝÁp½u
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/FFF");
			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
//			ResultSet rs = stmt.executeQuery(
//				"SELECT IMAGE FROM PICTURES WHERE PID = " + req.getParameter("PID"));
			String id = req.getParameter("id");
			ResultSet rs = stmt.executeQuery(
					"SELECT hist_prod_pic FROM order_prod WHERE ord_prod_id = " + id);

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("hist_prod_pic"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
