package com.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.InfoVO;
import com.shop.model.ShopCart;

import redis.clients.jedis.Jedis;

@WebServlet("/ShowCartServlet")
public class ShowCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		int idGetFromSession = 0;
		
		if(member != null) {
			idGetFromSession = member.getUser_id();
		}
		
		List<ShopCart> shopList = new ArrayList<ShopCart>();
		
		String userID = "cart:id:"+idGetFromSession;
		Jedis jedis = new Jedis("localhost", 6379);
		HashMap<String, String> storage = (HashMap<String, String>)jedis.hgetAll(userID);
		jedis.close();
		
		
		if(storage.size() != 0) {
			for(String specID: storage.keySet()) {
				ShopCart shopCart = new ShopCart();
				int spec = Integer.parseInt(specID);
				shopCart.setProd_num(Integer.parseInt(storage.get(specID)));
				shopCart.setProd_spec_id(spec);
				
				shopList.add(shopCart);
			}
		} 
		;
		req.setAttribute("shopList", shopList);
		RequestDispatcher requestDispatcher = req.getRequestDispatcher("/Shop/buy1_cart.jsp");
		requestDispatcher.forward(req, res);
		
		return;
		
	
	
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
