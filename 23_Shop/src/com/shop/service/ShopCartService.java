package com.shop.service;

import java.util.List;

import com.shop.dao.ShopCartDAO;
import com.shop.daoImpl.ShopCartDAOImpl;
import com.shop.model.ShopCart;

public class ShopCartService {
	private ShopCartDAO dao;
	
	public ShopCartService() {
		dao = new ShopCartDAOImpl();
	}
	
	public ShopCart addShopCart(int prod_num, int prod_spec_id, int user_id) {
		ShopCart shopCart = new ShopCart();
		shopCart.setProd_num(prod_num);
		shopCart.setProd_spec_id(prod_spec_id);
		shopCart.setUser_id(user_id);
		
		dao.add(shopCart);
		
		return shopCart;
	};
	
	public ShopCart updateShopCart(int prod_num, int prod_spec_id, int user_id) {
		ShopCart shopCart = new ShopCart();
		shopCart.setProd_num(prod_num);
		shopCart.setProd_spec_id(prod_spec_id);
		shopCart.setUser_id(user_id);
		
		dao.update(shopCart);
		return shopCart;
	}
	
	public void delete(ShopCart shopCart) {
		dao.delete(shopCart);
	};
	
	public List<ShopCart> getAllShopCartByUserID(int id){
		return dao.findByUserID(id);
	};
	
}
