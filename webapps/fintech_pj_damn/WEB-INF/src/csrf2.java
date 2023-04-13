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
import com.octo.captcha.module.servlet.image.SimpleImageCaptchaServlet;

@WebServlet("/csrf2")
public class csrf2 extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");
        String cuuid = request.getParameter("csrfToken");

        csrfVo cv = new csrfVo();
        String suuid = cv.getUuid();

        UserPostDao dao = new UserPostDao();

        if(session.getAttribute("privilege").equals("ADMIN") && cuuid.equals(suuid)){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('당했지? 이자식아');</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자가 아닙니다.'); history.back();</script>");
            w.flush();
            w.close();
        }
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String id = request.getParameter("id");
        String priv = request.getParameter("privilege");
        String cuuid = request.getParameter("csrfToken");

        String userCaptchaResponse = request.getParameter("jcaptcha");
        boolean captchaPassed = SimpleImageCaptchaServlet.validateResponse(request, userCaptchaResponse);
        if(captchaPassed){
        // proceed to submit action
        }else{
        // return error to user
        }


        UserPostDao dao = new UserPostDao();

        if(session.getAttribute("privilege").equals("ADMIN")){
            try {
                dao.setPriv(id, priv);

                response.setContentType("text/html; charset=euc-kr");
                PrintWriter w = response.getWriter();
                w.write("<script>alert('당했지? 이자식아');</script>");
                w.flush();
                w.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }else{
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('관리자가 아닙니다.'); history.back();</script>");
            w.flush();
            w.close();
        }
        
	}
}