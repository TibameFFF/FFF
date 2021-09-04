package com.shop.dao;
import java.util.List;

import com.shop.model.ShopCart;

public interface ShopCartDAO {

	void add(ShopCart shopCart);
	void delete(ShopCart shopCart);
	void update(ShopCart shopCart);
	List<ShopCart> findByUserID(int id);
}
