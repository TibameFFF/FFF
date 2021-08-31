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
			// ���~�B�z
			// ����J
			String account = request.getParameter("account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("�п�J�b��");
			}
			
			String password = request.getParameter("password");
			if (password == null || (password.trim()).length() == 0) {
				errorMsgs.add("�п�J�s�K�X");
			}
			
			String repassword = request.getParameter("repassword");
			if (repassword == null || (repassword.trim()).length() == 0) {
				errorMsgs.add("�ЦA����J�s�K�X");
			}

			if (!password.equals(repassword)) {
				errorMsgs.add("�Цb�⦸��J�ۦP���s�K�X");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}
			// ��J�榡���~
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("�п�J^[a-zA-z]\\w{5,19}$���b��");
			}
			
			if ((!password.matches("^[a-zA-Z0-9]{6,20}$")) || (!repassword.matches("^[a-zA-Z0-9]{6,20}$"))) {
				errorMsgs.add("�п�J\"^[a-zA-Z0-9]{6,20}$\"���K�X");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}

			// select database
			InfoService infoSvc = new InfoService();			
			InfoVO infoVO = infoSvc.findByPrimaryKey(account);
			
			if (infoVO == null) {
				errorMsgs.add("�b�����~");
			}else {
				InfoService infoSvc2 = new InfoService();
				InfoVO infoVO2 = infoSvc2.update_info(infoVO.getUser_nickname(), infoVO.getUser_name(), repassword, infoVO.getPhoto(), account);

				if (infoVO2 == null) {
					errorMsgs.add("��s����");
				}
			}
			
			
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}

			//sendRedirect
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("�L�k���o���:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Reset.jsp");
			failureView.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
