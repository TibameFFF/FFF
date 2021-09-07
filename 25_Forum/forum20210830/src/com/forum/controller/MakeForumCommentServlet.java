package com.forum.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forum.DAOImp.ReplyDAOImp;
import com.forum.model.InfoVO;
import com.forum.model.reply;

@WebServlet("/MakeForumCommentServlet")
public class MakeForumCommentServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String content = request.getParameter("reply");
		int id = Integer.parseInt(request.getParameter("article_id"));
		HttpSession session = request.getSession();
		InfoVO member = (InfoVO)session.getAttribute("infoVO");
//		System.out.println(request.getParameter("id"));
//		System.out.println(request.getParameter("article_id"));
		reply re = new reply();
		re.setArticle_id(id);
		re.setLastreplytime(new Date());
		re.setReply_content(content);
		re.setReply_like_count(0);
		re.setReply_status("zzz");
		re.setReply_time(new Date());
		re.setReply_user_id(member.getUser_id());
		ReplyDAOImp dao = new ReplyDAOImp();
		dao.insert(re);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ShowForumServlet?id="+id);
		dispatcher.forward(request, response);
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
