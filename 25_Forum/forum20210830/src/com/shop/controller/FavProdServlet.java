package com.shop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.InfoVO;
import com.shop.model.FavProd;
import com.shop.service.FavProdService;

@WebServlet("/FavProdServlet")
public class FavProdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/FavProdServlet?type=add&userid=1&prodid=2
		// �s�W����
		FavProdService fps = new FavProdService();

		HttpSession session = req.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		
		int idGetFromSession = 0;

		
//		�P�_���S���n�J
		if (member == null) {
			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write("���n�J");
			return;
		} else {
			idGetFromSession = member.getUser_id();
		}

		String type = req.getParameter("type");
		if ("add".equals(type)) {
			int userID = idGetFromSession;
			int prodID = Integer.parseInt(req.getParameter("prodid"));

			fps.addFavProd(userID, prodID);

			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
//			res.getWriter().write("���\�[�J!");
			return;
		}

		// http://localhost:8081/FFF/FavProdServlet?type=remove&userid=1&prodid=2
		// ��������
		if ("remove".equals(type)) {
			int userID = idGetFromSession;
			int prodID = Integer.parseInt(req.getParameter("prodid"));
			FavProd favProd = new FavProd();
			favProd.setProd_id(prodID);
			favProd.setUser_id(userID);

			fps.deleteFavProd(favProd);

			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
//			res.getWriter().write("���\�R��!");
			return;
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
