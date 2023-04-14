package fintech_pj_damn;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionIdListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.websocket.Session;
import java.util.concurrent.CopyOnWriteArrayList;
import org.json.JSONObject;

@WebListener
public class SessionListener implements HttpSessionListener, HttpSessionIdListener, HttpSessionAttributeListener {
   
  @Override
  public void sessionCreated(HttpSessionEvent se) {
    // 세션 생성시 호출
    System.out.println("[ session ] created / id : " + se.getSession().getId());
  }
 
  @Override
  public void sessionDestroyed(HttpSessionEvent se) {
    // 세션 소멸시 호출
    System.out.println("[ session ] destroyed / id : " + se.getSession().getId());
  }
 
  @Override
  public void sessionIdChanged(HttpSessionEvent se, String oldSessionId) {
    // 세션ID 변경시 호출
    System.out.println("[ session ] changed / oldId : " + oldSessionId + " / newId : " + se.getSession().getId());
  }
 
  @Override
  public void attributeAdded(HttpSessionBindingEvent se) {
    // 프라퍼티 추가시 호출
    System.out.println("[ session ] add / key : " + se.getName() + ", value : " + se.getValue());
  }
 
  @Override
  public void attributeRemoved(HttpSessionBindingEvent se) {
    // 프라퍼티 삭제시 호출
    System.out.println("[ session ] remove / key : " + se.getName());
  }
 
  @Override
  public void attributeReplaced(HttpSessionBindingEvent se) {
    // 프라퍼티 값 변경시 호출
    System.out.println("[ session ] replace / key : " + se.getName() + ", value : " + se.getValue() + " --> " +  se.getSession().getAttribute(se.getName()));
    
    if (se.getName().equals("csrf")) {
      CopyOnWriteArrayList<Session> sessions = WebSocketServer.getClients();
      // 변경된 privilege 값을 JSON 객체로 변환
      JSONObject message = new JSONObject();
      message.put("type", "csrfChanged");
      message.put("csrf", se.getValue());
      
      // 모든 웹소켓 클라이언트에게 메시지 전송
      for (Session session : sessions) {
        try {
          session.getBasicRemote().sendText(message.toString());
          System.out.println(session.getId() + "번 소켓에 보냄");
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }
}