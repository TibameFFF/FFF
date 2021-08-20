package com.shop.model;

import java.io.Serializable;

public class ShopCart implements Serializable {
	@Override
	public String toString() {
		return "ShopCart [cart_id=" + cart_id + ", prod_spec_id=" + prod_spec_id + ", user_id=" + user_id
				+ ", prod_num=" + prod_num + "]";
	}
	private Integer cart_id;
	private Integer prod_spec_id;
	private Integer user_id;
	private Integer prod_num;
	
	public Integer getCart_id() {
		return cart_id;
	}
	public void setCart_id(Integer cart_id) {
		this.cart_id = cart_id;
	}
	public Integer getProd_spec_id() {
		return prod_spec_id;
	}
	public void setProd_spec_id(Integer prod_spec_id) {
		this.prod_spec_id = prod_spec_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getProd_num() {
		return prod_num;
	}
	public void setProd_num(Integer prod_num) {
		this.prod_num = prod_num;
	}
}
