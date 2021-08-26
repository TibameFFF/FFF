package com.group.model;

import java.util.*;

public interface MemberDAO_interface {
          public void insert(MemberVO memberVO);
          public void update(MemberVO memberVO);
          public void delete(Integer join_no);
          public MemberVO findByPrimaryKey(Integer join_no);
          public List<MemberVO> getAll();
          public List<MemberVO> findByG_NO(Integer g_no);
          public List<MemberVO> findByUser_ID(Integer user_id);
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
