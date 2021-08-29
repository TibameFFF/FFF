package com.chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.chat.dao.FriendDAO;
import com.chat.daoImpl.FriendDAOImpl;
import com.chat.model.Friend;

import redis.clients.jedis.Jedis;

@WebServlet("/ShowAllFriendServlet")
public class ShowAllFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		FriendDAO dao = new FriendDAOImpl();
		List<Friend> friendList = dao.findByUserId(id);

		String notificationStr = "chat:notification:" + Integer.toString(id);
		Jedis jedis = new Jedis("localHost", 6379);

		for (Friend friend : friendList) {
			if (jedis.sismember(notificationStr, Integer.toString(friend.getFriend_id())))
				friend.setNotification(true);

			// 取得最後一條訊息
			String messageList = "chat:friend:" + id + ":" + friend.getFriend_id();
			String lastMessage = jedis.lindex(messageList, 0);
			if (lastMessage != null) {
				if (lastMessage.contains("<img "))
					friend.setLastMessage("圖片    ");
				else
					friend.setLastMessage(lastMessage.substring(lastMessage.indexOf("message") + 10,
							lastMessage.lastIndexOf("\",\"who\"")));
			} else {
				friend.setLastMessage("");
			}

		}

		jedis.close();

		String jsonStr = new JSONArray(friendList).toString();
		response.setContentType("text/html;charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().write(jsonStr);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
