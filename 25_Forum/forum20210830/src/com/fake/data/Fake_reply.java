package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.DAOImp.ReplyDAOImp;
import com.forum.model.article;
import com.forum.model.reply;

public class Fake_reply {
	public boolean importReplyData(String filePath,int userid) {
		boolean result = false;
	
		try {
			
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\reply.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);

			String line = "";
			// 開始讀取txt文字檔
			reply reply5 = null;
			ReplyDAOImp reply = new ReplyDAOImp();
			ArticleDAOImp article  = new ArticleDAOImp();
			List<article> articleList = article.queryAll();
			
			while ((line = br.readLine()) != null) {
				if(!"".equals(line)) {
					reply5 = new reply();
					String[] TextArry = line.split("@");
					if(!articleList.isEmpty()) {
					
			reply5.setArticle_id(Integer.valueOf(articleList.get(0).getArticle_id()));// 1
			reply5.setReply_user_id(userid);// 1
			reply5.setReply_content(String.valueOf(TextArry[2]));// 羽毛球發球
						
			Date date=	sdFormat.parse(TextArry[3]);
			reply5.setReply_time(date);// 發球是所有羽毛球
			reply5.setReply_like_count(Integer.valueOf(TextArry[4]));// 2021/1/04
			reply5.setReply_status(String.valueOf(TextArry[5]));// 02
						
						try {
							if (!"".equals(TextArry[6]) && TextArry[6] != null) {
								reply5.setLastreplytime(sdFormat.parse(TextArry[6]));// 2
							}else {
								reply5.setLastreplytime(null);
							}
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							reply5.setLastreplytime(null);
						}

						reply.insert(reply5); // ------>這個程式有錯誤
						
					}
				}
				
				}
				
			result = true;
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());
		}
		return result;
	}

}
