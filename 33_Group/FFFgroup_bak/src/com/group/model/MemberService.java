package com.group.model;

import java.sql.Timestamp;
import java.util.List;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberJDBCDAO();
	}

	public MemberVO addMember(	 
	 Integer role,
	 Integer user_id,
	 Integer g_no,
	 Timestamp join_time) {

		MemberVO memberVO = new MemberVO();
		memberVO.setRole(role);
		memberVO.setUser_id(user_id);
		memberVO.setG_no(g_no);
		memberVO.setJoin_time(join_time);
		dao.insert(memberVO);

		return memberVO;
	}

	public MemberVO updateMember(
			 Integer join_no, 	 
			 Integer role,
			 Integer user_id,
			 Integer g_no,
			 Timestamp join_time) {

		MemberVO memberVO = new MemberVO();

		memberVO.setJoin_no(join_no);
		memberVO.setRole(role);
		memberVO.setUser_id(user_id);
		memberVO.setG_no(g_no);
		memberVO.setJoin_time(join_time);
		dao.update(memberVO);

		return memberVO;
	}

	public void deleteMember(Integer join_no) {
		dao.delete(join_no);
	}

	public MemberVO getOneMember(Integer join_no) {
		return dao.findByPrimaryKey(join_no);
	}

	public List<MemberVO> getAll() {
		return dao.getAll();
	}
	
    public List<MemberVO> find_G_NO_M(Integer g_no) {
    	return dao.findByG_NO(g_no);
    }
    
    public List<MemberVO> find_User_ID_M(Integer user_id) {
    	return dao.findByUser_ID(user_id);
    }
	
	
	
}
