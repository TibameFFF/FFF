package com.shop.dao;

import java.util.List;

import com.shop.model.OrderProd;

public interface OrderProdDAO {
	void add(OrderProd orderProd);
	void updateComment(OrderProd orderProd);
	List<OrderProd> findByOrdNo(int ordNo);
	List<OrderProd> findByProdSpec(int specID);
	
}
