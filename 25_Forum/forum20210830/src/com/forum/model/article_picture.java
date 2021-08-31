package com.forum.model;

import java.sql.Blob;

public class article_picture {
	private Integer	pic_id;
	private Integer	article_id;
	private Blob	image;
	
	public Integer getPic_id() {
		return pic_id;
	}
	public void setPic_id(Integer pic_id) {
		this.pic_id = pic_id;
	}
	public Integer getArticle_id() {
		return article_id;
	}
	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
	










}
