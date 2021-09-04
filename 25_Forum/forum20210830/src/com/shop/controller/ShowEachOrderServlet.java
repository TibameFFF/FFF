package com.shop.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.Order;
import com.shop.model.OrderProd;
import com.shop.service.OrderProdService;
import com.shop.service.OrderService;
import com.sun.org.apache.bcel.internal.generic.NEW;

@WebServlet("/ShowEachOrderServlet")
public class ShowEachOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/ShowEachOrderServlet?order=5
		
		//訂單編號
		int orderID = Integer.parseInt(req.getParameter("order"));
		
		//取得訂單訊息
		OrderService os = new OrderService();
		Order order = os.getOneByOrderId(orderID);

		String[] shipInfo = order.getShip_info().split(",");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm");

		HashMap<String, String> orderDetailList = new HashMap<String, String>();
		orderDetailList.put("name", shipInfo[0]);
		orderDetailList.put("address", shipInfo[1]);
		orderDetailList.put("phone", shipInfo[2]);
		orderDetailList.put("email", shipInfo[3]);
		orderDetailList.put("date", sf.format(new Date(order.getOrd_time().getTime())));
		orderDetailList.put("status", order.getOrd_status());
		orderDetailList.put("total", order.getOrd_total().toString());
		orderDetailList.put("shipFee", order.getShip_fee().toString());
		orderDetailList.put("shipName", order.getShip_method());
		orderDetailList.put("id", "O"+ order.getOrd_no());

		//取得訂單商品訊息
		OrderProdService ops = new OrderProdService();
		List<OrderProd> prodList = ops.getAllByOrdNo(orderID);
		req.setAttribute("prodList", prodList);
		//http://localhost:8081/FFF/OrderProdImage?id=1
		
		
		req.setAttribute("orderDetailList", orderDetailList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/Shop/order1_each.jsp");
		dispatcher.forward(req, res);
		
//		res.setContentType("text/html");
//		res.setCharacterEncoding("UTF-8");
//		res.getWriter().write(orderDetailList.toString());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
