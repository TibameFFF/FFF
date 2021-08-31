package com.forum.model;

import java.util.Date;

public class article {
	private	Integer article_id;
	private Integer user_id;
	private	Integer article_type_num;
	private	String title;
	private	String article_content;
	private	Date article_time;
	private	Integer pageviews;
	private	Integer article_num_count;
	private	String article_status;
	
	public Integer getArticle_id() {
		return article_id;
	}
	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getArticle_type_num() {
		return article_type_num;
	}
	public void setArticle_type_num(Integer article_type_num) {
		this.article_type_num = article_type_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getArticle_content() {
		return article_content;
	}
	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}
	public Date getArticle_time() {
		return article_time;
	}
	public void setArticle_time(Date article_time) {
		this.article_time = article_time;
	}
	public Integer getPageviews() {
		return pageviews;
	}
	public void setPageviews(Integer pageviews) {
		this.pageviews = pageviews;
	}
	public Integer getArticle_num_count() {
		return article_num_count;
	}
	public void setArticle_num_count(Integer article_num_count) {
		this.article_num_count = article_num_count;
	}
	public String getArticle_status() {
		return article_status;
	}
	public void setArticle_status(String article_status) {
		this.article_status = article_status;
	}
	
	
	
}
