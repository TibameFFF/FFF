package com.chat.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import redis.clients.jedis.Jedis;

@WebServlet("/DeleteNotificationServlet")
public class DeleteNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String myID=request.getParameter("myID");
		String friendId=request.getParameter("friendId");
		
		//紀錄未讀訊息
		Jedis jedis = new Jedis("localhost", 6379);
		String saveNotif="chat:notification:"+myID;
		jedis.srem(saveNotif, friendId);
		jedis.close();
		
		response.setContentType("text/html;charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().write("刪除Notification成功!");
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
