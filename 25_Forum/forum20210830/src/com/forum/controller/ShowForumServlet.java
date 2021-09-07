package com.forum.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.model.article;

@WebServlet("/ShowForumServlet")
public class ShowForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		article ar = new ArticleDAOImp().findByPrimaryKey(id);
		
		request.setAttribute("article", ar);
		

		RequestDispatcher dispatcher = request.getRequestDispatcher("/forum/navs_content.jsp");
		dispatcher.forward(request, response);
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
