package com.group.model;

import java.util.*;

public interface MemberDAO_interface {
          public void insert(MemberVO memberVO);
          public void update(MemberVO memberVO);
          public void delete(Integer join_no);
          public MemberVO findByPrimaryKey(Integer join_no);
          public List<MemberVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
