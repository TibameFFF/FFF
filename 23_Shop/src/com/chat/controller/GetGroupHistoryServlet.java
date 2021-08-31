package com.chat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.model.GroupMessageBean;

import redis.clients.jedis.Jedis;

@WebServlet("/GetGroupHistoryServlet")
public class GetGroupHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String groupID = request.getParameter("History");
	
		Jedis jedis = new Jedis("localHost", 6379);
		
		String takeID = "chat:group:"+groupID;
		//取最後10比對話紀錄
		List<String> messageList = jedis.lrange(takeID, 0, 10);
		
//		List<GroupMessageBean> beanList = new ArrayList<GroupMessageBean>();
//		for(String message:messageList) {
//			
//			
//		}
		jedis.close();
		response.setContentType("text/html;charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().write(messageList.toString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
