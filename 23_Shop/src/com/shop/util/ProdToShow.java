package com.shop.util;

public class ProdToShow {
	@Override
	public String toString() {
		return "ProdToShow [prod_id=" + prod_id + ", prod_name=" + prod_name + ", price=" + price + ", img1=" + img1
				+ ", img2=" + img2 + ", sale=" + sale + ", star=" + star + "]";
	}
	private Integer prod_id;
	private String prod_name;
	private Integer price;
	private String img1;
	private String img2;
	private Integer sale;
	private Double star;
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
