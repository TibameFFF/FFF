package com.group.model;

import java.util.*;

public interface GroupDAO_interface {
          public void insert(GroupVO groupVO);
          public void update(GroupVO groupVO);
          public void delete(Integer groupVO);
          public GroupVO findByPrimaryKey(Integer g_no);
          public List<GroupVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<GroupVO> getAll(Map<String, String[]> map); 
}
