package com.forum.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.model.article;



public class SubjectPageIndexLoad2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
	
		
		req.setCharacterEncoding("UTF-8");
	//step one 讀取前端值                           //問號後 傳值識別字串 
		String art = req.getParameter("article_type_num");
		String Type_name = req.getParameter("article_type_name");
	//setp two String轉型int 值
		Integer articletypenum  = Integer.valueOf(art);
	//step three 值放入物件
		article article = new article();
		article.setArticle_type_num(articletypenum);
	//step four DAOImp get方法
		ArticleDAOImp articleDAOImp = new ArticleDAOImp();
		List<article> articleList = articleDAOImp.queryByarticleWhereArticleTypeNum(article);
	//step five 識別字串
		HttpSession session1 = req.getSession();
		HttpSession session2 = req.getSession();
		session1.setAttribute("articleList", articleList);    
		session2.setAttribute("Type_name", Type_name);    
		//step six  導向哪一個頁面
		String url = "/forum/navs.jsp";//連接前端
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		return;
		}
	
}
