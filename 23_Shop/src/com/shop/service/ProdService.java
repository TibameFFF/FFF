package com.shop.service;

import java.util.List;

import com.shop.dao.ProdDAO;
import com.shop.daoImpl.ProdDAOImpl;
import com.shop.model.Prod;

public class ProdService {
	private ProdDAO dao;
	
	public ProdService() {
		dao = new ProdDAOImpl();
	}
	
	public Prod addProd(String prod_name, Byte prod_status, String prod_text, int prod_type_no ) {
		Prod prod = new Prod();
		prod.setProd_name(prod_name);
		prod.setProd_status(prod_status);
		prod.setProd_text(prod_text);
		prod.setProd_type_no(prod_type_no);
		
		dao.add(prod);
		return prod;
	};
	public Prod updateProd(String prod_name, Byte prod_status, String prod_text, int prod_type_no ) {
		Prod prod = new Prod();
		prod.setProd_name(prod_name);
		prod.setProd_status(prod_status);
		prod.setProd_text(prod_text);
		prod.setProd_type_no(prod_type_no);
		
		dao.update(prod);
		return prod;
		
	};
	
	public void deleteProd(int id) {
		dao.delete(id);
	};
	
	public Prod getOneById(int id) {
		return dao.findByPK(id);
	};
	
	public List<Prod> getAllProds(){
		return dao.getAll();
	};
	
	
	public List<Prod> getAllBySearch(String str){
		return dao.getBySearch(str);
	}
	
	public List<Prod> getAllbyFilter(List<Integer> price, List<Integer> typeList, List<Integer> ship, String search){
		return dao.filterByPriceTypeShip(price, typeList, ship, search);
	}
}
