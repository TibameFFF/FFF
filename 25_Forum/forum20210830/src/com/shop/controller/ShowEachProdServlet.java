package com.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.InfoVO;
import com.shop.model.EvalPic;
import com.shop.model.FavProd;
import com.shop.model.OrderProd;
import com.shop.model.ProdSpec;
import com.shop.service.EvalPicService;
import com.shop.service.FavProdService;
import com.shop.service.OrderProdService;
import com.shop.service.OrderService;
import com.shop.service.ProdSpecService;
import com.shop.util.Comment;

@WebServlet("/ShowEachProd")
public class ShowEachProdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		int prodID = Integer.parseInt(req.getParameter("prodID"));
		
		
		HttpSession session = req.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		
		int idGetFromSession = 0;
		
		if(member != null) {
			idGetFromSession= member.getUser_id();
		}
		Boolean favProd = false;

		// 檢查是否有收藏
		FavProdService favProdService = new FavProdService();
		List<FavProd> favProdList = favProdService.getFavProdByUserId(idGetFromSession);

		for (FavProd favProd2 : favProdList) {
			if (favProd2.getProd_id() == prodID) {
				favProd = true;
				break;
			}
		}

		//設定評論
		List<Comment> commentList = new ArrayList<Comment>();

		ProdSpecService prodSpecService = new ProdSpecService();
		OrderProdService orderProdService = new OrderProdService();

		List<ProdSpec> prodSpecList = prodSpecService.getAllProdSpecByProdID(prodID);
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
				commentList.add(eachComment);
			}

		}

		req.setAttribute("prodID", prodID);
		req.setAttribute("favProd", favProd);
		req.setAttribute("commentList", commentList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/Shop/shop3_product.jsp");// 成功轉交 update_emp_input.jsp
		dispatcher.forward(req, res);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
