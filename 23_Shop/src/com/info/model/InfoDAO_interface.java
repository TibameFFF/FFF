package com.info.model;

import java.util.*;

public interface InfoDAO_interface {
	public void add(InfoVO infoVO);

	public void update_info(InfoVO infoVO);
	
	public void update_mapping(InfoVO infoVO);

	public InfoVO findByPrimaryKey(String account);

	public List<InfoVO> getAll();
}
