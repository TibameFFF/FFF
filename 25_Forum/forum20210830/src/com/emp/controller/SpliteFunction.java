package com.emp.controller;


import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import com.forum.controller.ArticleDAOImp;
import com.forum.model.article;

public class SpliteFunction
{

	public static void main(String[] args)
	{
		try
		{
			// 3.1.1. Step 1 取要處理的匯入檔
			String path = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\article.txt";
			// 找到檔案
			FileInputStream fis = new FileInputStream(path);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(isr);

			String line = "";
			// 開始讀取txt文字檔
			article article1= null;
		ArticleDAOImp dvdsv = new ArticleDAOImp();
			while ((line = br.readLine()) != null)
			{
				
				article1 = new article();
				String[] TextArry = line.split("@");
				System.out.println(TextArry[0]);
				article1.setArticle_id(Integer.valueOf(TextArry[0]));
//				System.out.println("TextArry===" + TextArry[0]);
//				System.out.println("TextArry===" + TextArry[1]);
//				System.out.println("TextArry===" + TextArry[2]);
//				System.out.println("TextArry===" + TextArry[3]);
//				System.out.println("TextArry===" + TextArry[4]);
//				System.out.println("TextArry===" + TextArry[5]);
//				System.out.println("TextArry===" + TextArry[6]);
//				System.out.println("TextArry===" + TextArry[7]);
				dvdsv.insert(article1);
			}
		} catch (Exception e)
		{
			e.getStackTrace();
		}

	}

}
