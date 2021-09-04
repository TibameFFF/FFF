package com.forum.DAO;

import java.util.List;

import com.forum.model.reply_like;

public interface Reply_LikeDAO {
			
			public void insert(reply_like reply_like);
			public void update(reply_like reply_like);
			public void delete(Integer like_id);
			public reply_like findByPrimaryKey(Integer like_id);
			public List<reply_like>getAll();
}
