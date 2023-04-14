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
    // ���� ������ ȣ��
    System.out.println("[ session ] created / id : " + se.getSession().getId());
  }
 
  @Override
  public void sessionDestroyed(HttpSessionEvent se) {
    // ���� �Ҹ�� ȣ��
    System.out.println("[ session ] destroyed / id : " + se.getSession().getId());
  }
 
  @Override
  public void sessionIdChanged(HttpSessionEvent se, String oldSessionId) {
    // ����ID ����� ȣ��
    System.out.println("[ session ] changed / oldId : " + oldSessionId + " / newId : " + se.getSession().getId());
  }
 
  @Override
  public void attributeAdded(HttpSessionBindingEvent se) {
    // ������Ƽ �߰��� ȣ��
    System.out.println("[ session ] add / key : " + se.getName() + ", value : " + se.getValue());
  }
 
  @Override
  public void attributeRemoved(HttpSessionBindingEvent se) {
    // ������Ƽ ������ ȣ��
    System.out.println("[ session ] remove / key : " + se.getName());
  }
 
  @Override
  public void attributeReplaced(HttpSessionBindingEvent se) {
    // ������Ƽ �� ����� ȣ��
    System.out.println("[ session ] replace / key : " + se.getName() + ", value : " + se.getValue() + " --> " +  se.getSession().getAttribute(se.getName()));
    
    if (se.getName().equals("csrf")) {
      CopyOnWriteArrayList<Session> sessions = WebSocketServer.getClients();
      // ����� privilege ���� JSON ��ü�� ��ȯ
      JSONObject message = new JSONObject();
      message.put("type", "csrfChanged");
      message.put("csrf", se.getValue());
      
      // ��� ������ Ŭ���̾�Ʈ���� �޽��� ����
      for (Session session : sessions) {
        try {
          session.getBasicRemote().sendText(message.toString());
          System.out.println(session.getId() + "�� ���Ͽ� ����");
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  }
}