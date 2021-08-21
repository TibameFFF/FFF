package com.group.model;

import java.util.*;

public interface GroupDAO_interface {
          public void insert(GroupVO groupVO);
          public void update(GroupVO groupVO);
          public void delete(Integer groupVO);
          public GroupVO findByPrimaryKey(Integer g_no);
          public List<GroupVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<GroupVO> getAll(Map<String, String[]> map); 
}
