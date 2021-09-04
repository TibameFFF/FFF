package com.shop.dao;

import java.util.List;

import com.shop.model.ShipMethod;

public interface ShipMethodDAO {

	void add(ShipMethod shipMethod);
	void update(ShipMethod shipMethod);
	void delete(int id);
	ShipMethod findByPK(int id);
	List<ShipMethod> getAll();
}
