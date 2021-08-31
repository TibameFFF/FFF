package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.forum.controller.ArticleDAOImp;
import com.forum.controller.Reply_LikeDAOImp;
import com.forum.model.article;
import com.forum.model.reply_like;

public class Fake_reply_like {

	public boolean importReplyLikeData(String filePath, int userID) {

		boolean result = false;
		try {

			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\reply_like.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);
			
			String line = "";
			// 開始讀取txt文字檔
			reply_like  reply_like6  = null;
			article article = null;
			Reply_LikeDAOImp reply_like =  new Reply_LikeDAOImp();
			ArticleDAOImp articleDAOImp = new ArticleDAOImp();
                                                                      //			List<reply_like > reply_likeList = new  ArrayList<>();
                                                                      //			Reply_LikeDAOImp reply_like = new Reply_LikeDAOImp();
		
			while ((line = br.readLine()) != null) {
				reply_like6 = new reply_like();
				String[] TextArry = line.split("@");
				reply_like6.setUser_id(Integer.valueOf(userID));
				article = new article();
				article.setUser_id(reply_like6.getUser_id());
				List<article> articleList = articleDAOImp.queryByArticle(article);

				if (articleList.isEmpty()) {
					break;
				}
				reply_like6.setUser_id(article.getUser_id());
//				reply_like6.setUser_id(Integer.valueOf(TextArry[0]));// 1
				reply_like6.setReply_id(articleList.get(0).getArticle_id());// 1
				reply_like6.setReply_id(Integer.valueOf(TextArry[1]));// 1
				reply_like6.setLike_time((Date) sdFormat.parse(TextArry[2]));// 羽毛球發球
				reply_like.insert(reply_like6);; // ------>這個程式有錯誤

			}
			result = true;
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());
		}
		return result;
	}

}

	


