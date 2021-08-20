package com.shop.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.Order;
import com.shop.model.Prod;
import com.shop.model.ProdSpec;
import com.shop.model.ShipMethod;
import com.shop.service.OrderProdService;
import com.shop.service.OrderService;
import com.shop.service.ProdPicsService;
import com.shop.service.ProdService;
import com.shop.service.ProdSpecService;
import com.shop.service.ShipMethodService;

@WebServlet("/MakeOrderServlet")
public class MakeOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	���setAutoCommit!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//reload���D�ݸѨM
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		
//		//�ݦ�����Ѽưe�L��
//		Map<String, String[]> allData = req.getParameterMap();
//		for (String str: allData.keySet()) 
//			System.out.println(str);
		
		//�ʶRspecID List
		String[] specId = req.getParameterValues("spec_id");
		List<Integer> specIdList = new ArrayList<Integer>();//�ʶR��spec id
		List<Integer> numList = new ArrayList<Integer>();//�ʶR���ƶq
		
		
		int total=0;
		//����List
		for(String str: specId) {
			specIdList.add(Integer.parseInt(str));
			numList.add(Integer.parseInt(req.getParameter("prodNum"+str)));
		}
		
		//���o�ӫ~��T�M�`�B
		ProdSpecService prodSpecService = new ProdSpecService();
		for(int i=0; i<specIdList.size(); i++) {
			ProdSpec prodSpec = prodSpecService.getOneProdSpecByPK(specIdList.get(i));
			total += prodSpec.getProd_price()*numList.get(i);
		}
		
		
		
		
		
		//���o�ʶR��T
		String shipMethodNo = req.getParameter("ship_method");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone1")+req.getParameter("phone2");
		String address = req.getParameter("zipcode")+req.getParameter("county")+req.getParameter("district")+req.getParameter("address");
		String email = req.getParameter("email");
		String cardNum = req.getParameter("card_num1")+req.getParameter("card_num2")+req.getParameter("card_num3")+req.getParameter("card_num4");
		String cardDate = req.getParameter("date");
		String cvn = req.getParameter("CVN");
		String cardName = req.getParameter("card_name");
		
		//���o�B�e��T
		ShipMethodService shipMethodService = new ShipMethodService();
		ShipMethod shipMethod = shipMethodService.getOneShipMethodByPK(Integer.parseInt(shipMethodNo));
		int shipFee = shipMethod.getShip_fee();
		String shipName = shipMethod.getShip_name();
		
		//���ʶR��T�r��
		StringBuilder str = new StringBuilder();
		str.append(name).append(",").append(address).append(",").append(phone).append(",").append(email);
//		//�e�X�q��
		OrderService orderService = new OrderService();
//		//�|��ID�M�ȪA�H��ID�����g����1
		Order order = orderService.add("�q�榨��", new Timestamp(new Date().getTime()), total, shipFee, shipName,str.toString(), 1, 1);
		int orderID= order.getOrd_no();
		
		OrderProdService orderProdService = new OrderProdService();
		ProdService prodService = new ProdService();
		ProdPicsService prodPicsService = new ProdPicsService();
		for(int i=0; i<specIdList.size(); i++) {
			ProdSpec prodSpec = prodSpecService.getOneProdSpecByPK(specIdList.get(i));
			Prod prod = prodService.getOneById(prodSpec.getProd_id());
			byte[] prodPic = prodPicsService.getAllProdPicByProdID(prod.getProd_id()).get(0).getProd_pic();
			
			orderProdService.addOrderProd(orderID, specIdList.get(i), prod.getProd_name(), prodSpec.getSpec_name(), prodSpec.getProd_price(), prodPic, numList.get(i));
		}
		
		req.setAttribute("orderID", orderID);
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("/Shop/buy3_complete.jsp");
		requestDispatcher.forward(req, res);
		
//		res.setContentType("text/html");
//		res.getWriter().write("aaa");
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
