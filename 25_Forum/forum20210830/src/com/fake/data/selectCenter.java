package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.List;

import com.forum.controller.ArticleDAOImp;
import com.forum.controller.Article_TypeDAOImp;
import com.forum.model.article;
import com.forum.model.article_type;

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
