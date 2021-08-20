package com.shop.service;

import java.util.List;

import com.shop.dao.ProdShipsDAO;
import com.shop.daoImpl.ProdShipsDAOImpl;
import com.shop.model.ProdShips;

public class ProdShipsService {
	private ProdShipsDAO dao;
	
	public ProdShipsService() {
		dao = new ProdShipsDAOImpl();
	}
	
	public ProdShips addProdShip(int prod_id, int ship_no) {
		ProdShips prodship = new ProdShips();
		prodship.setProd_id(prod_id);
		prodship.setShip_no(ship_no);
		
		dao.add(prodship);
		
		return prodship;
	};
	public ProdShips updateProdShip(int prod_id, int ship_no) {
		ProdShips prodship = new ProdShips();
		prodship.setProd_id(prod_id);
		prodship.setShip_no(ship_no);
		
		dao.update(prodship);
		
		return prodship;
	};
	
	public void deleteProdShip(int id) {
		dao.delete(id);
	};
	
	public List<ProdShips> getAllProdShipByProdID(int id){
		return dao.findByProdID(id);
	};
	
	public List<ProdShips> getAllProdShipByShipNo(int no){
		return dao.findByShipNo(no);
	};
}
