package com.forum.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.DAOImp.Article_PictureDAOImp;
import com.forum.model.article;
import com.forum.model.article_picture;

/*
 * 本程式在後端執行，它會
 * (1) 讀取使用者由前端網頁輸入資料，
 * (2) 進行必要的資料轉換，
 * (3) 檢查使用者輸入資料，
 * (4) 呼叫Business Service元件，進行Business Logic運算，
 * (5) 依照Business Logic運算結果來送回適當的畫面給前端的使用者。
 * 
 */
//@MultipartConfig(location = "D:\\程式片段", fileSizeThreshold = 5 * 1024 * 1024, maxFileSize = 1024 * 1024
//		* 500, maxRequestSize = 1024 * 1024 * 500 * 5)

@MultipartConfig
@WebServlet("/forum/Launch_activityServlet")
public class Launch_activityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			request.setCharacterEncoding("UTF-8");
			String insertTitleStr = request.getParameter("insertTitleStr");
			String insertContextStr = request.getParameter("insertContextStr");
			String articleType = request.getParameter("articleType");
//
//

			article art = new article();
			art.setUser_id(1);// 這是要放登入的 //user_id int(11)
			art.setArticle_type_num(Integer.valueOf(articleType)); // article_type_num int(11)
			art.setTitle(insertTitleStr); // title varchar(255)
			art.setArticle_content(insertContextStr); // article_content varchar(255)
			art.setArticle_time(new Date()); // article_time datetime
			art.setArticle_status("正常"); // article_status varcha
			art.setPageviews(0); // pageviews int(11)
			art.setArticle_num_count(0); // article_num_count int(11)
			ArticleDAOImp artDao = new ArticleDAOImp();
			artDao.insert(art);

			long sizeInBytes = 0;
			InputStream is = null;
			Part articleimageStr = request.getPart("articleimageStr");

			String fileName = articleimageStr.getSubmittedFileName();

			is = articleimageStr.getInputStream();

			Blob articleimage = null;
			if (is != null) {
				try {
					articleimage = GlobalService.fileToBlob(is, sizeInBytes);
				} catch (SQLException e) {

					e.printStackTrace();
				}
				article_picture pic = new article_picture();
				pic.setArticle_id(550);
				pic.setImage(articleimage);
				Article_PictureDAOImp picDao = new Article_PictureDAOImp();
				picDao.insertReal(pic);
			}
			response.sendRedirect(getServletContext().getContextPath() + "/forum/index.jsp");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
