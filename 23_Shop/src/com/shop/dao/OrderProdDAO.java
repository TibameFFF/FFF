package com.shop.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.shop.model.OrderProd;

public interface OrderProdDAO {
	void add(Connection connection, OrderProd orderProd) throws SQLException;
	void updateComment(OrderProd orderProd);
	List<OrderProd> findByOrdNo(int ordNo);
	List<OrderProd> findByProdSpec(int specID);
	
}
