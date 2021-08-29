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

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/InfoServletSelect")
public class InfoServletSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();
		try {
			String account = request.getParameter("account");
			if (account.length() == 0) {
				return;
			}
			
			InfoService dao = new InfoService();
			HashMap userInfoMap = new HashMap();
			InfoVO infoVO = dao.findByPrimaryKey(account);

			userInfoMap.put("user_nickname", infoVO.getUser_nickname());
			userInfoMap.put("user_name", infoVO.getUser_name());
			userInfoMap.put("account", infoVO.getAccount());
			userInfoMap.put("email", infoVO.getEmail());
			userInfoMap.put("birthday", infoVO.getBitrhday());
			userInfoMap.put("password", infoVO.getPassword());
			String base64 = Base64.getMimeEncoder().encodeToString(infoVO.getPhoto());
			userInfoMap.put("photo", "data:image/jpeg;base64," + base64);

			JSONObject obj = new JSONObject(userInfoMap);
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
