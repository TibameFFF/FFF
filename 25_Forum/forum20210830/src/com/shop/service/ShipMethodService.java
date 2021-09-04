package com.shop.service;

import java.util.List;

import com.shop.dao.ShipMethodDAO;
import com.shop.daoImpl.ShipMethodDAOImpl;
import com.shop.model.ShipMethod;

public class ShipMethodService {
	private ShipMethodDAO dao;
	
	public ShipMethodService() {
		dao = new ShipMethodDAOImpl();
	}
	
	public ShipMethod addShipMethod(int ship_fee, String ship_name, int ship_no) {
		ShipMethod shipMethod = new ShipMethod();
		shipMethod.setShip_fee(ship_fee);
		shipMethod.setShip_name(ship_name);
		shipMethod.setShip_no(ship_no);
		dao.add(shipMethod);
		
		return shipMethod;
	};
	
	public ShipMethod updateShipMethod(int ship_fee, String ship_name, int ship_no) {
		ShipMethod shipMethod = new ShipMethod();
		shipMethod.setShip_fee(ship_fee);
		shipMethod.setShip_name(ship_name);
		shipMethod.setShip_no(ship_no);
		dao.update(shipMethod);
		
		return shipMethod;
	};
	
	public void deleteShipMethod(int id) {
		dao.delete(id);
	};
	
	public ShipMethod getOneShipMethodByPK(int id) {
		return dao.findByPK(id);
	};
	
	public List<ShipMethod> getAllShipMethod(){
		return dao.getAll();
	};
}
