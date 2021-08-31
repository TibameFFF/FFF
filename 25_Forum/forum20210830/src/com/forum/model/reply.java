package com.forum.model;

import java.util.Date;

public class reply {
	private Integer	reply_id;
	private Integer	article_id;
	private Integer	reply_user_id;
	private String	reply_content;
	private Date	reply_time;
	private Integer	reply_like_count;
	private String	reply_status;
	private Date	lastreplytime;

	public Integer getReply_id() {
		return reply_id;
	}
	public void setReply_id(Integer reply_id) {
		this.reply_id = reply_id;
	}
	public Integer getArticle_id() {
		return article_id;
	}
	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}
	public Integer getReply_user_id() {
		return reply_user_id;
	}
	public void setReply_user_id(Integer reply_user_id) {
		this.reply_user_id = reply_user_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Date getReply_time() {
		return reply_time;
	}
	public void setReply_time(Date reply_time) {
		this.reply_time = reply_time;
	}
	public Integer getReply_like_count() {
		return reply_like_count;
	}
	public void setReply_like_count(Integer reply_like_count) {
		this.reply_like_count = reply_like_count;
	}
	public String getReply_status() {
		return reply_status;
	}
	public void setReply_status(String reply_status) {
		this.reply_status = reply_status;
	}
	public Date getLastreplytime() {
		return lastreplytime;
	}
	public void setLastreplytime(Date lastreplytime) {
		this.lastreplytime = lastreplytime;
	}
	
}
