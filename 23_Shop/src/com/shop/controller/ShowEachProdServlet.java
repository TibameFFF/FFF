package com.shop.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowEachProd")
public class ShowEachProdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
	int prodID = Integer.parseInt(req.getParameter("prodID"));
	
	req.setAttribute("prodID", prodID);
	
	RequestDispatcher dispatcher = req.getRequestDispatcher("/Shop/shop3_product.jsp");// 成功轉交 update_emp_input.jsp
	dispatcher.forward(req, res);
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
