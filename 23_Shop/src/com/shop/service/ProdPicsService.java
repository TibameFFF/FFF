package com.shop.service;

import java.util.List;

import com.shop.dao.ProdPicsDAO;
import com.shop.daoImpl.ProdPicsDAOImpl;
import com.shop.model.ProdPics;

public class ProdPicsService {
	private ProdPicsDAO dao;
	
	public ProdPicsService() {
		dao = new ProdPicsDAOImpl();
	}
	
	public ProdPics addProdPic(int prod_id, byte[] prod_pic) {
		ProdPics prodPics = new ProdPics();
		
		prodPics.setProd_id(prod_id);
		prodPics.setProd_pic(prod_pic);
		
		dao.add(prodPics);
		return prodPics;
	};
	
	public ProdPics updateProdPic(int prod_id, byte[] prod_pic) {
		ProdPics prodPics = new ProdPics();
		
		prodPics.setProd_id(prod_id);
		prodPics.setProd_pic(prod_pic);
		
		dao.update(prodPics);
		return prodPics;
	};
	
	public void deleteProdPic(int id) {
		dao.delete(id);
	};
	
	public List<ProdPics> getAllProdPicByProdID(int id){
		return dao.findByProdID(id);
	};
	
	public List<ProdPics> getAllProdPicByProdIDForOrder(int id){
		return dao.findByProdIDForOrder(id);
	};
}
