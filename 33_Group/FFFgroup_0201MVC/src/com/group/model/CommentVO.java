package com.group.model;

import java.sql.Timestamp;

public class CommentVO implements java.io.Serializable {

	private Integer comment_no;
	private Integer user_id;
	private Timestamp comment_time;
	private String comment;
	private Integer g_no;
	
	
	public CommentVO() {
		super();
	}
	public Integer getComment_no() {
		return comment_no;
	}
	public void setComment_no(Integer comment_no) {
		this.comment_no = comment_no;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Timestamp getComment_time() {
		return comment_time;
	}
	public void setComment_time(Timestamp comment_time) {
		this.comment_time = comment_time;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getG_no() {
		return g_no;
	}
	public void setG_no(Integer g_no) {
		this.g_no = g_no;
	}
	@Override
	public String toString() {
		return "CommentVO [comment_no=" + comment_no + ", user_id=" + user_id + ", comment_time=" + comment_time
				+ ", comment=" + comment + ", g_no=" + g_no + "]";
	}
	
}
