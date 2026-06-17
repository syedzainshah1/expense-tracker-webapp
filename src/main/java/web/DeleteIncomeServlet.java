package web;

import dao.IncomeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteIncome")
public class DeleteIncomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter("id"));

        IncomeDao dao = new IncomeDao();

        dao.deleteIncome(id);

        response.sendRedirect("dashboard.jsp");
    }
}