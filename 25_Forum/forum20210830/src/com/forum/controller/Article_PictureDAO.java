package com.forum.controller;

import java.util.List;

import com.forum.model.article_picture;

public interface Article_PictureDAO {
	public void insert(article_picture article_picture,int count);
	public void update(article_picture article_picture);
	public void delete(Integer pic_id);
	public article_picture findByPrimaryKey(Integer pic_id);
	public List<article_picture> getAll();
	

}
