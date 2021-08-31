package com.block_list.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class Block_ListVO implements Serializable {
	private Integer serial_no;
	private Integer user_id;
	private Integer block_user_id;
	private Timestamp block_time;

	public Integer getSerial_no() {
		return serial_no;
	}

	public void setSerial_no(Integer serial_no) {
		this.serial_no = serial_no;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getBlock_user_id() {
		return block_user_id;
	}

	public void setBlock_user_id(Integer block_user_id) {
		this.block_user_id = block_user_id;
	}

	public Timestamp getBlock_time() {
		return block_time;
	}

	public void setBlock_time(Timestamp block_time) {
		this.block_time = block_time;
	}

	@Override
	public String toString() {
		return "Block_ListVO [serial_no=" + serial_no + ", user_id=" + user_id + ", block_user_id=" + block_user_id
				+ ", block_time=" + block_time + "]";
	}

	
}
