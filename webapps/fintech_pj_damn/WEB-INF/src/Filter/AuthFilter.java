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

        // ���� ���� ���� ����
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
            out.println("<script>alert('������ ���� �������Դϴ�.');history.go(-1);</script>");
            out.close();
            return;
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        // �α����� ����ڰ� ���������� �����ϴ� ���� ����
        HttpSession session = request.getSession();
        String privilege = request.getParameter("privilege");

        String level = null;
        if(session.getAttribute("level") != null){
            level = (String) session.getAttribute("level");
        }
        if(level == null || session.getAttribute("privilege")==null){
            return false;
        }

        //����� ���� ��� - �Ķ���� ����
        else if(level.equals("")){
            if(privilege!=null && privilege.equals("ADMIN")){
                return true;
            }
            return false;
        }
        //������ ���� ��� - ���� ����
        else{
            if(session.getAttribute("privilege").equals("ADMIN")){
                return true;
            }
            return false;
        }
    }

    @Override
    public void destroy() {
        // ���� ���� �� ������ �۾� ����
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // ���� �ʱ�ȭ �� ������ �۾� ����
    }
}