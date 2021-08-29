package com.info.model;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

public class InfoService {
	private InfoDAO_interface dao;

	public InfoService() {
		dao = new InfoDAO();
	}

	public InfoVO add(String usernickname, String username, String account, String email, java.sql.Date birthday,
			String password, Integer sex, byte[] photo, String intro) {
		InfoVO infoVO = new InfoVO();

		infoVO.setUser_nickname(usernickname);
		infoVO.setUser_name(username);
		infoVO.setAccount(account);
		infoVO.setEmail(email);
		infoVO.setBitrhday(birthday);
		infoVO.setPassword(password);
		infoVO.setSex(sex);
		infoVO.setPhoto(photo);
		infoVO.setIntro(intro);
		dao.add(infoVO);

		return infoVO;
	}

	public InfoVO update_info(String usernickname, String username, String password, byte[] photo, String account) {
		InfoVO infoVO = new InfoVO();
		infoVO.setUser_nickname(usernickname);
		infoVO.setUser_name(username);
		infoVO.setPassword(password);
		infoVO.setPhoto(photo);
		infoVO.setAccount(account);
		dao.update_info(infoVO);

		return infoVO;
	}

	public InfoVO update_mapping(Integer mapping, Integer agemin, Integer agemax, Integer mappingsex, String intro,
			String account) {
		InfoVO infoVO = new InfoVO();
		infoVO.setMapping(mapping);
		infoVO.setAge_min(agemin);
		infoVO.setAge_max(agemax);
		infoVO.setMapping_sex(mappingsex);
		infoVO.setIntro(intro);
		infoVO.setAccount(account);
		dao.update_mapping(infoVO);

		return infoVO;
	}

	public InfoVO findByPrimaryKey(String account) {
		return dao.findByPrimaryKey(account);
	};

	public List<InfoVO> getAll() {
		return dao.getAll();
	};

}
