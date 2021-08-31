package com.forum.controller;

import java.util.List;

import com.emp.model.EmpVO;
import com.forum.model.article;
import com.forum.model.reply;

public interface ReplyDAO {
	 public void insert(reply reply);
	 public void update(reply reply);
	 public void delete(Integer reply_id);
	 public reply findByPrimaryKey(Integer reply_id);
     public List<reply> getAll();
     public List<reply>queryByReply(reply reply);
     
     public List<reply> queryAll();
}
