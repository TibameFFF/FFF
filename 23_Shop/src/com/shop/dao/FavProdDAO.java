package com.shop.dao;

import java.util.List;

import com.shop.model.FavProd;

public interface FavProdDAO {
	void add(FavProd favProd);
	void delete(FavProd favProd);
	List<FavProd> findByUserID(int id);
}
