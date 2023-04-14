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


@WebServlet("/csrf2")
public class csrf2 extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String suuid = (String) session.getAttribute("csrfToken");
        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");
        String cuuid = request.getParameter("csrfToken");

        UserPostDao dao = new UserPostDao();

        if(id.equals("admin")){
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자는 못바꿈'); history.back();</script>");
            w.flush();
            w.close();
        }
        else if(session.getAttribute("privilege").equals("ADMIN") && cuuid.equals(suuid)){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('당했지? 이자식아'); history.back();</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자 or 다른페이지 요청'); history.back();</script>");
            w.flush();
            w.close();
        }
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String sca = (String) session.getAttribute("captcha");

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");
        String cca = request.getParameter("captcha");

        UserPostDao dao = new UserPostDao();

        if(id.equals("admin")){
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자는 못바꿈'); history.back();</script>");
            w.flush();
            w.close();
        }
        else if(session.getAttribute("privilege").equals("ADMIN") && sca.equals(cca)){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('당했지? 이자식아'); history.back();</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자 or 캡차 안함'); history.back();</script>");
            w.flush();
            w.close();
        }
        
	}
}