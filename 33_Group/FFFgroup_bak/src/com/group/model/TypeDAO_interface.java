package com.group.model;

import java.util.*;

public interface TypeDAO_interface {
          public void insert(TypeVO typeVO);
          public void update(TypeVO typeVO);
          public void delete(Integer g_type_no);
          public TypeVO findByPrimaryKey(Integer g_type_no);
          public List<TypeVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TypeVO> getAll(Map<String, String[]> map); 
}
