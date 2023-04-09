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

@WebServlet("/login2")
public class LoginHandler2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_ATTEMPTS = 3;
	private static final int LOCK_DURATION = 10; 
	private Map<String, Integer> loginAttempts = new HashMap<>(); 
  	private Map<String, Date> lockoutTime = new HashMap<>();
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserGetDao2 dao = new UserGetDao2();
		UserVo dvo = null;

		String n=new String(request.getParameter("userid").getBytes("8859_1"), "EUC-KR");   
		String p=request.getParameter("userpass"); 

		String ipAddress = request.getRemoteAddr();
		Integer attempts = (Integer) session.getAttribute("attempts");
		if(attempts == null) session.setAttribute("attempts", 0);
		if (attempts != null) {
			loginAttempts.put(ipAddress, attempts);
		}

		try {
			dvo = dao.getUser(n,p);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		Iterator<Map.Entry<String, Date>> it = lockoutTime.entrySet().iterator();
		Date lockoutStart = null;
		long lockoutDurationMillis = 0;
		if (lockoutTime.containsKey(ipAddress)) {
			lockoutStart = lockoutTime.get(ipAddress);
			lockoutDurationMillis = LOCK_DURATION * 60 * 1000;
			if ((new Date().getTime() - lockoutStart.getTime()) >= lockoutDurationMillis){
				lockoutTime.remove(ipAddress);
				loginAttempts.remove(ipAddress);
				session.setAttribute("attempts", 0);
				session.setAttribute("unlock", "true");
				session.removeAttribute("locked");
			}
		}
		System.out.println("try login : "  + ipAddress);
		if(dvo != null && !lockoutTime.containsKey(ipAddress)){
			session.setAttribute("userId", dvo.getId());
			session.setAttribute("attempts", 0);
			session.setAttribute("unlock", "true");
			session.removeAttribute("locked");
			loginAttempts.remove(ipAddress);
      		lockoutTime.remove(ipAddress);

			session.setMaxInactiveInterval(60*100);
			response.sendRedirect("/fintech_pj_damn");
		}
		else{
			if (loginAttempts.containsKey(ipAddress)) {
				loginAttempts.put(ipAddress, loginAttempts.get(ipAddress) + 1);
			} else {
				loginAttempts.put(ipAddress, 1);
			}
			session.setAttribute("attempts", loginAttempts.get(ipAddress));

			if (loginAttempts.containsKey(ipAddress) && loginAttempts.get(ipAddress) >= MAX_ATTEMPTS && !lockoutTime.containsKey(ipAddress)) {
				lockoutTime.put(ipAddress, new Date());
				session.setAttribute("unlock", "false");
			}
			System.out.print("Sorry userId or password error\n");
			if(lockoutTime.containsKey(ipAddress)){
				session.setAttribute("locked", (lockoutDurationMillis - (new Date().getTime() - lockoutTime.get(ipAddress).getTime()))/60000);
			}
			response.sendRedirect("./login.jsp");
		}

		System.out.print("count : " + loginAttempts.get(ipAddress) + "\n"); 
		System.out.print("restTime : ");
		if(lockoutStart != null){
			System.out.print((lockoutDurationMillis - (new Date().getTime() - lockoutStart.getTime()))/60000);
		}
		System.out.print("\n");
	}
}