package fintech_pj_damn;

import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.OnMessage;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.CopyOnWriteArrayList;

@ServerEndpoint("/websocket")
public class WebSocketServer {

    // 접속한 클라이언트들의 WebSocketSession을 저장할 리스트
    public static final CopyOnWriteArrayList<Session> clients = new CopyOnWriteArrayList<>();

    public static CopyOnWriteArrayList<Session> getClients(){
        return clients;
    }
    // 클라이언트가 WebSocket으로 접속할 때 호출되는 메서드
    @OnOpen
    public void onOpen(Session session) {
        clients.add(session); // 클라이언트 세션을 리스트에 추가
    }

    // 클라이언트가 WebSocket을 통해 메시지를 보낼 때 호출되는 메서드
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("WebSocket message received: " + message);
        for (Session client : clients) {
            client.getBasicRemote().sendText(message); // 모든 클라이언트에게 메시지 전송
        }
    }

    // 클라이언트가 WebSocket 접속을 끊을 때 호출되는 메서드
    @OnClose
    public void onClose(Session session) {
        clients.remove(session); // 클라이언트 세션을 리스트에서 삭제
    }

    // 에러 발생시 호출되는 메서드
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket error: " + throwable.getMessage());
    }
}
