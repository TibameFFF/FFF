package com.shop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.Order;
import com.shop.service.OrderService;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String id = req.getParameter("id");
		
		
		OrderService orderService = new OrderService();
		Order order = orderService.getOneByOrderId(Integer.parseInt(id));
		
		orderService.updateOrder("訂單取消", order.getOrd_total(), Integer.parseInt(id));

		res.setContentType("text/html");
		res.setCharacterEncoding("UTF-8");
		res.getWriter().write("取消成功!");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
