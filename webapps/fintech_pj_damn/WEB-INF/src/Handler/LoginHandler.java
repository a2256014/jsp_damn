package fintech_pj_damn;

import java.io.IOException;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

@WebServlet("/login")
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserGetDao dao = new UserGetDao();
		UserVo dvo = null;

		String n=new String(request.getParameter("userid").getBytes("8859_1"), "EUC-KR");  
		String p=request.getParameter("userpass"); 
		
		try {
			dvo = dao.getUser(n,p);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(dvo);

		if(dvo != null){
			HttpSession session =  request.getSession();
			session.setAttribute("userId", dvo.getId());
			session.setAttribute("privilege", dvo.getPrivilege());
			session.setAttribute("csrf", 0);
			Cookie cookie = new Cookie("XSS", "XSSTESTING");

    		// 쿠키를 응답 헤더에 추가
    		response.addCookie(cookie);
			response.sendRedirect("/fintech_pj_damn");
		}
		else{
			System.out.print("Sorry userId or password error");  
			response.sendRedirect("login.jsp");
		}
		
	}
}