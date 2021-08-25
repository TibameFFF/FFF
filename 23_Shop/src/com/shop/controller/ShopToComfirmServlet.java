package com.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.ProdShips;
import com.shop.model.ProdSpec;
import com.shop.service.ProdShipsService;
import com.shop.service.ProdSpecService;

@WebServlet("/ShopToComfirmServlet")
public class ShopToComfirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/ShopToComfirmServlet?specCheck=101&specAmount101=3&specCheck=120&specAmount120=7
		String[] checkList = req.getParameterValues("specCheck");

		LinkedHashMap<Integer, Integer> resultList = new LinkedHashMap<>();

		ArrayList<Integer> prodList = new ArrayList<Integer>(); // 取得所選擇spec的product ID List
		ProdSpecService pss = new ProdSpecService();
		// 計算商品數量和總價
		int num = 0;
		int total = 0;

		// 取得勾選商品清單和數量
		
		for (String str : checkList) {
			int specId = Integer.parseInt(str);
			int prodNum = Integer.parseInt(req.getParameter("specAmount" + str));
			num += prodNum;

			ProdSpec prodSpec = pss.getOneProdSpecByPK(specId);

			if(prodSpec.getStock() != 0) {//檢查商品有沒有庫存
				
				prodList.add(prodSpec.getProd_id());// 取得所選擇spec的product ID
				total += prodSpec.getProd_price();// 計算商品數量和總價
				resultList.put(specId, prodNum);
			}
		}

		// 商品總數和總計
		HashMap<String, Integer> totalList = new HashMap<String, Integer>();
		totalList.put("prodNum", num);
		totalList.put("total", total);

		// 選出可選擇的運送方式
		// 預設郵局包裹每個商品都可使用
		ProdShipsService prodShipsService = new ProdShipsService();

		ArrayList<Integer> allShipMethod = new ArrayList<Integer>();
		allShipMethod.add(1);
		allShipMethod.add(2);
		allShipMethod.add(3);

		//判斷有沒有共同的ship method
		for (int prodId : prodList) {
			List<ProdShips> shipMethod = prodShipsService.getAllProdShipByProdID(prodId);
			List<Integer> shipNoList = new ArrayList<Integer>();
			for (ProdShips prodShips : shipMethod) {
				shipNoList.add(prodShips.getShip_no());
			}

			if (!shipNoList.contains(1) && allShipMethod.contains(1)) 
				allShipMethod.remove(new Integer(1));
			
			if (!shipNoList.contains(2) && allShipMethod.contains(2)) 
				allShipMethod.remove(new Integer(2));
			
			if (!shipNoList.contains(3) && allShipMethod.contains(3)) 
				allShipMethod.remove(new Integer(3));

		}

		allShipMethod.add(4); //加入都共同有的method		
		
		
		//確認完成後導到訂單填寫頁
		req.setAttribute("buyList", resultList);
		req.setAttribute("totalList", totalList);
		req.setAttribute("shipMethodList", allShipMethod);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/Shop/buy2_confirm.jsp");
		dispatcher.forward(req, res);
//		res.setContentType("text/html");
//		res.getWriter().write(resultList.toString());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
