package com.shop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.model.FavProd;
import com.shop.model.ShopCart;
import com.shop.service.FavProdService;
import com.shop.service.ShopCartService;

@WebServlet("/ProdToCartServlet")
public class ProdToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/ProdToCartServlet?type=add&userid=1&specid=2&num=3
		ShopCartService scs = new ShopCartService();

		String type = req.getParameter("type");
		if ("add".equals(type)) {
			int userID = Integer.parseInt(req.getParameter("userid"));
			int specID = Integer.parseInt(req.getParameter("specid"));
			int prodnum = Integer.parseInt(req.getParameter("num"));

			scs.addShopCart(prodnum, specID, userID);

			// 傳送
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write("成功加入!");
			return;
		}

		// http://localhost:8081/FFF/ProdToCartServlet?type=remove&userid=1&specid=2
		if ("remove".equals(type)) {
			int userID = Integer.parseInt(req.getParameter("userid"));
			int specID = Integer.parseInt(req.getParameter("specid"));

			ShopCart shopCart = new ShopCart();
			shopCart.setProd_spec_id(specID);
			shopCart.setUser_id(userID);
			scs.delete(shopCart);


			// 傳送
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write("成功刪除!");
			return;
		}
		
		// http://localhost:8081/FFF/ProdToCartServlet?type=update&userid=1&specid=2&num=3
				if ("update".equals(type)) {
					int userID = Integer.parseInt(req.getParameter("userid"));
					int specID = Integer.parseInt(req.getParameter("specid"));
					int num =  Integer.parseInt(req.getParameter("num"));

					scs.updateShopCart(num, specID, userID);
					// 傳送
					res.setContentType("text/html;charset=UTF-8");
					res.addHeader("Access-Control-Allow-Origin", "*");
					res.getWriter().write("成功修改!");
					return;
				}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
