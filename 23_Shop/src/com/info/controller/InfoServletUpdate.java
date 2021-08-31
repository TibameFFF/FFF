package com.info.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.info.model.InfoJDBCDAO;
import com.info.model.InfoService;
import com.info.model.InfoVO;

/**
 * Servlet implementation class InfoServletUpdate
 */
@WebServlet("/InfoServletUpdate")
public class InfoServletUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			String account = request.getParameter("account");
			if (account.length() == 0) {
				return;
			}
			String usernickname = request.getParameter("user_nickname");
			String username = request.getParameter("user_name");
			String password = request.getParameter("password");
			String photo = request.getParameter("photo");
			PrintWriter out = response.getWriter();

			InfoService dao = new InfoService();

			byte[] base64 = Base64.getMimeDecoder().decode(photo.substring(22));

			InfoVO infoVO = dao.update_info(usernickname, username, password, base64, account);
			JSONObject obj = new JSONObject(infoVO);
			out.println(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
