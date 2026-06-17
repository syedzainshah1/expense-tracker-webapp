package web;

import dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String email =
                req.getParameter("email");

        String password =
                req.getParameter("password");

        UserDao dao =
                new UserDao();

        User user =
                dao.login(email, password);

        if(user != null){

            HttpSession session =
                    req.getSession();

            session.setAttribute(
                    "user",
                    user);

            resp.sendRedirect("user-dashboard");

        }else{

            resp.sendRedirect(
                    req.getContextPath()
                            + "/index.jsp");
        }
    }
}