package com.forum.model;

import java.util.Date;

public class reply_like {
	private Integer	like_id;
	private Integer	user_id;
	private Integer	reply_id;
	private Date	like_time;
	
	public Integer getLike_id() {
		return like_id;
	}
	public void setLike_id(Integer like_id) {
		this.like_id = like_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getReply_id() {
		return reply_id;
	}
	public void setReply_id(Integer reply_id) {
		this.reply_id = reply_id;
	}
	public Date getLike_time() {
		return like_time;
	}
	public void setLike_time(Date like_time) {
		this.like_time = like_time;
	}


	
	
	
	
}
