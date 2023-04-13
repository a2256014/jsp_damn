package fintech_pj_damn;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/csrf")
public class csrf extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");

        UserPostDao dao = new UserPostDao();

        if(session.getAttribute("privilege").equals("ADMIN")){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('������? ���ڽľ�');</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('�����ڰ� �ƴմϴ�.'); history.back();</script>");
                w.flush();
                w.close();
        }
        
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");

        UserPostDao dao = new UserPostDao();

        if(session.getAttribute("privilege").equals("ADMIN")){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('������? ���ڽľ�');</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('�����ڰ� �ƴմϴ�.'); history.back();</script>");
                w.flush();
                w.close();
        }
        
	}
}