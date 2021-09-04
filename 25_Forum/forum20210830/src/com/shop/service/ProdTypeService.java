package com.shop.service;

import java.util.List;

import com.shop.dao.ProdTypeDAO;
import com.shop.daoImpl.ProdTypeDAOImpl;
import com.shop.model.ProdType;

public class ProdTypeService {
	
	private ProdTypeDAO dao;
	
	public ProdTypeService() {
		dao = new ProdTypeDAOImpl();
	}
	
	public List<ProdType> getAllProdType(){
		return dao.getAll();
	};
}
