package fintech_pj_damn;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.gimpy.DropShadowGimpyRenderer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.NumbersAnswerProducer;

@WebServlet("/captcha")
public class captchaUtil extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doPost(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Captcha captcha = new Captcha.Builder(200, 60)
        .addText(new NumbersAnswerProducer(6))
        .addNoise()
        .addBackground(new GradiatedBackgroundProducer())
        .addBorder()
        .build();

        response.setHeader("Cache-Control", "no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");

        CaptchaServletUtil.writeImage(response, captcha.getImage());

        String captcha_answer = captcha.getAnswer();
        
        request.getSession().setAttribute("captcha", captcha_answer);
    }
}
