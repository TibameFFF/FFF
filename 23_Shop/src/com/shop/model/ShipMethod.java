package com.shop.model;

import java.io.Serializable;

public class ShipMethod implements Serializable {
	@Override
	public String toString() {
		return "ShipMethod [ship_no=" + ship_no + ", ship_name=" + ship_name + ", ship_fee=" + ship_fee + "]";
	}
	private Integer ship_no;
	private String ship_name;
	private Integer ship_fee;
	
	public Integer getShip_no() {
		return ship_no;
	}
	public void setShip_no(Integer ship_no) {
		this.ship_no = ship_no;
	}
	public String getShip_name() {
		return ship_name;
	}
	public void setShip_name(String ship_name) {
		this.ship_name = ship_name;
	}
	public Integer getShip_fee() {
		return ship_fee;
	}
	public void setShip_fee(Integer ship_fee) {
		this.ship_fee = ship_fee;
	}
	
	
}
