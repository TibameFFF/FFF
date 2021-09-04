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

import com.forum.DAOImp.Article_LikeDAOImp;
import com.forum.model.article_like;

public class article_likeServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getAll".equals(action)) {
			
		Article_LikeDAOImp Imp = new Article_LikeDAOImp();
		List<article_like> list = Imp.getAll();

		
		HttpSession session = req.getSession();//識別字串
		session.setAttribute("list", list);    
		
		String url = "/emp/listAllEmp2_getFromSession.jsp";//連接前端
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		return;
		}	
		
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String str = req.getParameter("like_id");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J���u�s��");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/article_like/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				Integer like_id = null;
				try {
					like_id = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("���u�s���榡�����T");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/article_like/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				Article_LikeDAOImp Imp = new Article_LikeDAOImp();
				article_like article_like = Imp.article_likefindByPrimaryKey(like_id);
				if (article_like == null) {
					errorMsgs.add("�d�L���");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/article_like/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				req.setAttribute("article_like", article_like);
				String url = "/article/listonearticle_like.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/article_like/select_page.jsp");
				failureView.forward(req, res);
				
				}
				
			}
	}
}




