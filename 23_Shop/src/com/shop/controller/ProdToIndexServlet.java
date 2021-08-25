package com.shop.controller;

import java.io.IOException;

import javax.jws.soap.SOAPBinding.Use;
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
import com.shop.service.FavProdService;
import com.shop.service.ProdPicsService;
import com.shop.service.ProdService;
import com.shop.service.ProdSpecService;
import com.shop.util.ProdSpecToShow;
import com.shop.util.ProdStarSaleView;
import com.shop.util.ProdStarSaleViewDAOImpl;
import com.shop.util.ProdToShow;
import com.shop.util.ProdToShowDAOImpl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/ProdToIndex")
public class ProdToIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<ProdToShow> prodList;
	
	public void init() {
		
		// ���������ӫ~
		ProdToShowDAOImpl dao = new ProdToShowDAOImpl();
		prodList = dao.getAll();
		Collections.shuffle(prodList);
		
		
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		//�p�G�ӫ~�ƶq�����P���ܴN��List��s
		ProdService prodService = new ProdService();
		if(prodService.findProdTotalNum() != prodList.size()) {
			init();
		}
		
		
		String type = req.getParameter("type"); // ���o�Ѽ�
		int idGetFromSession = 1;
		

		// ���o�H��12�ӱ��˰ӫ~
		if ("recommandation".equals(type)) {

			Set<Integer> randSet = new HashSet<Integer>();
			while (randSet.size() < 12) {
				int randNo = (int) (Math.random() * prodList.size());
				randSet.add(randNo);
			}

			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i : randSet) {
				ProdToShow prod = prodList.get(i);
				int prodID = prodList.get(i).getProd_id();

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

		// ���o�������o�T�w�ƶq�ӫ~
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

			
			//���o�|�����ðӫ~
			FavProdService favProdService = new FavProdService();
			List<FavProd> favProdList = favProdService.getFavProdByUserId(idGetFromSession);
			List<Integer> favProdIdList = new ArrayList<Integer>();

			for(FavProd favProd: favProdList) {
				favProdIdList.add(favProd.getProd_id());
			}
			
			
			
			
			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			for (int i = start; i < end; i++) {
				ProdToShow prod = prodList.get(i);
				prod.setFavProd(false);
				int prodID = prodList.get(i).getProd_id();

				// ���o�ӫ~�Ϥ�
				ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
				List<ProdPics> picList = pic.findByProdID(prodID);
				prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
				if (picList.size() > 1)
					prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

				// ���o�ӫ~�P�ƩM�P��q
				ProdStarSaleViewDAOImpl view = new ProdStarSaleViewDAOImpl();
				prod.setStar(view.getStarRate(prodID));
				prod.setSale(view.getNumSale(prodID));

				
				//�]�w�O�_����
				if(favProdIdList.contains(prodID))
					prod.setFavProd(true);
				
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

		// ���o���ðӫ~
		if ("favProd".equals(type)) {
			int userID = idGetFromSession;

			// ���o�|�������ðӫ~���
			FavProdService fps = new FavProdService();
			List<FavProd> favList = fps.getFavProdByUserId(userID);
			
			// �S��Ʀ^��
			if (favList.size() == 0) {
				res.setContentType("text/html;charset=UTF-8");
				res.addHeader("Access-Control-Allow-Origin", "*");
				res.getWriter().write("{  \"result\": \"no result\"}");
				return;
			}

			// ��ӫ~���
			FavProdService ps = new FavProdService();
			List<FavProd> favProdList = ps.getFavProdByUserId(idGetFromSession);
			
			// �]�w�n�ǰe�����
			List<ProdToShow> sendList = new ArrayList<ProdToShow>();
			ProdToShowDAOImpl prodToShowDAOImpl = new ProdToShowDAOImpl();
			for (int i = 0; i < favProdList.size(); i++) {
				int prodID = favProdList.get(i).getProd_id();
				ProdToShow prod = prodToShowDAOImpl.getByPk(prodID);
				
				//�ˬd�O�_���W�[
				if(prod.getStatus() == 1) {
					// ���o�ӫ~�Ϥ�
					ProdPicsDAOImpl pic = new ProdPicsDAOImpl();
					List<ProdPics> picList = pic.findByProdID(prodID);
					prod.setImg1("FFF/ProdImage?id=" + picList.get(0).getProd_pic_id());
					if (picList.size() > 1)
						prod.setImg2("FFF/ProdImage?id=" + picList.get(1).getProd_pic_id());

					// ���o�ӫ~�P�ƩM�P��q
					ProdStarSaleViewDAOImpl view = new ProdStarSaleViewDAOImpl();
					prod.setStar(view.getStarRate(prodID));
					prod.setSale(view.getNumSale(prodID));

					sendList.add(prod);
				}
				
				
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

			int prodId = Integer.parseInt(req.getParameter("prod_id"));
			ProdSpecToShow prodSpecToShow = new ProdSpecToShow();

			ProdService ps = new ProdService();
			String prodName = ps.getOneById(prodId).getProd_name();

			ProdSpecService pss = new ProdSpecService();
			List<ProdSpec> specList = pss.getAllProdSpecByProdID(prodId);

			ArrayList<String> specNameList = new ArrayList<String>();
			ArrayList<Integer> specPriceList = new ArrayList<Integer>();
			ArrayList<Integer> specIdList = new ArrayList<Integer>();
			ArrayList<Integer> specStockList = new ArrayList<Integer>();
			for (ProdSpec prodSpec : specList) {
				specNameList.add(prodSpec.getSpec_name());
				specPriceList.add(prodSpec.getProd_price());
				specIdList.add(prodSpec.getProd_spec_id());
				specStockList.add(prodSpec.getStock());
			}

			ArrayList<Integer> prodPicList = new ArrayList<Integer>();
			ProdPicsService pps = new ProdPicsService();
			List<ProdPics> prodPics = pps.getAllProdPicByProdID(prodId);
			for (ProdPics prodpic : prodPics) {
				prodPicList.add(prodpic.getProd_pic_id());
			}

			prodSpecToShow.setProdName(prodName);
			prodSpecToShow.setSpecList(specNameList);
			prodSpecToShow.setSpecPriceList(specPriceList);
			prodSpecToShow.setProdPicList(prodPicList);
			prodSpecToShow.setSpecIdList(specIdList);
			prodSpecToShow.setSpecStockList(specStockList);

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
