package com.info.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();

		List<String> errorMsgs = new LinkedList<String>();
		request.setAttribute("errorMsgs", errorMsgs);
		try {
			// 錯誤處理
			// 未輸入
			String account = request.getParameter("account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("請輸入帳號");
			}

			String password = request.getParameter("password");
			if (password == null || (password.trim()).length() == 0) {
				errorMsgs.add("請輸入密碼");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Login.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}
			// 輸入格式錯誤
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("請輸入^[a-zA-z]\\w{5,19}$的帳號");
			}

			if (!password.matches("^[a-zA-Z0-9]{6,20}$")) {
				errorMsgs.add("請輸入\"^[a-zA-Z0-9]{6,20}$\"的密碼");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Login.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// select database
			InfoService infoSvc = new InfoService();
			InfoVO infoVO = infoSvc.findByPrimaryKey(account);
			if (infoVO == null) {
				errorMsgs.add("帳號錯誤");
			}

			if (!password.equals(infoVO.getPassword())) {
				errorMsgs.add("密碼錯誤");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Login.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// finish forward
			session.setAttribute("infoVO", infoVO);
			session.setAttribute("login", "OK");
			HashMap photoMap = new HashMap();
			String base64 = Base64.getEncoder().encodeToString(infoVO.getPhoto());
			photoMap.put("photo", base64);
			session.setAttribute("photo", photoMap);
			String url = "info/Index.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Login.jsp");
			failureView.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
