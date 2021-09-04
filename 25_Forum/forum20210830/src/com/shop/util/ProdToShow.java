package com.shop.util;

import java.io.Serializable;

public class ProdToShow implements Serializable{
	private static final long serialVersionUID = 1L;
	@Override
	public String toString() {
		return "ProdToShow [prod_id=" + prod_id + ", prod_name=" + prod_name + ", price=" + price + ", img1=" + img1
				+ ", img2=" + img2 + ", sale=" + sale + ", star=" + star + ", favProd=" + favProd + "]";
	}
	private Integer prod_id; //get
	private String prod_name; //get
	private Integer price; //get
	private String img1; //catch
	private String img2; //catch
	private Integer sale; //catch
	private Double star; //catch
	private Boolean favProd;
	private Byte status;
	
	
	
	public Byte getStatus() {
		return status;
	}
	public void setStatus(Byte status) {
		this.status = status;
	}
	public Boolean getFavProd() {
		return favProd;
	}
	public void setFavProd(Boolean favProd) {
		this.favProd = favProd;
	}
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public Integer getSale() {
		return sale;
	}
	public void setSale(Integer sale) {
		this.sale = sale;
	}
	public Double getStar() {
		return star;
	}
	public void setStar(Double star) {
		this.star = star;
	}
	
	
	
	
}
