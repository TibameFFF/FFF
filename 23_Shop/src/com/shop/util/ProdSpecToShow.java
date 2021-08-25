package com.shop.util;

import java.util.ArrayList;

public class ProdSpecToShow {
	private ArrayList<String> specList;
	private ArrayList<Integer> specIdList;
	private ArrayList<Integer> specPriceList;
	private ArrayList<Integer> specStockList;
	private ArrayList<Integer> prodPicList;
	
	public ArrayList<Integer> getSpecStockList() {
		return specStockList;
	}
	public void setSpecStockList(ArrayList<Integer> specStockList) {
		this.specStockList = specStockList;
	}
	public ArrayList<Integer> getSpecIdList() {
		return specIdList;
	}
	public void setSpecIdList(ArrayList<Integer> specIdList) {
		this.specIdList = specIdList;
	}
	public ArrayList<Integer> getProdPicList() {
		return prodPicList;
	}
	public void setProdPicList(ArrayList<Integer> prodPicList) {
		this.prodPicList = prodPicList;
	}
	String prodName;
	public ArrayList<String> getSpecList() {
		return specList;
	}
	public void setSpecList(ArrayList<String> specList) {
		this.specList = specList;
	}
	public ArrayList<Integer> getSpecPriceList() {
		return specPriceList;
	}
	public void setSpecPriceList(ArrayList<Integer> specPriceList) {
		this.specPriceList = specPriceList;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	
}
