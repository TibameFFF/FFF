package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.forum.controller.ArticleDAOImp;
import com.forum.controller.Article_LikeDAOImp;
import com.forum.model.article;
import com.forum.model.article_like;

public class Fake_article_like {

	public boolean importArticleLikeData(String filePath, int userID) {

		boolean result = false;
		try {

			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\article_like.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);

			String line = "";
			// 開始讀取txt文字檔
			article_like article_like2 = null;
			article article = null;
			Article_LikeDAOImp article_like = new Article_LikeDAOImp();
			ArticleDAOImp articleDAOImp = new ArticleDAOImp();
			
			while ((line = br.readLine()) != null) {
				article_like2 = new article_like();
				String[] TextArry = line.split("@");
			
				article_like2.setUser_id(Integer.valueOf(userID));// 1
				article = new article();
				article.setUser_id(article_like2.getUser_id());
				List<article> articleList = articleDAOImp.queryByArticle(article);

				if (articleList.isEmpty()) {
					break;
				}
				article_like2.setUser_id(article.getUser_id());
				article_like2.setArticle_id(articleList.get(0).getArticle_id());// 1
				article_like2.setLike_time((Date) sdFormat.parse(TextArry[2]));// 羽毛球發球
				article_like.insert(article_like2); // ------>這個程式有錯誤
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
