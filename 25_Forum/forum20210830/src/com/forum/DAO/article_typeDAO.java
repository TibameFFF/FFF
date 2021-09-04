package com.forum.DAO;

import java.util.List;

import com.forum.model.article_type;

public interface Article_TypeDAO {
	      public void insert(article_type article_type);
	      public void update(article_type article_type);
	      public void delete(Integer article_type_num );
	      public article_type findByPrimaryKey(Integer article_type_num );
	      public List<article_type> getAll();

}
