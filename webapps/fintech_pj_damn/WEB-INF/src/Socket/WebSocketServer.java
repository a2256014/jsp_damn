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

    // ������ Ŭ���̾�Ʈ���� WebSocketSession�� ������ ����Ʈ
    public static final CopyOnWriteArrayList<Session> clients = new CopyOnWriteArrayList<>();

    public static CopyOnWriteArrayList<Session> getClients(){
        return clients;
    }
    // Ŭ���̾�Ʈ�� WebSocket���� ������ �� ȣ��Ǵ� �޼���
    @OnOpen
    public void onOpen(Session session) {
        clients.add(session); // Ŭ���̾�Ʈ ������ ����Ʈ�� �߰�
    }

    // Ŭ���̾�Ʈ�� WebSocket�� ���� �޽����� ���� �� ȣ��Ǵ� �޼���
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("WebSocket message received: " + message);
        for (Session client : clients) {
            client.getBasicRemote().sendText(message); // ��� Ŭ���̾�Ʈ���� �޽��� ����
        }
    }

    // Ŭ���̾�Ʈ�� WebSocket ������ ���� �� ȣ��Ǵ� �޼���
    @OnClose
    public void onClose(Session session) {
        clients.remove(session); // Ŭ���̾�Ʈ ������ ����Ʈ���� ����
    }

    // ���� �߻��� ȣ��Ǵ� �޼���
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket error: " + throwable.getMessage());
    }
}
