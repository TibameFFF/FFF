package com.group.model;

import java.util.*;

public interface GroupDAO_interface {
          public void insert(GroupVO groupVO);
          public void update(GroupVO groupVO);
          public void delete(Integer groupVO);
          public GroupVO findByPrimaryKey(Integer g_no);
          public int getG_nob();
          public List<GroupVO> getAll();
          public List<GroupVO> getAllFromState_no(Integer state_no);
          public List<GroupVO> findMyGroups(Integer user_id);
      	  public List<GroupVO> getMyGroup(Integer user_id,Integer state_no);
    	
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<GroupVO> getAll(Map<String, String[]> map); 
}
