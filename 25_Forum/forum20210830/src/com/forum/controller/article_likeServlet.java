 package com.forum.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAO.article_likeDAO;
import com.forum.model.article_like;

public class article_likeServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		
		article_likeDAO dao = new article_likeDAO();
		List<article_like> list = dao.getAll();

		
		HttpSession session = req.getSession();
		session.setAttribute("list", list);    
		
		String url = "/emp/listAllEmp2_getFromSession.jsp";//連接前端
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		return;
		
	}
}



