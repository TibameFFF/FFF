package com.shop.model;

import java.io.Serializable;

public class ProdType implements Serializable{
	@Override
	public String toString() {
		return "ProdType [prod_type_no=" + prod_type_no + ", type_name=" + type_name + "]";
	}
	
	private Integer prod_type_no;
	private String type_name;
	
	public Integer getProd_type_no() {
		return prod_type_no;
	}
	public void setProd_type_no(Integer prod_type_no) {
		this.prod_type_no = prod_type_no;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	} 
}
