package com.shop.util;

import java.util.List;

public interface ProdToShowDAO {
	List<ProdToShow> getAll();
	ProdToShow getByPk(int id);
	List<ProdToShow> getBySearch(String search);
	List<ProdToShow> filterByPriceTypeShip(List<Integer> price, List<Integer> typeList, List<Integer> ship, String search);
}
