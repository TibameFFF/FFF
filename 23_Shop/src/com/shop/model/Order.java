package com.shop.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Order implements Serializable{
	@Override
	public String toString() {
		return "Order [ord_no=" + ord_no + ", support_admin_id=" + support_admin_id + ", user_id=" + user_id
				+ ", ord_time=" + ord_time + ", ord_status=" + ord_status + ", ord_total=" + ord_total
				+ ", ship_method=" + ship_method + ", ship_fee=" + ship_fee + ", ship_info=" + ship_info + "]";
	}
	private Integer ord_no;
	private Integer support_admin_id;
	private Integer user_id;
	private Timestamp ord_time;
	private String ord_status;
	private Integer ord_total;
	private String ship_method;
	private Integer ship_fee;
	private String ship_info;
	
	
	public Integer getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(Integer ord_no) {
		this.ord_no = ord_no;
	}
	public Integer getSupport_admin_id() {
		return support_admin_id;
	}
	public void setSupport_admin_id(Integer support_admin_id) {
		this.support_admin_id = support_admin_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Timestamp getOrd_time() {
		return ord_time;
	}
	public void setOrd_time(Timestamp ord_time) {
		this.ord_time = ord_time;
	}
	public String getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(String ord_status) {
		this.ord_status = ord_status;
	}
	public Integer getOrd_total() {
		return ord_total;
	}
	public void setOrd_total(Integer ord_total) {
		this.ord_total = ord_total;
	}
	public String getShip_method() {
		return ship_method;
	}
	public void setShip_method(String ship_method) {
		this.ship_method = ship_method;
	}
	public Integer getShip_fee() {
		return ship_fee;
	}
	public void setShip_fee(Integer ship_fee) {
		this.ship_fee = ship_fee;
	}
	public String getShip_info() {
		return ship_info;
	}
	public void setShip_info(String ship_info) {
		this.ship_info = ship_info;
	}
}
