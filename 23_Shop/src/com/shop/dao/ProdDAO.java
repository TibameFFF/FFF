package com.shop.dao;

import java.util.List;

import com.shop.model.Prod;

public interface ProdDAO {
	void add(Prod prod);
	void update(Prod prod);
	void delete(int id);
	Prod findByPK(int id);
	List<Prod> getAll();
	List<Prod> getBySearch(String str);
	List<Prod> filterByPriceTypeShip(List<Integer> price, List<Integer> typeList, List<Integer> ship , String search );
	
}
