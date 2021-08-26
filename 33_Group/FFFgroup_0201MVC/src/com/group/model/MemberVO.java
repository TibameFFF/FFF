package com.group.model;

import java.sql.Timestamp;


public class MemberVO implements java.io.Serializable {
	private Integer join_no;
	private Integer role;
	private Integer user_id;
	private Integer g_no;
	private Timestamp join_time;
	
	
	public MemberVO() {
		super();
	}
	public Integer getJoin_no() {
		return join_no;
	}
	public void setJoin_no(Integer join_no) {
		this.join_no = join_no;
	}
	public Integer getRole() {
		return role;
	}
	public void setRole(Integer role) {
		this.role = role;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getG_no() {
		return g_no;
	}
	public void setG_no(Integer g_no) {
		this.g_no = g_no;
	}
	public Timestamp getJoin_time() {
		return join_time;
	}
	public void setJoin_time(Timestamp join_time) {
		
		this.join_time = join_time;
	}
	@Override
	public String toString() {
		return "MemberVO [join_no=" + join_no + ", role=" + role + ", user_id=" + user_id + ", g_no=" + g_no
				+ ", join_time=" + join_time + "]";
	}

}
