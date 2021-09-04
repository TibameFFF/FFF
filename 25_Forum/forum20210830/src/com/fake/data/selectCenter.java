package com.fake.data;

import com.forum.DAOImp.ArticleDAOImp;

public class selectCenter {

	public int queryCenter() {
		int userId = 0;
		try {
			ArticleDAOImp articleDAOImp = new ArticleDAOImp();
			userId = articleDAOImp.selectCenter("James");

		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());

		}
		return userId;
	}
}
