package com.chat.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

import com.chat.model.GroupMessageBean;
import com.sun.org.apache.bcel.internal.generic.NEW;

import redis.clients.jedis.Jedis;

//註冊Server端點
@ServerEndpoint("/GroupChatWS/{group}")
public class GroupChatWS {
	//多執行續環境須同步處理
	//此集合代表的就是有連接websocket的所有client
	private static Map<Session, Integer> sessionsMap = new ConcurrentHashMap<>();
	
	@OnOpen //當client和server建立連線時執行一次，如同Servlet的init()
	public void onOpen(@PathParam("group") String group, Session userSession) throws IOException {
		userSession.setMaxTextMessageBufferSize(5242880);//圖片太大，所以要設定可以傳入的訊息多大
		
		sessionsMap.put(userSession, Integer.parseInt(group));
		//把資料印出來看看~
		
		System.out.println("group = " +group+", user=" + userSession.getId() + "join");
		System.out.println("online count:"+sessionsMap.size());
	}

	@OnMessage //如同Servlet的service()，當server接收到資料時就會執行
	public void onMessage(Session userSession, String message) {
	
		//取得傳送來的資訊
		JSONObject jsonObject = new JSONObject(message);
		int groupNum = jsonObject.getInt("group");
		int id = jsonObject.getInt("id");
		String userName =jsonObject.getString("userName");
		String inputMessage = jsonObject.getString("message");
		System.out.println(inputMessage);
		//日期轉換
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd HH:mm");
		
		
		//將訊息存到Redis
		GroupMessageBean bean = new GroupMessageBean();
		bean.setDate(simpleDateFormat.format(new Date()));
		bean.setMessage(inputMessage);
		bean.setUserName(userName);
		bean.setId(id);
		String jsonStr = new JSONObject(bean).toString();
		Jedis jedis = new Jedis("localhost", 6379);
		String groupID = "chat:group:"+groupNum;
		jedis.lpush(groupID, jsonStr);
		
		jedis.close();
		
		//傳送給同個group但是不是自己的人
		for(Session session: sessionsMap.keySet()) {
			if(sessionsMap.get(session) == groupNum && session.isOpen() && !session.equals(userSession))
				session.getAsyncRemote().sendText(message);
			
		}
		
	}

	@OnClose //如同Servlet的destroy()，當連線關閉前會執行一次
	public void onClose(Session userSession, CloseReason reason) {
		
		//移除使用者
		for(Session session:sessionsMap.keySet()) {
			if(session.equals(userSession)) {
				sessionsMap.remove(session);
			}
		}
		System.out.println("online count:"+sessionsMap.size());
	}

	@OnError //當發生例外時，此方法會被呼叫執行
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

}
