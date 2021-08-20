package com.shop.model;

import java.io.Serializable;
import java.util.Arrays;

public class EvalPic implements Serializable{
	@Override
	public String toString() {
		return "EvalPic [eval_pic_id=" + eval_pic_id + ", ord_prod_id=" + ord_prod_id + ", eval_pic="
				+ Arrays.toString(eval_pic) + "]";
	}
	private Integer eval_pic_id;
	private Integer ord_prod_id;
	private byte[] eval_pic;
	
	
	public Integer getEval_pic_id() {
		return eval_pic_id;
	}
	public void setEval_pic_id(Integer eval_pic_id) {
		this.eval_pic_id = eval_pic_id;
	}
	public Integer getOrd_prod_id() {
		return ord_prod_id;
	}
	public void setOrd_prod_id(Integer ord_prod_id) {
		this.ord_prod_id = ord_prod_id;
	}
	public byte[] getEval_pic() {
		return eval_pic;
	}
	public void setEval_pic(byte[] eval_pic) {
		this.eval_pic = eval_pic;
	}
	
	
}
