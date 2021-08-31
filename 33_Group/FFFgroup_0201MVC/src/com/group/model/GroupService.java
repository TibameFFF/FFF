package com.group.model;
//import java.sql.Timestamp;
import java.util.List;

import com.group.model.GroupVO;

public class GroupService {

	private GroupDAO_interface dao;

	public GroupService() {
		dao = new GroupJDBCDAO();
	}

	public GroupVO addGroup( 
//	 Integer g_no,
	 String g_name,
	 Integer g_type_no,
	 String g_content,
	 java.sql.Timestamp g_start_time,
	 java.sql.Timestamp g_end_time,
	 java.sql.Timestamp apply_start_time,
	 java.sql.Timestamp apply_end_time,
	 String place,
	 Integer number_lower,
	 Integer number_upper,
	 Integer number_total,
	 Integer user_id,
	 String introduce,
	 String phone,
	 String email,
	 Integer state_no,
	 String g_flow_cause,
	 byte[] photo,
	 String g_url
	 ) {

		GroupVO groupVO = new GroupVO();

		groupVO.setG_name(g_name);
		groupVO.setG_type_no(g_type_no);
		groupVO.setG_content(g_content);
		groupVO.setG_start_time(g_start_time);
		groupVO.setG_end_time(g_end_time);
		groupVO.setApply_start_time(apply_start_time);
		groupVO.setApply_end_time(apply_end_time);
		groupVO.setPlace(place);
		groupVO.setNumber_lower(number_lower);
		groupVO.setNumber_upper(number_upper);
		groupVO.setNumber_total(number_total);
		groupVO.setUser_id(user_id);
		groupVO.setIntroduce(introduce);
		groupVO.setPhone(phone);
		groupVO.setEmail(email);
		groupVO.setState_no(state_no);
		groupVO.setG_flow_cause(g_flow_cause);
		groupVO.setPhoto(photo);
		groupVO.setG_url(g_url);
		dao.insert(groupVO);

		return groupVO;
	}
	//預留給 Struts 2 用的
	public void addGroup(GroupVO groupVO) {
		dao.insert(groupVO);
	}
	public GroupVO updateGroup(
			 Integer g_no,
			 String g_name,
			 Integer g_type_no,
			 String g_content,
			 java.sql.Timestamp g_start_time,
			 java.sql.Timestamp g_end_time,
			 java.sql.Timestamp apply_start_time,
			 java.sql.Timestamp apply_end_time,
			 String place,
			 Integer number_lower,
			 Integer number_upper,
			 Integer number_total,
			 Integer user_id,
			 String introduce,
			 String phone,
			 String email,
			 Integer state_no,
			 String g_flow_cause,
			 byte[] photo,
			 String g_url
			 ) {

		GroupVO groupVO = new GroupVO();
		groupVO.setG_no(g_no);
		groupVO.setG_name(g_name);
		groupVO.setG_type_no(g_type_no);
		groupVO.setG_content(g_content);
		groupVO.setG_start_time(g_start_time);
		groupVO.setG_end_time(g_end_time);
		groupVO.setApply_start_time(apply_start_time);
		groupVO.setApply_end_time(apply_end_time);
		groupVO.setPlace(place);
		groupVO.setNumber_lower(number_lower);
		groupVO.setNumber_upper(number_upper);
		groupVO.setNumber_total(number_total);
		groupVO.setUser_id(user_id);
		groupVO.setIntroduce(introduce);
		groupVO.setPhone(phone);
		groupVO.setEmail(email);
		groupVO.setState_no(state_no);
		groupVO.setG_flow_cause(g_flow_cause);
		groupVO.setPhoto(photo);
		groupVO.setG_url(g_url);
		dao.update(groupVO);

		return dao.findByPrimaryKey(g_no);
	}
	//預留給 Struts 2 用的
	public void updateGroup(GroupVO groupVO) {
		dao.update(groupVO);
	}
	public void deleteGroup(Integer g_no) {
		dao.delete(g_no);
	}

	public GroupVO getOneGroup(Integer g_no) {
		return dao.findByPrimaryKey(g_no);
	}

	public List<GroupVO> getAll() {
		return dao.getAll();
	}
	
	public List<GroupVO> getAllFromState_no(Integer state_no) {
		return dao.getAllFromState_no(state_no);
	}
	
	public List<GroupVO> findMyGroups(Integer user_id) {
		return dao.findMyGroups(user_id);
	}
	public List<GroupVO> getMyGroup(Integer user_id,Integer state_no) {
		return dao.getMyGroup(user_id,state_no);
	}	
	public int getG_nob() {
		return dao.getG_nob();
	}
}
