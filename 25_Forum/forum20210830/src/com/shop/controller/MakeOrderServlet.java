package com.shop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.info.model.InfoVO;
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
import com.shop.util.Util;

import redis.clients.jedis.Jedis;

@WebServlet("/MakeOrderServlet")
public class MakeOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		int memberId = member.getUser_id();

//		//�ݦ�����Ѽưe�L��
//		Map<String, String[]> allData = req.getParameterMap();
//		for (String str: allData.keySet()) 
//			System.out.println(str);

		// �ʶRspecID List
		String[] specId = req.getParameterValues("spec_id");
		List<Integer> specIdList = new ArrayList<Integer>();// �ʶR��spec id
		List<Integer> numList = new ArrayList<Integer>();// �ʶR���ƶq

		int total = 0;
		// ����List
		for (String str : specId) {
			specIdList.add(Integer.parseInt(str));
			numList.add(Integer.parseInt(req.getParameter("prodNum" + str)));
		}

		List<Integer> errorMessage = new ArrayList<Integer>();
		// ���o�ӫ~��T�M�`�B
		ProdSpecService prodSpecService = new ProdSpecService();
		for (int i = 0; i < specIdList.size(); i++) {
			ProdSpec prodSpec = prodSpecService.getOneProdSpecByPK(specIdList.get(i));

			// �ˬd�w�s
			if (prodSpec.getStock() - numList.get(i) < 0)
				errorMessage.add(prodSpec.getStock());
			else
				errorMessage.add(0);

			total += prodSpec.getProd_price() * numList.get(i);
		}

		// �p�G���ʶR�ƶq�j��w�s�q�N�^�h�ʪ�������
		for (int error : errorMessage) {
			if (error != 0) {
				req.setAttribute("errorMessage", errorMessage);
				req.getRequestDispatcher("/ShowCartServlet").forward(req, res);
				return;
			}
		}

		

		// ���o�ʶR��T
		String shipMethodNo = req.getParameter("ship_method");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone1") + req.getParameter("phone2");
		String address = req.getParameter("zipcode") + req.getParameter("county") + req.getParameter("district")
				+ req.getParameter("address");
		String email = req.getParameter("email");
		String cardNum = req.getParameter("card_num1") + req.getParameter("card_num2") + req.getParameter("card_num3")
				+ req.getParameter("card_num4");
		String cardDate = req.getParameter("date");
		String cvn = req.getParameter("CVN");
		String cardName = req.getParameter("card_name");

		//��J����ˬd
//		List<String> inputErrorList = new ArrayList<String>();
//		if(! phone.matches("09\\d{8}")) 
//			inputErrorList.add("������X�榡���~");
//		if(! email.matches("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$"))
//			inputErrorList.add("Email�榡���~");
//		if(! cardNum.matches("\\d{16}") || !cardDate.matches("\\d{2}/\\d{2}") || !cvn.matches("\\d{3}"))
//			inputErrorList.add("�H�Υd�榡���~");
//
//		if(inputErrorList.size() != 0) {
//			req.setAttribute("inputErrorList", inputErrorList);
//			req.getRequestDispatcher("/Shop/buy2_comfirm.jsp").forward(req, res);
//			return;
//		}
		
		
		// ���o�B�e��T
		ShipMethodService shipMethodService = new ShipMethodService();
		ShipMethod shipMethod = shipMethodService.getOneShipMethodByPK(Integer.parseInt(shipMethodNo));
		int shipFee = shipMethod.getShip_fee();
		String shipName = shipMethod.getShip_name();

		// ���ʶR��T�r��
		StringBuilder str = new StringBuilder();
		str.append(name).append(",").append(address).append(",").append(phone).append(",").append(email);

		// �e�X�q��A�ȪA�H��ID���g����1
		DataSource ds = null;
		try {
			Context ctx = new javax.naming.InitialContext(); //�i������ܼ�
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Shop");
		} catch (NamingException e2) {
			e2.printStackTrace();
		}
		Connection con = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			
			OrderService orderService = new OrderService();
			Order order = orderService.add(con, "�q�榨��", new Timestamp(new Date().getTime()), total, shipFee, shipName,
					str.toString(), 1, memberId);
			int orderID = order.getOrd_no();

			OrderProdService orderProdService = new OrderProdService();
			ProdService prodService = new ProdService();
			ProdPicsService prodPicsService = new ProdPicsService();
			for (int i = 0; i < specIdList.size(); i++) {
				ProdSpec prodSpec = prodSpecService.getOneProdSpecByPK(specIdList.get(i));
				Prod prod = prodService.getOneById(prodSpec.getProd_id());
				byte[] prodPic = prodPicsService.getAllProdPicByProdIDForOrder(prod.getProd_id()).get(0).getProd_pic();

				orderProdService.addOrderProd(con, orderID, specIdList.get(i), prod.getProd_name(), prodSpec.getSpec_name(),
						prodSpec.getProd_price(), prodPic, numList.get(i));
			}
			
			// �M���ʶR�ӫ~���ʪ������e
			String userID = "cart:id:" + memberId;

			Jedis jedis = new Jedis("localhost", 6379);

			for (int id : specIdList) {
				String specID = Integer.toString(id);
				jedis.hdel(userID, specID);
			}

			jedis.close();
			
			// �ɨ��ʪ���������
			req.setAttribute("orderID", orderID);
			RequestDispatcher requestDispatcher = req.getRequestDispatcher("/Shop/buy3_complete.jsp");
			requestDispatcher.forward(req, res);
			
		} catch (SQLException e) {
			
			try {
				con.rollback();
				req.getRequestDispatcher("/Shop/order_error.jsp").forward(req, res);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		

		

//		res.setContentType("text/html");
//		res.getWriter().write("aaa");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
