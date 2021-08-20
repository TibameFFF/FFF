package com.shop.dao;

import java.util.List;

import com.shop.model.ProdShips;

public interface ProdShipsDAO {
	void add(ProdShips prodShips);
	void update(ProdShips prodShips);
	void delete(int id);
	List<ProdShips> findByProdID(int id);
	List<ProdShips> findByShipNo(int no);
}
