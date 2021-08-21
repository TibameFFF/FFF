package com.group.model;

import java.sql.Timestamp;

public class ReplyVO implements java.io.Serializable{
	private Integer reply_no;
	private Integer user_id;
	private Timestamp reply_time;
	private String reply;
	private Integer comment_no;

	public ReplyVO() {
		super();
	}
	public Integer getReply_no() {
		return reply_no;
	}
	public void setReply_no(Integer reply_no) {
		this.reply_no = reply_no;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Timestamp getReply_time() {
		return reply_time;
	}
	public void setReply_time(Timestamp reply_time) {
		this.reply_time = reply_time;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Integer getComment_no() {
		return comment_no;
	}
	public void setComment_no(Integer comment_no) {
		this.comment_no = comment_no;
	}
	@Override
	public String toString() {
		return "ReplyVO [reply_no=" + reply_no + ", user_id=" + user_id + ", reply_time=" + reply_time + ", reply="
				+ reply + ", comment_no=" + comment_no + "]";
	}
	
}
