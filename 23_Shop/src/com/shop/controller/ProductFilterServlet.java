package com.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.daoImpl.ProdPicsDAOImpl;
import com.shop.daoImpl.ProdSpecDAOImpl;
import com.shop.model.Prod;
import com.shop.model.ProdPics;
import com.shop.model.ProdSpec;
import com.shop.model.ProdStarSaleView;
import com.shop.service.ProdService;
import com.shop.util.ProdStarSaleViewDAO;
import com.shop.util.ProdStarSaleViewDAOImpl;
import com.shop.util.ProdToShow;

@WebServlet("/ProductFilterServlet")
public class ProductFilterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// http://localhost:8081/FFF/ProductFilterServlet?type=type&num=1
		req.setCharacterEncoding("UTF-8");

		String search = req.getParameter("search");
		if (search != null) {
			List<Prod> prodList;
			ProdService prodService = new ProdService();
			List<Integer> price = new ArrayList<Integer>();
			List<Integer> typeList = new ArrayList<Integer>();
			List<Integer> ship = new ArrayList<Integer>();

			String filter = req.getParameter("filter");
			if (filter != null) {

				String minPrice = req.getParameter("min");
				String maxPrice = req.getParameter("max");

				// 設定最小價格
				if (minPrice != "")
					price.add(Integer.parseInt(minPrice));
				else
					price.add(0);
				// 設定最大價格
				if (maxPrice != "")
					price.add(Integer.parseInt(maxPrice));
				else
					price.add(99999);

				// 設定分類條件
				String[] prodType = req.getParameterValues("prod_type");
				if (prodType != null) {
					for (String str : prodType) {
						typeList.add(Integer.parseInt(str));
					}
				} else {
					for (int i = 1; i <= 4; i++) {
						typeList.add(i);
					}
				}

				// 設定運送方式
				String[] shipType = req.getParameterValues("prod_ship");
				if (shipType != null) {
					for (String str : shipType) {
						ship.add(Integer.parseInt(str));
					}
				} else {
					for (int i = 1; i <= 4; i++) {
						ship.add(i);
					}
				}

				prodList = prodService.getAllbyFilter(price, typeList, ship, search);

			} else {

				prodList = prodService.getAllBySearch(search);
			}

			// 星數篩選
			String starSearch = req.getParameter("star");
			if (starSearch != null) {
				System.out.println("list size:" + prodList.size());
				int searchStar = Integer.parseInt(starSearch);
				ProdStarSaleViewDAO prodStarSaleView = new ProdStarSaleViewDAOImpl();

				int origSize = prodList.size();

				for (int i = 0; i < origSize; i++) {
					int prodID = prodList.get(i).getProd_id();
					double star = prodStarSaleView.getStarRate(prodID);

					if (searchStar <= star) {
						prodList.add(prodList.get(i));
					}
				}

				for (int i = 0; i < origSize; i++) {
					prodList.remove(0);
				}

			}

			// 設定要傳送的資料
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i = 0; i < prodList.size(); i++) {
				ProdToShow prod = new ProdToShow();
				int prodID = prodList.get(i).getProd_id();
				prod.setProd_id(prodID);

				// 取得商品名稱
				prod.setProd_name(prodList.get(i).getProd_name());

				// 取得商品價格
				ProdSpecDAOImpl spec = new ProdSpecDAOImpl();
				List<ProdSpec> specList = spec.findByProdID(prodID);
				prod.setPrice(specList.get(0).getProd_price());

				// 取得商品圖片
				ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
				List<ProdPics> picList = pic.findByProdID(prodID);
				prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
				if (picList.size() > 1)
					prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

				// 取得商品星數和銷售量
				ProdStarSaleViewDAOImpl view = new ProdStarSaleViewDAOImpl();
				List<ProdStarSaleView> viewList = view.findByProdID(prodID);

				if (viewList.size() != 0) {
					int sale_num = 0;
					int star_count = 0;
					int star_total = 0;
					for (ProdStarSaleView ob : viewList) {
						sale_num += ob.getProd_num();

						if (ob.getEval_star() != 0) {
							star_count++;
							star_total += ob.getEval_star();
						}
					}

					if (star_count != 0) {
						double starAverage = star_total / star_count;
						prod.setStar(starAverage);

					}
					prod.setSale(sale_num);
				}

				sendList.add(prod);
			}


			String sortType = req.getParameter("sort");
			if (sortType != null) {
				int sortNum = Integer.parseInt(sortType);

				switch (sortNum) {
				case 1://銷售排行 
					Collections.sort(sendList, new SaleDesc());
					break;
				case 2://評價 
					Collections.sort(sendList, new CommentDesc());
					break;
				case 3://價格:高到低
					Collections.sort(sendList, new SortPriceDesc());
					break;
				case 4://價格:低到高
					Collections.sort(sendList, new SortPriceAsc());
					break;
				}

			}

			req.setAttribute("price", price);
			req.setAttribute("typeList", typeList);
			req.setAttribute("ship", ship);
			req.setAttribute("starSearch", starSearch);
			req.setAttribute("searchWord", search);
			req.setAttribute("sendList", sendList);
			req.setAttribute("sortType", sortType);
			RequestDispatcher requestDispatcher = req.getRequestDispatcher("/Shop/shop4_search.jsp");
			requestDispatcher.forward(req, res);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

class SortPriceAsc implements Comparator<ProdToShow> {

	@Override
	public int compare(ProdToShow o1, ProdToShow o2) {
		if (o1.getPrice() == null) {
			return (o2.getPrice() == null) ? 0 : -1;
		}
		if (o2.getPrice() == null) {
			return -1;
		}

		return o1.getPrice() - o2.getPrice();
	}

}

class SortPriceDesc implements Comparator<ProdToShow> {

	@Override
	public int compare(ProdToShow o1, ProdToShow o2) {
		if (o1.getPrice() == null) {
			return (o2.getPrice() == null) ? 0 : 1;
		}
		if (o2.getPrice() == null) {
			return -1;
		}

		return o2.getPrice() - o1.getPrice();
	}

}

class SaleDesc implements Comparator<ProdToShow> {

	@Override
	public int compare(ProdToShow o1, ProdToShow o2) {
		if (o1.getPrice() == null) {
			return (o2.getPrice() == null) ? 0 : 1;
		}
		if (o2.getPrice() == null) {
			return -1;
		}

		return o2.getPrice() - o1.getPrice();
	}

}

class CommentDesc implements Comparator<ProdToShow> {

	@Override
	public int compare(ProdToShow o1, ProdToShow o2) {
		if (o1.getStar() == null) {
			return (o2.getStar() == null) ? 0 : 1;
		}
		if (o2.getStar() == null) {
			return -1;
		}

		return (int) (o2.getStar() - o1.getStar());
	}

}
