package com.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.info.model.InfoVO;
import com.shop.model.Prod;
import com.shop.model.ProdSpec;
import com.shop.model.ShopCart;
import com.shop.service.ProdPicsService;
import com.shop.service.ProdService;
import com.shop.service.ProdSpecService;
import com.shop.util.ProdToShow;

import redis.clients.jedis.Jedis;

@WebServlet("/HeaderShowCartServlet")
public class HeaderShowCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		if(member != null) {
			
		
		
		String idGetFromSession = Integer.toString(member.getUser_id());
		
		Jedis jedis = new Jedis("localhost", 6379);
		String userID = "cart:id:"+idGetFromSession;
		
		List<ProdToShow> sendList = new ArrayList<ProdToShow>();
		
		HashMap<String, String> storage = (HashMap<String, String>)jedis.hgetAll(userID);
		jedis.close();
		if(storage.size() != 0) {
			ProdService prodService = new ProdService();
			ProdSpecService prodSpecService = new ProdSpecService();
			ProdPicsService prodPicsService = new ProdPicsService();
			
			for(String specID: storage.keySet()) {
				
				ProdToShow prodToShow = new ProdToShow();
				int spec = Integer.parseInt(specID);
				
				ProdSpec prodSpec = prodSpecService.getOneProdSpecByPK(spec);
				prodToShow.setPrice(prodSpec.getProd_price());
				
				Prod prod = prodService.getOneById(prodSpec.getProd_id());
				prodToShow.setProd_name(prod.getProd_name());
				
				prodToShow.setImg1("/FFF/ProdImage?id="+prodPicsService.getAllProdPicByProdID(prod.getProd_id()).get(0).getProd_pic_id());
	
				sendList.add(prodToShow);
		} }
		
		String jsonStr = new JSONArray(sendList).toString();
		
		res.setContentType("text/html");
		res.setCharacterEncoding("UTF-8");
		res.getWriter().write(jsonStr);
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
