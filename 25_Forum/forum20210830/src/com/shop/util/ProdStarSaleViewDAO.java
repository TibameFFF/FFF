package com.shop.util;

import java.util.List;

public interface ProdStarSaleViewDAO {
	List<ProdStarSaleView> findByProdID(int id);
	Integer getNumComment(int id);
	Integer getNumSale(int id);
	Double getStarRate(int id);
}
