package web;

import dao.ExpenseDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteExpense")
public class DeleteExpenseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(req.getParameter("id"));

        ExpenseDao dao = new ExpenseDao();

        dao.deleteExpense(id);

        resp.sendRedirect("dashboard.jsp");
    }
}