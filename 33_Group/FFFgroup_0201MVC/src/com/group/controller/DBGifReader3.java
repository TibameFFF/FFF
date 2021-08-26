package com.group.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.sql.DataSource;

@SuppressWarnings("serial")
public class DBGifReader3 extends HttpServlet {

	Connection con;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
			String g_no =req.getParameter("g_no");
			ResultSet rs = stmt.executeQuery(
				"SELECT PHOTO FROM GROUP1.GROUP WHERE G_NO ="+g_no);

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("PHOTO"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
				InputStream in = getServletContext().getResourceAsStream("/group/bunny/nophoto.gif");
				byte[] b = new byte[in.available()];
				in.read(b);
				out.write(b);
				in.close();

			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
//			System.out.println(e);
			InputStream in = getServletContext().getResourceAsStream("/group/bunny/nophoto.gif");
			byte[] b = new byte[in.available()];
			in.read(b);
			out.write(b);
			in.close();

		}
	}

	public void init() throws ServletException {
		try {
			Context ctx =new javax.naming.InitialContext();
			DataSource ds= (DataSource) ctx.lookup("java:comp/env/jdbc/David");
			con =ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

}