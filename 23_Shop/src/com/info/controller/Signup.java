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
			// ���~�B�z
			// ����J
			String name = request.getParameter("signup-name");
			if (name == null || (name.trim()).length() == 0) {
				errorMsgs.add("�п�J�m�W");
			}

			String nickname = request.getParameter("signup-nickname");
			if (nickname == null || (nickname.trim()).length() == 0) {
				errorMsgs.add("�п�J�ʺ�");
			}
			
			String account = request.getParameter("signup-account");
			if (account == null || (account.trim()).length() == 0) {
				errorMsgs.add("�п�J�b��");
			}
			
			String email = request.getParameter("signup-email");
			if (email == null || (email.trim()).length() == 0) {
				errorMsgs.add("�п�J�q�l�H�c");
			}
			
			String birthday = request.getParameter("signup-birthday");
			if (birthday == null || (birthday.trim()).length() == 0) {
				errorMsgs.add("�п�J�ͤ�");
			}
			
			String sex = request.getParameter("signup-radio");
			if (sex == null || (sex.trim()).length() == 0) {
				errorMsgs.add("�п�ܩʧO");
			}
			
			String password = request.getParameter("signup-password");
			if (password == null || (password.trim()).length() == 0) {
				errorMsgs.add("�п�J�K�X");
			}
			
			String repassword = request.getParameter("signup-repassword");
			if (repassword == null ||(repassword.trim()).length() == 0) {
				errorMsgs.add("�ЦA����J�K�X");
			}
			
			if (!password.equals(repassword)) {
				errorMsgs.add("�п�J�ۦP���K�X");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}
			
			// ��J�榡���~
			if (!account.matches("^[a-zA-Z0-9\\u4e00-\\u9fa5]+$")) {
				errorMsgs.add("�п�J^[a-zA-Z0-9\\u4e00-\\u9fa5]+$���m�W");
			}
			if (!account.matches("^[a-zA-Z0-9\\\\u4e00-\\\\u9fa5]+$")) {
				errorMsgs.add("�п�J^[a-zA-Z0-9\\\\u4e00-\\\\u9fa5]+$���ʺ�");
			}
			if (!account.matches("^[a-zA-z]\\w{5,19}$")) {
				errorMsgs.add("�п�J^[a-zA-z]\\w{5,19}$���b��");
			}
			if (!email.matches("^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$")) {
				errorMsgs.add("�п�J^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$���q�l�H�c");
			}
			
			if (!password.matches("^[a-zA-Z0-9]{6,20}$")) {
				errorMsgs.add("�п�J\"^[a-zA-Z0-9]{6,20}$\"���K�X");
			}
			
			if (!repassword.matches("^[a-zA-Z0-9]{6,20}$")) {
				errorMsgs.add("�п�J\"^[a-zA-Z0-9]{6,20}$\"���K�X");
			}
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// �{�����_
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
				errorMsgs.add("�b��or�K�Xor�q�l�H�c����");
			}

			if (!password.equals(infoVO.getPassword())) {
				errorMsgs.add("�K�X���~");
			}

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
				failureView.forward(request, response);
				return;// �{�����_
			}

			// finish forward
			String url = "info/Login.jsp";
			response.sendRedirect(url);

		} catch (Exception e) {
			errorMsgs.add("�L�k���o���:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("info/Signup.jsp");
			failureView.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
