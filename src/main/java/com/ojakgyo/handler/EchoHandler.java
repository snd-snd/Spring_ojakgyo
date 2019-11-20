package com.ojakgyo.handler;



import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class EchoHandler extends TextWebSocketHandler{
	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	//클라이언트가  접속을 하여 session이 생성되면 sessionList에 session을 추가해줌.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);		
		logger.info("{} 연결됨 ", session.getId());
	}
	//클라이언트가 메세지를 보내면 연결된 모든 session에게 메세지를 보냄	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
				String senderId=session.getId();
			for (WebSocketSession sess : sessionList) {		
				sess.sendMessage(new TextMessage(message.getPayload()));
		}
	}
	//클라이언트와 접속이 끊기면 해당 session연결을 끊어버림
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		sessionList.remove(session);
		
		logger.info("{} 연결 끊김).",session.getId());		
	}
	

}
