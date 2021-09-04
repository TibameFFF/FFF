package com.shop.dao;

import java.util.List;

import com.shop.model.ProdPics;

public interface ProdPicsDAO {
	void add(ProdPics prodPics);
	void update(ProdPics prodPics);
	void delete(int id);
	List<ProdPics> findByProdID(int id);
	List<ProdPics> findByProdIDForOrder(int id);
}
