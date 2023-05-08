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

@WebServlet("/csrf3")
public class csrf3 extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");
        String confirm = request.getParameter("confirm");

        UserPostDao dao = new UserPostDao();

        if(id.equals("admin")){
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자는 못바꿈'); history.back();</script>");
            w.flush();
            w.close();
        }
        else if(session.getAttribute("privilege").equals("ADMIN") && confirm.equals("Y")){
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
            if(!session.getAttribute("privilege").equals("ADMIN")){
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('관리자가 아닙니다.'); history.back();</script>");
                w.flush();
                w.close();
            }else{
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('confirm창을 통해 요청하세요'); history.back();</script>");
                w.flush();
                w.close();
            }
        }
        
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");

        String referer = request.getHeader("referer");
        String WhiteURL="/fintech_pj_damn/csrf.jsp";

        System.out.println(referer);
        
        UserPostDao dao = new UserPostDao();
        if(id.equals("admin")){
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자는 못바꿈'); history.back();</script>");
            w.flush();
            w.close();
        }
        else if(session.getAttribute("privilege").equals("ADMIN") && referer.contains(WhiteURL)){
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
            if(!session.getAttribute("privilege").equals("ADMIN")){
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('관리자가 아닙니다.'); history.back();</script>");
                w.flush();
                w.close();
            }else{
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('해당 기능이 있는 페이지에서 요청을 보내세요.'); history.back();</script>");
                w.flush();
                w.close();
            }
        }
	}
}