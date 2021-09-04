package com.shop.model;

import java.io.Serializable;

public class ProdShips implements Serializable {
	@Override
	public String toString() {
		return "ProdShips [prod_ship_id=" + prod_ship_id + ", prod_id=" + prod_id + ", ship_no=" + ship_no + "]";
	}
	private Integer prod_ship_id;
	private Integer prod_id;
	private Integer ship_no;
	
	public Integer getProd_ship_id() {
		return prod_ship_id;
	}
	public void setProd_ship_id(Integer prod_ship_id) {
		this.prod_ship_id = prod_ship_id;
	}
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public Integer getShip_no() {
		return ship_no;
	}
	public void setShip_no(Integer ship_no) {
		this.ship_no = ship_no;
	}
	
	
}
