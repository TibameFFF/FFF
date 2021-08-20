package com.shop.dao;

import java.util.List;

import com.shop.model.EvalPic;

public interface EvalPicDAO {
	void add(EvalPic evalPic);
	List<EvalPic> findByProdID (int id);
}
