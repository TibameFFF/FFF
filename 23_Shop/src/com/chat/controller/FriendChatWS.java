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

import com.chat.model.FriendMessageBean;

import redis.clients.jedis.Jedis;

//註冊Server端點
@ServerEndpoint("/FriendChatWS/{userId}")
public class FriendChatWS {
	//多執行續環境須同步處理
	//此集合代表的就是有連接websocket的所有client
	private static Map<Session, List<Integer>> sessionsMap = new ConcurrentHashMap<>();
	
	@OnOpen //當client和server建立連線時執行一次，如同Servlet的init()
	public void onOpen(@PathParam("userId") String userId, Session userSession) throws IOException {
		userSession.setMaxTextMessageBufferSize(5242880);//圖片太大，所以要設定可以傳入的訊息多大
		
		List<Integer> currentChatPerson = new ArrayList<Integer>();
		currentChatPerson.add(Integer.parseInt(userId));
		currentChatPerson.add(0);
		sessionsMap.put(userSession, currentChatPerson );
		
		//把資料印出來看看~
		System.out.println("userID = " +userId+", user=" + userSession.getId() + "join");
		System.out.println("online count:"+sessionsMap.size());
	}

	@OnMessage //如同Servlet的service()，當server接收到資料時就會執行
	public void onMessage(Session userSession, String message) {
		JSONObject jsonObject = new JSONObject(message);
		String type =jsonObject.getString("type");
		
		//轉換好友連天室視窗
		if("change".equals(type)) {
			int friendId = jsonObject.getInt("friendId");
			int userid = jsonObject.getInt("userid");
			
			List<Integer> updateList = new ArrayList<Integer>();
			updateList.add(userid);
			updateList.add(friendId);
			
			for(Session session: sessionsMap.keySet()) {
				if(session.equals(userSession)) {
					sessionsMap.put(session, updateList);
					
					System.out.println(sessionsMap.get(session));
					break;
				}
				
			}
			
			return;
			
		}
		
		
		if("message".equals(type)) {
			//取得傳送來的資訊
			int friendId = jsonObject.getInt("friendId");
			int id = jsonObject.getInt("id");
			String myName =jsonObject.getString("myName");
			String inputMessage = jsonObject.getString("message");
			
			//日期轉換
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd HH:mm");
			
			//將訊息存到Redis
			
			//存自己
			FriendMessageBean bean = new FriendMessageBean();
			bean.setDate(simpleDateFormat.format(new Date()));
			bean.setMessage(inputMessage);
			bean.setFriendName(Integer.toString(friendId));//之後改成名字!
			bean.setWho(0);
			String saveForSelf = new JSONObject(bean).toString();
			Jedis jedis = new Jedis("localhost", 6379);
			String myMessageID = "chat:friend:"+id+":"+friendId;
			jedis.lpush(myMessageID, saveForSelf);
			
			//存別人
			bean.setFriendName(Integer.toString(id)); //之後改成名字!
			bean.setWho(1);
			String saveForOther = new JSONObject(bean).toString();
			String friendMessageID = "chat:friend:"+friendId+":"+id;
			jedis.lpush(friendMessageID, saveForOther);
			
			jedis.close();
			
//			傳送給朋友
			for(Session session: sessionsMap.keySet()) {
				if(sessionsMap.get(session).get(0) == friendId && sessionsMap.get(session).get(1) == id) {
					session.getAsyncRemote().sendText(message);
					return;
				}else if(sessionsMap.get(session).get(0) == friendId && sessionsMap.get(session).get(1) != id) {
					session.getAsyncRemote().sendText("{\"type\":\"notiifcation\", \"id\": \""+id+"\", \"message\":\""+inputMessage+"\"}");
					//紀錄未讀訊息
					Jedis jedis2 = new Jedis("localhost", 6379);
					String saveNotif="chat:notification:"+friendId;
					jedis2.sadd(saveNotif, Integer.toString(id));
					jedis2.close();
				} else {
					//紀錄未讀訊息
					Jedis jedis3 = new Jedis("localhost", 6379);
					String saveNotif="chat:notification:"+friendId;
					jedis3.sadd(saveNotif, Integer.toString(id));
					jedis3.close();
					
					
				}
			}
			
			
			
			return;
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
