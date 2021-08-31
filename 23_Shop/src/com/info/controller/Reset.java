package com.info.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/Reset")
public class Reset extends HttpServlet {
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
			String account = request.getParameter("account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("請輸入帳號");
			}
			
			String password = request.getParameter("password");
			if (password == null || (password.trim()).length() == 0) {
				errorMsgs.add("請輸入新密碼");
			}
			
			String repassword = request.getParameter("repassword");
			if (repassword == null || (repassword.trim()).length() == 0) {
				errorMsgs.add("請再次輸入新密碼");
			}

			if (!password.equals(repassword)) {
				errorMsgs.add("請在兩次輸入相同的新密碼");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}
			// 輸入格式錯誤
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("請輸入^[a-zA-z]\\w{5,19}$的帳號");
			}
			
			if ((!password.matches("^[a-zA-Z0-9]{6,20}$")) || (!repassword.matches("^[a-zA-Z0-9]{6,20}$"))) {
				errorMsgs.add("請輸入\"^[a-zA-Z0-9]{6,20}$\"的密碼");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// select database
			InfoService infoSvc = new InfoService();			
			InfoVO infoVO = infoSvc.findByPrimaryKey(account);
			
			if (infoVO == null) {
				errorMsgs.add("帳號錯誤");
			}else {
				InfoService infoSvc2 = new InfoService();
				InfoVO infoVO2 = infoSvc2.update_info(infoVO.getUser_nickname(), infoVO.getUser_name(), repassword, infoVO.getPhoto(), account);

				if (infoVO2 == null) {
					errorMsgs.add("更新失敗");
				}
			}
			
			
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			//sendRedirect
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
			failureView.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
