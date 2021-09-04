package com.shop.model;

import java.io.Serializable;
import java.util.Arrays;

public class ProdPics implements Serializable {
	@Override
	public String toString() {
		return "ProdPics [prod_pic_id=" + prod_pic_id + ", prod_id=" + prod_id + ", prod_pic="
				+ Arrays.toString(prod_pic) + "]";
	}
	private Integer prod_pic_id;
	private Integer prod_id;
	private byte[] prod_pic;
	
	
	public Integer getProd_pic_id() {
		return prod_pic_id;
	}
	public void setProd_pic_id(Integer prod_pic_id) {
		this.prod_pic_id = prod_pic_id;
	}
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public byte[] getProd_pic() {
		return prod_pic;
	}
	public void setProd_pic(byte[] prod_pic) {
		this.prod_pic = prod_pic;
	}
	
	
}
