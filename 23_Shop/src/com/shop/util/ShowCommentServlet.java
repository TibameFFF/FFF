package com.shop.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.shop.model.EvalPic;
import com.shop.model.OrderProd;
import com.shop.model.ProdSpec;
import com.shop.service.EvalPicService;
import com.shop.service.OrderProdService;
import com.shop.service.OrderService;
import com.shop.service.ProdSpecService;

@WebServlet("/ShowCommentServlet")
public class ShowCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int ProdId = Integer.parseInt(req.getParameter("prod_id"));
		List<Comment> sendCommentList = new ArrayList<Comment>();
		
		ProdSpecService prodSpecService = new ProdSpecService();
		OrderProdService orderProdService = new OrderProdService();

		List<ProdSpec> prodSpecList = prodSpecService.getAllProdSpecByProdID(ProdId);
		for (ProdSpec prodSpec : prodSpecList) {
			List<OrderProd> orderProdList = orderProdService.getAllByProdSpec(prodSpec.getProd_spec_id());
			OrderService orderService = new OrderService();
			EvalPicService evalPicService = new EvalPicService();
			for (OrderProd orderProd : orderProdList) {
				Comment eachComment = new Comment();
				eachComment.setStar(orderProd.getEval_star());
				eachComment.setText(orderProd.getEval_text());
				eachComment.setUserPic("https://www.jquery-az.com/javascript/demo.php?ex=156.0_1");
				eachComment.setName(Integer.toString(orderService.getOneByOrderId(orderProd.getOrd_no()).getUser_id()));

				List<String> evalPic = new ArrayList<String>();

				List<EvalPic> evalPicList = evalPicService.getEvalPicByProdId(orderProd.getOrd_prod_id());
				for (EvalPic evalPic2 : evalPicList) {
					String url = "/FFF/EvalPicImage?id=" + evalPic2.getEval_pic_id();
					evalPic.add(url);
				}
				eachComment.setPic(evalPic);
				sendCommentList.add(eachComment);
			}
			
		}
		
		String jsonstr =new JSONArray(sendCommentList).toString();
		res.setContentType("text/html");
		res.setCharacterEncoding("UTF-8");
		res.getWriter().write(jsonstr);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
