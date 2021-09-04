package com.shop.service;

import java.util.List;

import com.shop.dao.FavProdDAO;
import com.shop.daoImpl.FavProdDAOImpl;
import com.shop.model.EvalPic;
import com.shop.model.FavProd;

public class FavProdService {
	private FavProdDAO dao;
	
	public FavProdService() {
		dao = new FavProdDAOImpl();
	}
	
	public FavProd addFavProd(int user_id, int prod_id) {
		FavProd favProd = new FavProd();
		favProd.setProd_id(prod_id);
		favProd.setUser_id(user_id);
		dao.add(favProd);
		
		return favProd;
		
	}
	
	public void deleteFavProd(FavProd favProd) {
		dao.delete(favProd);
	}
	
	public List<FavProd> getFavProdByUserId(int id){
		return dao.findByUserID(id);
	}
}
