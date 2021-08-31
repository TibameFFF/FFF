package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.List;

import com.forum.controller.ArticleDAOImp;
import com.forum.controller.Article_PictureDAOImp;
import com.forum.model.article;
import com.forum.model.article_picture;

public class Fake_article_picture {

	public boolean importArticle_PictureData(String filePath, int userid) {

		boolean result = false;
	
		try {
		
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\article_picture.txt";
			
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);
			
			String line = "";
			// 開始讀取txt文字檔
			article_picture article_picture3 = null;
			article article = null;
			Article_PictureDAOImp article_picture = new Article_PictureDAOImp();       //	List<article_picture> article_pictureList = new  ArrayList<>();
			ArticleDAOImp articleDAOImp = new ArticleDAOImp();                                                                	//	Article_PictureDAOImp article_picture = new Article_PictureDAOImp();
			int count =1;
			while ((line = br.readLine()) != null) {
				// step 1 新尋找文章的ID
				article = new article();
				article.setUser_id(userid);
				List<article> articleList = articleDAOImp.queryByArticle(article);
				
				article_picture3 = new article_picture();
				article_picture3.setArticle_id(articleList.get(count).getArticle_id());
				
				article_picture.insert(article_picture3,count); 
				count++;
				
				

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

//	private static InputStream getPictureStream(String string) {
//
//		return null;
//	}
	



	

