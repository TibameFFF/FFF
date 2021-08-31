package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.forum.controller.ArticleDAOImp;
import com.forum.model.article;

public class Fake_article {
	public boolean importArticleData(String filePath, int userID) {
		boolean result = false;

		try {
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = filePath + "article.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);

			String line = "";
			// 開始讀取txt文字檔
			article article1 = null;
			ArticleDAOImp article = new ArticleDAOImp();

			while ((line = br.readLine()) != null) {
				article1 = new article();
				String[] TextArry = line.split("@");
				article1.setArticle_id(Integer.valueOf(TextArry[0]));// AI
				article1.setUser_id(userID);// 1
				article1.setArticle_type_num(Integer.valueOf(TextArry[1]));// 1
				article1.setTitle(String.valueOf(TextArry[2]));// 羽毛球發球
				article1.setArticle_content(String.valueOf(TextArry[3]));// 發球是所有羽毛球
//			article1.setArticle_time(new java.sql.Date ((sdFormat.parse(TextArry[4])).getDate()));// 2021/1/04
				article1.setArticle_time((Date) sdFormat.parse(TextArry[4]));
				article1.setPageviews(Integer.valueOf(TextArry[5]));
				article1.setArticle_num_count(Integer.valueOf(TextArry[6]));// 2
				article1.setArticle_status(String.valueOf(TextArry[7]));// 正常
				article.insert(article1);
				// ------>這個程式有錯誤

			}
			result = true;
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

}
