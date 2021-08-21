package com.group.model;

import java.util.*;

public interface ReplyDAO_interface {
          public void insert(ReplyVO replyVO);
          public void update(ReplyVO replyVO);
          public void delete(Integer reply_no);
          public ReplyVO findByPrimaryKey(Integer reply_no);
          public List<ReplyVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
