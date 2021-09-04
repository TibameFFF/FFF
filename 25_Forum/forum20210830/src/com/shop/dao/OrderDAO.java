package com.shop.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.shop.model.Order;

public interface OrderDAO {

	int add(Connection connection, Order order) throws SQLException;
	void update(Order order);
	void delete(int pk);
	Order findByPK(int pk);
	List<Order> findByUser(int id);
	List<Order> getAll();
}
