package com.shop.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.shop.dao.OrderDAO;
import com.shop.daoImpl.OrderDAOImpl;
import com.shop.model.Order;

public class OrderService {
	private OrderDAO dao;
	
	public OrderService() {
		dao = new OrderDAOImpl();
	}
	
	public Order add(Connection connection, String ord_status, Timestamp ord_time, int ord_total, int ship_fee,String ship_method, String ship_info, int support_admin_id, int user_id) throws SQLException {
		Order order = new Order();
		order.setOrd_status(ord_status);
		order.setOrd_time(ord_time);
		order.setOrd_total(ord_total);
		order.setShip_fee(ship_fee);
		order.setShip_method(ship_method);
		order.setShip_info(ship_info);
		order.setSupport_admin_id(support_admin_id);
		order.setUser_id(user_id);
		
		int orderID = dao.add(connection, order);
		order.setOrd_no(orderID);
		return order;
	};
	
	public Order updateOrder(String ord_status  , int ord_total, int order_id) {
		Order order = new Order();
		order.setOrd_status(ord_status);
//		order.setOrd_time(ord_time);
		order.setOrd_total(ord_total);
//		order.setShip_fee(ship_fee);
//		order.setShip_info(ship_info);
//		order.setSupport_admin_id(support_admin_id);
		order.setOrd_no(order_id);
		System.out.println(order);
		dao.update(order);
		return order;
	};
	
	public void deleteOrder(int pk) {
		dao.delete(pk);
	};
	
	public Order getOneByOrderId(int pk) {
		return dao.findByPK(pk);
	};
	
	public List<Order> getOneByUserId(int id){
		return dao.findByUser(id);
	};
	
	public List<Order> getAll(){
		return dao.getAll();
	};
}
