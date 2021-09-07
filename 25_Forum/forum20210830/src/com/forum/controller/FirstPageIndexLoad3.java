package com.forum.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.DAOImp.Article_LikeDAOImp;
import com.forum.DAOImp.Article_TypeDAOImp;
import com.forum.model.article;
import com.forum.model.article_like;
import com.forum.model.article_type;
import com.shop.daoImpl.OrderProdDAOImpl;
import com.shop.model.OrderProd;

/**
 * Servlet implementation class FirstPageIndexLoad
 */
//@WebServlet("/FirstPageIndexLoad")
public class FirstPageIndexLoad3 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		try {
			req.setCharacterEncoding("UTF-8");
			
			
//step one 1撈主題分類 
			
			Article_TypeDAOImp article_type = new Article_TypeDAOImp();
			List<article_type> list = article_type.getArticle_Type_Num();
			
//step two 識別字串
			HttpSession session = req.getSession();//識別字串
			session.setAttribute("list", list);    
//step three 導向哪一個頁面
			String url = "/forum/navs.jsp";//連接前端
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}

}
