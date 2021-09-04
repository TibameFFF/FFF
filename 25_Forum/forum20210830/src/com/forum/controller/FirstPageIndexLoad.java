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
public class FirstPageIndexLoad extends HttpServlet {
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
			
//	2撈觀看前十  
			ArticleDAOImp article1  = new ArticleDAOImp();
			List<article> list1 = article1.getPageviews();
////	3撈最新前十 
			ArticleDAOImp article2  = new ArticleDAOImp();
			List<article> list2 = article2.getArticle_Time();
////	4撈商品前十 
		OrderProdDAOImpl orderProd = new OrderProdDAOImpl();
			List<OrderProd> list3 = orderProd.getProd_Num();


//step two 識別字串
			HttpSession session = req.getSession();//識別字串
			HttpSession session1 = req.getSession();//識別字串
			HttpSession session2 = req.getSession();//識別字串
			HttpSession session3= req.getSession();//識別字串
			session.setAttribute("list", list);    
			session1.setAttribute("list1", list1);    
			session2.setAttribute("list2", list2);    
			session3.setAttribute("list3", list3);    
//step three 導向哪一個頁面
			String url = "/forum/index.jsp";//連接前端
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
