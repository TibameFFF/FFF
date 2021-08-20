package com.shop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.lookup.ImplicitNullAnnotationVerifier;
import org.json.JSONArray;
import org.json.JSONObject;

import com.shop.daoImpl.ProdDAOImpl;
import com.shop.daoImpl.ProdPicsDAOImpl;
import com.shop.daoImpl.ProdSpecDAOImpl;
import com.shop.model.FavProd;
import com.shop.model.Prod;
import com.shop.model.ProdPics;
import com.shop.model.ProdSpec;
import com.shop.model.ProdStarSaleView;
import com.shop.service.FavProdService;
import com.shop.service.ProdPicsService;
import com.shop.service.ProdService;
import com.shop.service.ProdSpecService;
import com.shop.util.ProdSpecToShow;
import com.shop.util.ProdStarSaleViewDAOImpl;
import com.shop.util.ProdToShow;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/ProdToIndex")
public class ProdToIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<Prod> prodList;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String type = req.getParameter("type"); // ���o�Ѽ�

		// ���������ӫ~
		ProdDAOImpl prodDAO = new ProdDAOImpl();
		prodList = prodDAO.getAll();

		if ("recommandation".equals(type)) {

			// ���o�H��12�Ӱӫ~
			Set<Integer> randSet = new HashSet<Integer>();
			while (randSet.size() < 12) {
				int randNo = (int) (Math.random() * prodList.size());
				randSet.add(randNo);
			}

			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i : randSet) {
				ProdToShow prod = new ProdToShow();
				int prodID = prodList.get(i).getProd_id();
				prod.setProd_id(prodID);

				// ���o�ӫ~�W��
				prod.setProd_name(prodList.get(i).getProd_name());

				// ���o�ӫ~����
				ProdSpecDAOImpl spec = new ProdSpecDAOImpl();
				List<ProdSpec> specList = spec.findByProdID(prodID);
				prod.setPrice(specList.get(0).getProd_price());

				// ���o�ӫ~�Ϥ�
				ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
				List<ProdPics> picList = pic.findByProdID(prodID);
				prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
				if (picList.size() > 1)
					prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

				sendList.add(prod);
			}

			// ��List�ରJSON�榡
			String json = new JSONArray(sendList).toString();

			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write(json);
			return;
		}

		// ���o�ӫ~
		if ("prod".equals(type)) {
			int start = Integer.parseInt(req.getParameter("start"));
			int end = Integer.parseInt(req.getParameter("end"));

			// �S��Ʀ^��
			if (start > prodList.size()) {
				res.setContentType("text/html;charset=UTF-8");
				res.addHeader("Access-Control-Allow-Origin", "*");
				res.getWriter().write("{  \"result\": \"no result\"}");
				return;
			}

			// �n�D���פj��֦�����
			if (end > prodList.size()) {
				end = prodList.size();
			}

			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i = start; i < end; i++) {
				ProdToShow prod = new ProdToShow();
				int prodID = prodList.get(i).getProd_id();
				prod.setProd_id(prodID);

				// ���o�ӫ~�W��
				prod.setProd_name(prodList.get(i).getProd_name());

				// ���o�ӫ~����
				ProdSpecDAOImpl spec = new ProdSpecDAOImpl();
				List<ProdSpec> specList = spec.findByProdID(prodID);
				prod.setPrice(specList.get(0).getProd_price());

				// ���o�ӫ~�Ϥ�
				ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
				List<ProdPics> picList = pic.findByProdID(prodID);
				prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
				if (picList.size() > 1)
					prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

				// ���o�ӫ~�P�ƩM�P��q
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

			// ��List�ରJSON�榡
			String json = new JSONArray(sendList).toString();

			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write(json);
			return;
		}

		// ���o�ӫ~
		if ("favProd".equals(type)) {
			int userID = Integer.parseInt(req.getParameter("userid"));
			
			//���o�|�������ðӫ~���
			FavProdService fps = new FavProdService();
			List<FavProd> favList = fps.getFavProdByUserId(userID);
			
			// �S��Ʀ^��
			if (favList.size() == 0) {
				res.setContentType("text/html;charset=UTF-8");
				res.addHeader("Access-Control-Allow-Origin", "*");
				res.getWriter().write("{  \"result\": \"no result\"}");
				return;
			}

			//��ӫ~���
			List<Prod> favProdList = new ArrayList<Prod>();
			ProdService ps = new ProdService();
			for(FavProd favProd : favList) {
				favProdList.add(ps.getOneById(favProd.getProd_id()));
			}

			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i = 0; i < favProdList.size(); i++) {
				ProdToShow prod = new ProdToShow();
				int prodID = favProdList.get(i).getProd_id();
				prod.setProd_id(prodID);

				// ���o�ӫ~�W��
				prod.setProd_name(favProdList.get(i).getProd_name());

				// ���o�ӫ~����
				ProdSpecDAOImpl spec = new ProdSpecDAOImpl();
				List<ProdSpec> specList = spec.findByProdID(prodID);
				prod.setPrice(specList.get(0).getProd_price());

				// ���o�ӫ~�Ϥ�
				ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
				List<ProdPics> picList = pic.findByProdID(prodID);
				prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
				if (picList.size() > 1)
					prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

				// ���o�ӫ~�P�ƩM�P��q
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

			// ��List�ରJSON�榡
			String json = new JSONArray(sendList).toString();

			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write(json);
			return;
		}
		
		
		// ���o�ӫ~�ԲӸ�T
		if ("get_spec".equals(type)) {
			
			int prodId= Integer.parseInt(req.getParameter("prod_id"));
			ProdSpecToShow prodSpecToShow = new ProdSpecToShow();
			
			ProdService ps = new ProdService();
			String prodName = ps.getOneById(prodId).getProd_name();
			
			ProdSpecService pss = new ProdSpecService();
			List<ProdSpec> specList = pss.getAllProdSpecByProdID(prodId);
			
			ArrayList<String> specNameList = new ArrayList<String>();
			ArrayList<Integer> specPriceList = new ArrayList<Integer>();
			ArrayList<Integer> specIdList = new ArrayList<Integer>();
			for(ProdSpec prodSpec: specList) {
				specNameList.add(prodSpec.getSpec_name());
				specPriceList.add(prodSpec.getProd_price());
				specIdList.add(prodSpec.getProd_spec_id());
			}
			
			
			ArrayList<Integer> prodPicList = new ArrayList<Integer>();
			ProdPicsService pps = new ProdPicsService();
			List<ProdPics> prodPics = pps.getAllProdPicByProdID(prodId);
			for(ProdPics prodpic: prodPics) {
				prodPicList.add(prodpic.getProd_pic_id());
			}
			
			
			prodSpecToShow.setProdName(prodName);
			prodSpecToShow.setSpecList(specNameList);
			prodSpecToShow.setSpecPriceList(specPriceList);
			prodSpecToShow.setProdPicList(prodPicList);
			prodSpecToShow.setSpecIdList(specIdList);
			
			
			String jsonStr = new JSONObject(prodSpecToShow).toString();
			
			// �ǰe
			res.setContentType("text/html;charset=UTF-8");
			res.addHeader("Access-Control-Allow-Origin", "*");
			res.getWriter().write(jsonStr);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
