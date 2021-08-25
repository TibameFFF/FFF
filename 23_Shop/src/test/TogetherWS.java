package test;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

//註冊Server端點
@ServerEndpoint("/TogetherWS")
public class TogetherWS {
	//多執行續環境須同步處理
	//此集合代表的就是有連接websocket的所有client
	private static final Set<Session> connectedSessions = Collections.synchronizedSet(new HashSet<>());

	
	// 方法名為OnXXX也就是事件驅動執行(當XXX的時候)
	@OnOpen //當client和server建立連線時執行一次，如同Servlet的init()
	public void onOpen(Session userSession) throws IOException {
		connectedSessions.add(userSession);//每個client建立連線後都會有自己的session物件，把每個session物件暫存起來
		
		//把資料印出來看看~
		String text = String.format("Session ID = %s, connected", userSession.getId());
		System.out.println(text);
	}

	@OnMessage //如同Servlet的service()，當server接收到資料時就會執行
	public void onMessage(Session userSession, String message) {
					//session: 收到哪個使用者傳遞的資訊; message:傳了什麼訊息過來
		
		//收到訊息後對所有目前在線上的使用發出訊息
		for (Session session : connectedSessions) {
			if (session.isOpen()) //確認使用者是不是還在線上
				session.getAsyncRemote().sendText(message);
			//getAsyncRemote->以非同步方式傳送訊
		}
		
		//印出訊息看看~
		System.out.println("Message received: " + message);
	}

	@OnClose //如同Servlet的destroy()，當連線關閉前會執行一次
	public void onClose(Session userSession, CloseReason reason) {
						//session:哪個使用者關閉了連線; reason:連線關閉的原因
		
		connectedSessions.remove(userSession);//把關閉連線的使用者從清單中刪除
		
		//把訊息印出來看看~
		String text = String.format("session ID = %s, disconnected; close code = %d; reason phrase = %s",
				userSession.getId(), reason.getCloseCode().getCode(), reason.getReasonPhrase());
		System.out.println(text);
	}

	@OnError //當發生例外時，此方法會被呼叫執行
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

}
