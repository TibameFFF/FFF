package com.shop.service;

import java.util.List;

import com.shop.dao.ProdSpecDAO;
import com.shop.daoImpl.ProdSpecDAOImpl;
import com.shop.model.ProdSpec;

public class ProdSpecService {
	private ProdSpecDAO dao;
	
	public ProdSpecService() {
		dao = new ProdSpecDAOImpl();
	}
	
	public ProdSpec addProdSpec(int prod_id, int prod_price, String spec_name, int stock) {
		ProdSpec prodSpec = new ProdSpec();
		prodSpec.setProd_id(prod_id);
		prodSpec.setProd_price(prod_price);
		prodSpec.setSpec_name(spec_name);
		prodSpec.setStock(stock);
		
		dao.add(prodSpec);
		return prodSpec;
	};
	
	public ProdSpec updateProdSpec(int prod_id, int prod_price, String spec_name, int stock) {
		ProdSpec prodSpec = new ProdSpec();
		prodSpec.setProd_id(prod_id);
		prodSpec.setProd_price(prod_price);
		prodSpec.setSpec_name(spec_name);
		prodSpec.setStock(stock);
		
		dao.update(prodSpec);
		return prodSpec;
	};
	
	public void deleteProdSpec(int id) {
		dao.delete(id);
	};
	
	public ProdSpec getOneProdSpecByPK(int id) {
		return dao.findByPK(id);
	};
	
	public List<ProdSpec> getAllProdSpecByProdID(int id){
		return dao.findByProdID(id);
	};
}
