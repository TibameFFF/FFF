package com.forum.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.DAOImp.ReplyDAOImp;
import com.forum.model.article;
import com.forum.model.reply;

public class ShowArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		InputStream is = null;
		OutputStream os = null;
		try {
			HttpSession session = req.getSession();

			req.setCharacterEncoding("UTF-8");

			// step one 讀取前端值
			String arttext = req.getParameter("article_id");
			// setp two String轉型int 值
			Integer article_id = Integer.valueOf(arttext);
			// step three 值放入物件
			article article = new article();
			article.setArticle_id(article_id);
			// step four DAOImp get方法
			ArticleDAOImp articleDAOImp = new ArticleDAOImp();
			List<article> articleList = articleDAOImp.queryByArticleWhereArticle_Id(article);

			// step four -one 抓留言
			List<reply> replyList = null;
			if (!articleList.isEmpty()) {
				reply re = new reply();
				re.setArticle_id(articleList.get(0).getArticle_id());
				ReplyDAOImp replyDao = new ReplyDAOImp();
				replyList = replyDao.queryByReply1(re);
			}

			// step four -one 去article_picture 撈圖片
//			Article_PictureDAOImp pictureDao = new Article_PictureDAOImp();
//			Blob pictureBlob = null;
//
//			if (!articleList.isEmpty()) {
//				picture.setArticle_id(articleList.get(0).getArticle_id());
//				pictureBlob = pictureDao.queryByarticle_pictureImage(picture);
//				if (pictureBlob != null) {
//					is = pictureBlob.getBinaryStream();
//				}
//			}
//			os = res.getOutputStream();

//			int len = 0;
//			byte[] bytes = new byte[8192];
//			while ((len = is.read(bytes)) != -1) {
//				os.write(bytes, 0, len);
//			}
			// step five 識別字串
			HttpSession session1 = req.getSession();
			session1.setAttribute("articleList", articleList);
			
			HttpSession session2 = req.getSession();
			session2.setAttribute("replyList", replyList);
			
			
			// step six 導向哪一個頁面
			String url = "/forum/navs_content.jsp";// 連接前端
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		finally {
//			if (is != null)
//				is.close();
//			if (os != null)
//				os.close();

//		}
	}
}
