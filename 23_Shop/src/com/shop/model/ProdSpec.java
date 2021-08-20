package com.shop.model;

import java.io.Serializable;

public class ProdSpec implements Serializable {
	@Override
	public String toString() {
		return "ProdSpec [prod_spec_id=" + prod_spec_id + ", prod_id=" + prod_id + ", spec_name=" + spec_name
				+ ", stock=" + stock + ", prod_price=" + prod_price + "]";
	}
	private Integer prod_spec_id;
	private Integer prod_id;
	private String spec_name;
	private Integer stock;
	private Integer prod_price;
	
	public Integer getProd_spec_id() {
		return prod_spec_id;
	}
	public void setProd_spec_id(Integer prod_spec_id) {
		this.prod_spec_id = prod_spec_id;
	}
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public String getSpec_name() {
		return spec_name;
	}
	public void setSpec_name(String spec_name) {
		this.spec_name = spec_name;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getProd_price() {
		return prod_price;
	}
	public void setProd_price(Integer prod_price) {
		this.prod_price = prod_price;
	}
}
