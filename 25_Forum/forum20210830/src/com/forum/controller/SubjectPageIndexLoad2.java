package com.forum.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class SubjectPageIndexLoad2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
	
		//step one 讀取前端值                           //問號後 傳值識別字串 
		String art = req.getParameter("article_type_num");
		//setp two String轉型int 值
	Integer articletypenum  = Integer.valueOf(art);
		//step three 值放入物件
	articletypenum = new articletypenum;
		//step four DAOImp get方法
		//step five 識別字串
		//step six  導向哪一個頁面
		
		}
	
}
