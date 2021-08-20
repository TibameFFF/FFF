package com.shop.model;

import java.io.Serializable;

public class ProdStarSaleView implements Serializable{
	
	@Override
	public String toString() {
		return "ProdStarSaleView [prod_id=" + prod_id + ", prod_spec_id=" + prod_spec_id + ", eval_star=" + eval_star
				+ ", prod_num=" + prod_num + "]";
	}
	private Integer prod_id;
	private Integer prod_spec_id;
	private Integer eval_star;
	private Integer prod_num;
	
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public Integer getProd_spec_id() {
		return prod_spec_id;
	}
	public void setProd_spec_id(Integer prod_spec_id) {
		this.prod_spec_id = prod_spec_id;
	}
	public Integer getEval_star() {
		return eval_star;
	}
	public void setEval_star(Integer eval_star) {
		this.eval_star = eval_star;
	}
	public Integer getProd_num() {
		return prod_num;
	}
	public void setProd_num(Integer prod_num) {
		this.prod_num = prod_num;
	}
	
}
