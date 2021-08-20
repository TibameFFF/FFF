package com.shop.dao;

import java.util.List;

import com.shop.model.ProdSpec;

public interface ProdSpecDAO {

	void add(ProdSpec prodSpec);
	void update(ProdSpec prodSpec);
	void delete(int id);
	ProdSpec findByPK(int id);
	List<ProdSpec> findByProdID(int id);
}
