package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import com.shop.dao.EvalPicDAO;
import com.shop.daoImpl.EvalPicDAOImpl;
import com.shop.model.EvalPic;

public class EvalPicService {
	private EvalPicDAO dao;
	
	public EvalPicService() {
		dao = new EvalPicDAOImpl();
	}
	
	public EvalPic addEvalPic(int ord_prod_id, byte[] eval_pic) {
		EvalPic evalPic = new EvalPic();
		
		evalPic.setEval_pic(eval_pic);
		evalPic.setOrd_prod_id(ord_prod_id);
		dao.add(evalPic);
		
		return evalPic;
	}
	
	public List<EvalPic> getEvalPicByProdId(int id){
		return dao.findByProdID(id);
	}

}
