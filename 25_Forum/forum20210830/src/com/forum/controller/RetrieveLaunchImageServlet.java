package com.forum.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.forum.DAOImp.Article_PictureDAOImp;
import com.forum.model.article_picture;

public class RetrieveLaunchImageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		OutputStream os = null;
		InputStream is = null;
		Blob picBlob = null;
		try {
			// 讀取瀏覽器傳送來的主鍵
			String article_id = request.getParameter("article_id");
			// 讀取瀏覽器傳送來的type，以分辨要處理哪個表格

			article_picture pic = new article_picture();
			pic.setArticle_id(Integer.valueOf(article_id));

			Article_PictureDAOImp picDao = new Article_PictureDAOImp();
			picBlob = picDao.queryByarticle_pictureImage(pic);
			if (picBlob != null) {
				is = picBlob.getBinaryStream();
			} else {
				String path1 = "C:\\Users\\Tibame_T14\\Documents\\FFF\\25_Forum\\forum20210830\\WebContent\\forum\\images\\FUNNY.jpg";
				File file = new File(path1);
				is = new FileInputStream(file);
			}

			os = response.getOutputStream();
			int len = 0;
			byte[] bytes = new byte[8192];
			while ((len = is.read(bytes)) != -1) {
				os.write(bytes, 0, len);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			if (is != null)
				is.close();
			if (os != null)
				os.close();

		}

	}
}
