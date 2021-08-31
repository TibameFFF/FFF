package com.forum.controller;

import java.util.List;

import com.forum.model.article;

public interface ArticleDAO {
	
	 public void insert (article article);
	 public void update (article article);
	 public void delete (Integer article_id);
	 public article findByPrimaryKey(Integer article_id);
	 public List<article> getAll();
	 public List<article>queryByArticle(article article);
	 
	 public List<article> queryAll();

}
