package com.group.model;

import java.util.*;

public interface CommentDAO_interface {
          public void insert(CommentVO commentVO);
          public void update(CommentVO commentVO);
          public void delete(Integer comment_no);
          public CommentVO findByPrimaryKey(Integer comment_no);
          public List<CommentVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
