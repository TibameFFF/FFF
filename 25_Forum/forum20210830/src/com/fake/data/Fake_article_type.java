package com.fake.data;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import com.forum.DAOImp.Article_TypeDAOImp;
import com.forum.model.article_type;

public class Fake_article_type {

	public boolean importArticleType(String filePath) {

		boolean result = false;
		try {

//		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = filePath+"article_type.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);

			String line = "";
			// 開始讀取txt文字檔
			article_type article_type4 = null;
			List<article_type> article_typeList = new ArrayList<>();
			Article_TypeDAOImp article_type = new Article_TypeDAOImp();

			while ((line = br.readLine()) != null) {
				if(!"".equals(line)) {
					article_type4 = new article_type();
					String[] TextArry = line.split("@");
					if(!article_typeList.isEmpty()) {
					
					article_type4.setArticle_type_num(Integer.valueOf(TextArry[0]));// 1
					article_type4.setArticle_type_name(String.valueOf(TextArry[1]));// 1

					article_type.insert(article_type4); 
				}
				
				}
			}
			result=true;
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());

		}
		return result;
	}
}
