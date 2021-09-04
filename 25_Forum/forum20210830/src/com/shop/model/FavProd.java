package com.shop.model;

import java.io.Serializable;

public class FavProd implements Serializable{
	@Override
	public String toString() {
		return "FavProd [prod_fav_id=" + prod_fav_id + ", user_id=" + user_id + ", prod_id=" + prod_id + "]";
	}
	private Integer prod_fav_id;
	private Integer user_id;
	private Integer prod_id;
	
	public Integer getProd_fav_id() {
		return prod_fav_id;
	}
	public void setProd_fav_id(Integer prod_fav_id) {
		this.prod_fav_id = prod_fav_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
}
