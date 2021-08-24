package com.shop.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.FavProd;
import com.shop.model.ShopCart;
import com.shop.service.FavProdService;
import com.shop.service.ProdSpecService;
import com.shop.service.ShopCartService;

import redis.clients.jedis.Jedis;

@WebServlet("/ProdToCartServlet")
public class ProdToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/ProdToCartServlet?type=add&specid=2&num=3
//		ShopCartService scs = new ShopCartService();
		int idGetFromSession = 1;
		
		//加入購物車
		String type = req.getParameter("type");
		if ("add".equals(type)) {
			//sql做法
//			int userID = Integer.parseInt(req.getParameter("userid"));
//			int specID = Integer.parseInt(req.getParameter("specid"));
//			int prodnum = Integer.parseInt(req.getParameter("num"));
//			scs.addShopCart(prodnum, specID, userID);
//			判斷有沒有登入
			if (idGetFromSession == 0) {
				// 傳送
				res.setContentType("text/html;charset=UTF-8");
				res.addHeader("Access-Control-Allow-Origin", "*");
				res.getWriter().write("未登入");
				return;
			}
			
			
			
			String userID = "cart:id:"+idGetFromSession;
			String specID = req.getParameter("specid");
			String prodnum = req.getParameter("num");
			
			Jedis jedis = new Jedis("localhost", 6379);
			
			HashMap<String, String> storage = (HashMap<String, String>)jedis.hgetAll(userID);
			
			if(storage.get(specID) != null) {
				int num = Integer.parseInt(storage.get(specID));
				num += Integer.parseInt(prodnum);
				prodnum = Integer.toString(num);
			} 
			storage.put(specID, prodnum);
			
			jedis.hmset(userID, storage);
			
			jedis.close();
			// 傳送
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write("成功加入!");
			
			return;
		}

		//移除購物車
		// http://localhost:8081/FFF/ProdToCartServlet?type=remove&userid=1&specid=2
		if ("remove".equals(type)) {
//			int userID = Integer.parseInt(req.getParameter("userid"));
//			int specID = Integer.parseInt(req.getParameter("specid"));
//
//			ShopCart shopCart = new ShopCart();
//			shopCart.setProd_spec_id(specID);
//			shopCart.setUser_id(userID);
//			scs.delete(shopCart);
			String userID = "cart:id:"+idGetFromSession;
			String specID = req.getParameter("specid");
			
			Jedis jedis = new Jedis("localhost", 6379);
			
			jedis.hdel(userID, specID);
			
			jedis.close();

			// 傳送
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write("成功刪除!");
			
			
		
			return;
		}
		
		//更新購物車數量
		// http://localhost:8081/FFF/ProdToCartServlet?type=update&userid=1&specid=2&num=3
				if ("update".equals(type)) {
//					int userID = Integer.parseInt(req.getParameter("userid"));
//					int specID = Integer.parseInt(req.getParameter("specid"));
//					int num =  Integer.parseInt(req.getParameter("num"));
//
//					scs.updateShopCart(num, specID, userID);
					
					String userID = "cart:id:"+idGetFromSession;
					String specID = req.getParameter("specid");
					String prodnum = req.getParameter("num");
					
					//檢查有沒有超出庫存
					ProdSpecService prodSpecService = new ProdSpecService();
					int stock = prodSpecService.getOneProdSpecByPK(Integer.parseInt(specID)).getStock();
					String result = prodnum;
					
					Jedis jedis = new Jedis("localhost", 6379);
					if(stock >= Integer.parseInt(prodnum)) {
						jedis.hset(userID, specID, prodnum);
					} else {
						jedis.hset(userID, specID , Integer.toString(stock));
						result = Integer.toString(stock);
					}
					
					jedis.close();
					
					
					// 傳送
					res.setContentType("text/html;charset=UTF-8");
					res.addHeader("Access-Control-Allow-Origin", "*");
					res.getWriter().write(result);
					return;
				}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
