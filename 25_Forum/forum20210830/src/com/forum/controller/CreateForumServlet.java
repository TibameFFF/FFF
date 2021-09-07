package com.forum.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.ArticleDAOImp;
import com.forum.model.InfoVO;
import com.forum.model.article;


@WebServlet("/CreateForumServlet")
@MultipartConfig
public class CreateForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateForumServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		
		HttpSession session = request.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
		
		//��r
		article aa = new article();
		aa.setArticle_content(text);
		aa.setArticle_num_count(0);
		aa.setArticle_time(new Date());
		aa.setTitle(title);
		aa.setUser_id(member.getUser_id());
		aa.setArticle_type_num(3);
		aa.setPageviews(1);
		aa.setArticle_status("xxx");
		ArticleDAOImp articleDAO = new ArticleDAOImp();
		articleDAO.insert(aa);
		
		List<article> articles = articleDAO.getAll();
		int id = articles.get(articles.size()-1).getArticle_id();
		aa.setArticle_id(id);
		
		//�Ϥ�
//		Part part = request.getPart("picture");
//		System.out.println(part.getSize());
//		
//		InputStream is = part.getInputStream();
//		byte[] buffer = new byte[is.available()];
//		is.read(buffer);
//		article_picture pic = new article_picture();
//		pic.setPictires(buffer);
//		pic.setArticle_id(id);
//		Article_PictureDAOImp picDao = new Article_PictureDAOImp();
//		picDao.insert(pic);
//		System.out.println(buffer.length);
		
		request.setAttribute("article", aa);
	

		RequestDispatcher dispatcher = request.getRequestDispatcher("/forum/navs_content.jsp");
		dispatcher.forward(request, response);
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
