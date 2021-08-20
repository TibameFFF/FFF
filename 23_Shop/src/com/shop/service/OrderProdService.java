package com.shop.service;

import java.util.List;

import com.shop.dao.OrderProdDAO;
import com.shop.daoImpl.OrderProdDAOImpl;
import com.shop.model.OrderProd;

public class OrderProdService {
	private OrderProdDAO dao;
	
	public OrderProdService() {
		dao = new OrderProdDAOImpl();
	}
	
	public OrderProd addOrderProd(int ord_no, int prod_spec_id, String hist_prod_name, String hist_prod_spec, int hist_prod_price, byte[] hist_prod_pic, int prod_num) {
		OrderProd orderProd = new OrderProd();
		orderProd.setOrd_no(ord_no);
		orderProd.setProd_spec_id(prod_spec_id);
		orderProd.setHist_prod_name(hist_prod_name);
		orderProd.setHist_prod_spec(hist_prod_spec);
		orderProd.setHist_prod_price(hist_prod_price);
		orderProd.setHist_prod_pic(hist_prod_pic);
		orderProd.setProd_num(prod_num);
		
		dao.add(orderProd);
		
		return orderProd;
	};
	
	public OrderProd updateOrderProdComment(int eval_star, String eval_text, int ord_prod_id ) {
		OrderProd orderProd = new OrderProd();
		orderProd.setEval_star(eval_star);
		orderProd.setEval_text(eval_text);
		orderProd.setOrd_prod_id(ord_prod_id);
		
		dao.updateComment(orderProd);
		
		return orderProd;
	};
	
	public List<OrderProd> getAllByOrdNo(int ordNo){
		return dao.findByOrdNo(ordNo);
	};
	
	public List<OrderProd> getAllByProdSpec(int specID){
		return dao.findByProdSpec(specID);
	};
}
