package com.group.model;

import java.sql.Timestamp;
import java.util.Arrays;
import java.sql.Timestamp;

public class GroupVO implements java.io.Serializable {
	private Integer g_no;
	private String g_name;
	private Integer g_type_no;
	private String g_content;
	private Timestamp g_start_time;
	private Timestamp g_end_time;
	private Timestamp apply_start_time;
	private Timestamp apply_end_time;
	private String place;
	private Integer number_lower;
	private Integer number_upper;
	private Integer number_total;
	private Integer user_id;
	private String introduce;
	private String phone;
	private String email;
	private Integer state_no;
	private String g_flow_cause;
	private byte[] photo;
	private String g_url;
	
	public GroupVO() {
		super();
	}
	public Integer getG_no() {
		return g_no;
	}
	public void setG_no(Integer g_no) {
		this.g_no = g_no;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public Integer getG_type_no() {
		return g_type_no;
	}
	public void setG_type_no(Integer g_type_no) {
		this.g_type_no = g_type_no;
	}
	public String getG_content() {
		return g_content;
	}
	public void setG_content(String g_content) {
		this.g_content = g_content;
	}
	public Timestamp getG_start_time() {
		return g_start_time;
	}
	public void setG_start_time(Timestamp g_start_time) {
		this.g_start_time = g_start_time;
	}
	public Timestamp getG_end_time() {
		return g_end_time;
	}
	public void setG_end_time(Timestamp g_end_time) {
		this.g_end_time = g_end_time;
	}
	public Timestamp getApply_start_time() {
		return apply_start_time;
	}
	public void setApply_start_time(Timestamp apply_start_time) {
		this.apply_start_time = apply_start_time;
	}
	public Timestamp getApply_end_time() {
		return apply_end_time;
	}
	public void setApply_end_time(Timestamp apply_end_time) {
		this.apply_end_time = apply_end_time;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public Integer getNumber_lower() {
		return number_lower;
	}
	public void setNumber_lower(Integer number_lower) {
		this.number_lower = number_lower;
	}
	public Integer getNumber_upper() {
		return number_upper;
	}
	public void setNumber_upper(Integer number_upper) {
		this.number_upper = number_upper;
	}
	public Integer getNumber_total() {
		return number_total;
	}
	public void setNumber_total(Integer number_total) {
		this.number_total = number_total;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getState_no() {
		return state_no;
	}
	public void setState_no(Integer state_no) {
		this.state_no = state_no;
	}
	public String getG_flow_cause() {
		return g_flow_cause;
	}
	public void setG_flow_cause(String g_flow_cause) {
		this.g_flow_cause = g_flow_cause;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public String getG_url() {
		return g_url;
	}
	public void setG_url(String g_url) {
		this.g_url = g_url;
	}
	@Override
	public String toString() {
		return "GroupVO [g_no=" + g_no + ", g_name=" + g_name + ", g_type_no=" + g_type_no + ", g_content=" + g_content
				+ ", g_start_time=" + g_start_time + ", g_end_time=" + g_end_time + ", apply_start_time="
				+ apply_start_time + ", apply_end_time=" + apply_end_time + ", place=" + place + ", number_lower="
				+ number_lower + ", number_upper=" + number_upper + ", number_total=" + number_total + ", user_id="
				+ user_id + ", introduce=" + introduce + ", phone=" + phone + ", email=" + email + ", state_no="
				+ state_no + ", g_flow_cause=" + g_flow_cause + ", photo=" + Arrays.toString(photo) + ", g_url=" + g_url
				+ "]";
	} 
	
}
//g_no, g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url