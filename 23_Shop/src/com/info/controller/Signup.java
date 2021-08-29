package com.info.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		PrintWriter out = response.getWriter();

		List<String> errorMsgs = new LinkedList<String>();
		request.setAttribute("errorMsgs", errorMsgs);
		try {
			// 錯誤處理
			// 未輸入
			String name = request.getParameter("signup-name");
			if (name == null || (name.trim()).length() == 0) {
				errorMsgs.add("請輸入姓名");
			}

			String nickname = request.getParameter("signup-nickname");
			if (nickname == null || (nickname.trim()).length() == 0) {
				errorMsgs.add("請輸入暱稱");
			}
			
			String account = request.getParameter("signup-account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("請輸入帳號");
			}
			
			String email = request.getParameter("signup-email");
			if (email == null || (email.trim()).length() == 0) {
				errorMsgs.add("請輸入電子信箱");
			}
			
			String birthday = request.getParameter("signup-birthday");
			if (birthday == null || (birthday.trim()).length() == 0) {
				errorMsgs.add("請輸入生日");
			}
			
			String sex = request.getParameter("signup-radio");
			if (sex == null || (sex.trim()).length() == 0) {
				errorMsgs.add("請選擇性別");
			}
			
			String password = request.getParameter("signup-password");
			if (password == null || (password.trim()).length() == 0) {
				errorMsgs.add("請輸入密碼");
			}
			
			String repassword = request.getParameter("signup-repassword");
			if (repassword == null ||(repassword.trim()).length() == 0) {
				errorMsgs.add("請再次輸入密碼");
			}
			
			if (!password.equals(repassword)) {
				errorMsgs.add("請輸入相同的密碼");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}
			
			// 輸入格式錯誤
			if (!account.matches("^[a-zA-Z0-9\\u4e00-\\u9fa5]+$")) {
				errorMsgs.add("請輸入^[a-zA-Z0-9\\u4e00-\\u9fa5]+$的姓名");
			}
			if (!account.matches("^[a-zA-Z0-9\\\\u4e00-\\\\u9fa5]+$")) {
				errorMsgs.add("請輸入^[a-zA-Z0-9\\\\u4e00-\\\\u9fa5]+$的暱稱");
			}
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("請輸入^[a-zA-z]\\w{5,19}$的帳號");
			}
			if (!email.matches("^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$")) {
				errorMsgs.add("請輸入^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$的電子信箱");
			}
			
			if (!password.matches("^[a-zA-Z0-9]{6,20}$")) {
				errorMsgs.add("請輸入\"^[a-zA-Z0-9]{6,20}$\"的密碼");
			}
			
			if (!repassword.matches("^[a-zA-Z0-9]{6,20}$")) {
				errorMsgs.add("請輸入\"^[a-zA-Z0-9]{6,20}$\"的密碼");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// select database
			InfoService infoSvc = new InfoService();
			InputStream fis = null;
			byte[] buffer = null;
			try {
				fis = getServletContext().getResourceAsStream("/info/img/123.jpg");
				buffer = new byte[fis.available()];
				fis.read(buffer);
			} catch (IOException e) {
				e.getMessage();
			} finally {
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						e.getMessage();
					}
				}
			}
			String intro = "";
			InfoVO infoVO = infoSvc.add(nickname, name, account, email, java.sql.Date.valueOf(birthday), password, Integer.parseInt(sex), buffer, intro);
			
			if (infoVO == null) {
				errorMsgs.add("帳號or密碼or電子信箱重複");
			}

			if (!password.equals(infoVO.getPassword())) {
				errorMsgs.add("密碼錯誤");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// finish forward
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
			failureView.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
