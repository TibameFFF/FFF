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
			// ���~�B�z
			// ����J
			String account = request.getParameter("account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("�п�J�b��");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}
			// ��J�榡���~
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("�п�J^[a-zA-z]\\w{5,19}$���b��");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}

			// select database
			InfoService infoSvc = new InfoService();
			InfoVO infoVO = infoSvc.findByPrimaryKey(account);
			if (infoVO == null) {
				errorMsgs.add("�b�����~");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}

			// finish forward
			String to = infoVO.getEmail();    
		    String subject = "���s�K�X�q��";  
		    String ch_name = infoVO.getAccount();
		    String reserURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/info/Reset.jsp";
		    String messageText = "Hello! " + ch_name + "\n���I�����}�i��K�X���m : " + reserURL; 
		    MailService mailService = new MailService();
		    mailService.sendMail(to, subject, messageText);
		    System.out.println(reserURL);
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("�L�k���o���:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Forgot.jsp");
			failureView.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
