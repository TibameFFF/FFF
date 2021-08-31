package com.group.model;

import java.util.*;

public interface TypeDAO_interface {
          public void insert(TypeVO typeVO);
          public void update(TypeVO typeVO);
          public void delete(Integer g_type_no);
          public TypeVO findByPrimaryKey(Integer g_type_no);
          public List<TypeVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<TypeVO> getAll(Map<String, String[]> map); 
}
