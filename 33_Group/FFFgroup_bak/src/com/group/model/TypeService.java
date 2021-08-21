package com.group.model;

import java.util.List;

public class TypeService {

	private TypeDAO_interface dao;

	public TypeService() {
		dao = new TypeJDBCDAO();
	}

	public TypeVO addType(String g_type) {

		TypeVO typeVO = new TypeVO();

		typeVO.setG_type(g_type);

		dao.insert(typeVO);

		return typeVO;
	}

	public TypeVO updateType(Integer g_type_no,String g_type) {

		TypeVO typeVO = new TypeVO();
		typeVO.setG_type_no(g_type_no);
		typeVO.setG_type(g_type);
	
		dao.update(typeVO);

		return typeVO;
	}

	public void deleteType(Integer g_type_no) {
		dao.delete(g_type_no);
	}

	public TypeVO getOneType(Integer g_type_no) {
		return dao.findByPrimaryKey(g_type_no);
	}

	public List<TypeVO> getAll() {
		return dao.getAll();
	}
}
