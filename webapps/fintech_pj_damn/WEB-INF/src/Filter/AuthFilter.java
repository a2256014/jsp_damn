package fintech_pj_damn;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/admin/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 권한 검증 로직 구현
        String requestURI = httpRequest.getRequestURI();
        String jspPath = requestURI.substring("/fintech_pj_damn/admin/".length());
        Boolean isAuth = false;

        if(httpRequest.getSession().getAttribute("Auth") != null){
            isAuth = (Boolean)httpRequest.getSession().getAttribute("Auth");
        }
        if (isAdmin(httpRequest) || isAuth) {
            httpRequest.getSession().setAttribute("Auth", true);
            RequestDispatcher dispatcher = httpRequest.getRequestDispatcher("/admin/" + jspPath);
            dispatcher.forward(httpRequest, httpResponse);
        } else {
            httpResponse.setContentType("text/html;charset=EUC-KR");
            PrintWriter out = httpResponse.getWriter();
            out.println("<script>alert('권한이 없는 페이지입니다.');history.go(-1);</script>");
            out.close();
            return;
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        // 로그인한 사용자가 관리자인지 검증하는 로직 구현
        HttpSession session = request.getSession();
        String privilege = request.getParameter("privilege");

        String level = null;
        if(session.getAttribute("level") != null){
            level = (String) session.getAttribute("level");
        }
        if(level == null || session.getAttribute("privilege")==null){
            return false;
        }

        //취약한 인증 방법 - 파라미터 검증
        else if(level.equals("")){
            if(privilege!=null && privilege.equals("ADMIN")){
                return true;
            }
            return false;
        }
        //안전한 인증 방법 - 세션 검증
        else{
            if(session.getAttribute("privilege").equals("ADMIN")){
                return true;
            }
            return false;
        }
    }

    @Override
    public void destroy() {
        // 필터 종료 시 수행할 작업 구현
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 시 수행할 작업 구현
    }
}