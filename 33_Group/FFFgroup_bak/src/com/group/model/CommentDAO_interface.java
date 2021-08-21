package com.group.model;

import java.util.*;

public interface CommentDAO_interface {
          public void insert(CommentVO commentVO);
          public void update(CommentVO commentVO);
          public void delete(Integer comment_no);
          public CommentVO findByPrimaryKey(Integer comment_no);
          public List<CommentVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
