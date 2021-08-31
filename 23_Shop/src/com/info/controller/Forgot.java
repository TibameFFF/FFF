package com.info.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/Forgot")
public class Forgot extends HttpServlet {
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

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}
			// 輸入格式錯誤
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("請輸入^[a-zA-z]\\w{5,19}$的帳號");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// select database
			InfoService infoSvc = new InfoService();
			InfoVO infoVO = infoSvc.findByPrimaryKey(account);
			if (infoVO == null) {
				errorMsgs.add("帳號錯誤");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// 程式中斷
			}

			// finish forward
			String to = infoVO.getEmail();    
		    String subject = "重製密碼通知";  
		    String ch_name = infoVO.getAccount();
		    String reserURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/info/Reset.jsp";
		    String messageText = "Hello! " + ch_name + "\n請點擊網址進行密碼重置 : " + reserURL; 
		    MailService mailService = new MailService();
		    mailService.sendMail(to, subject, messageText);
		    System.out.println(reserURL);
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
			failureView.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
