package com.forum.serverlet;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.Article_PictureDAOImp;
import com.forum.model.article_picture;


//@WebServlet("/forum/article_pictureServlet")
public class article_pictureServlet extends HttpServlet {
	
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getAll".equals(action)) {
		Article_PictureDAOImp dao = new Article_PictureDAOImp();
		List<article_picture> list = dao.getAll();

		
		HttpSession session = req.getSession();
		session.setAttribute("list", list);    
		
		String url = "/article_picture/listAllEmp2_getFromSession.jsp";//連接前端
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		return;
		}
		
		
		if ("getOne_For_Display".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("pic_id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J���u�s��");
		}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/article_picture/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Integer pic_id = null;
				try {
					pic_id  = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���u�s���榡�����T");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/article_picture/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
			//////////////////////////////////////////////////	
				Article_PictureDAOImp dao = new Article_PictureDAOImp();
				article_picture article_picture = dao.findByPrimaryKey(pic_id);
				if (article_picture == null) {
					errorMsgs.add("�d�L���");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/article_picture/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				////////////////////////////////////////////
				req.setAttribute("article_picture", article_picture);
				String url = "/article_picture/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);
				////////////////////////////////////////
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/article_picture/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

		
	




