package com.shop.dao;

import java.util.List;

import com.shop.model.Order;

public interface OrderDAO {

	int add(Order order);
	void update(Order order);
	void delete(int pk);
	Order findByPK(int pk);
	List<Order> findByUser(int id);
	List<Order> getAll();
}
