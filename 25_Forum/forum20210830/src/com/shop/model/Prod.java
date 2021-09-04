package com.shop.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Prod implements Serializable {
	@Override
	public String toString() {
		return "Prod [prod_id=" + prod_id + ", prod_type_no=" + prod_type_no + ", prod_name=" + prod_name
				+ ", prod_text=" + prod_text + ", prod_on_time=" + prod_on_time + ", prod_off_time=" + prod_off_time
				+ ", prod_status=" + prod_status + "]";
	}
	private Integer prod_id;
	private Integer prod_type_no;
	private String prod_name;
	private String prod_text;
	private Timestamp prod_on_time;
	private Timestamp prod_off_time;
	private Byte prod_status;
	
	public Integer getProd_id() {
		return prod_id;
	}
	public void setProd_id(Integer prod_id) {
		this.prod_id = prod_id;
	}
	public Integer getProd_type_no() {
		return prod_type_no;
	}
	public void setProd_type_no(Integer prod_type_no) {
		this.prod_type_no = prod_type_no;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_text() {
		return prod_text;
	}
	public void setProd_text(String prod_text) {
		this.prod_text = prod_text;
	}
	public Timestamp getProd_on_time() {
		return prod_on_time;
	}
	public void setProd_on_time(Timestamp prod_on_time) {
		this.prod_on_time = prod_on_time;
	}
	public Timestamp getProd_off_time() {
		return prod_off_time;
	}
	public void setProd_off_time(Timestamp prod_off_time) {
		this.prod_off_time = prod_off_time;
	}
	public Byte getProd_status() {
		return prod_status;
	}
	public void setProd_status(Byte prod_status) {
		this.prod_status = prod_status;
	}
	
	
}
