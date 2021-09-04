package com.forum.DAO;

import java.util.List;

import com.forum.model.article_like;

public interface Article_LikeDAO {
	
	public	void insert(article_like article_like);
	public	void update(article_like article_like);
	public	void delete(Integer like_id);
	public	article_like article_likefindByPrimaryKey(Integer like_id);
	public	List<article_like> getAll();
	
	

}
