package web;

import dao.ExpenseDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Expense;
import model.User;

import java.io.IOException;

@WebServlet("/addExpense")
public class ExpenseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession();

        User user =
                (User) session.getAttribute("user");

        String title =
                req.getParameter("title");

        String category =
                req.getParameter("category");

        double amount =
                Double.parseDouble(
                        req.getParameter("amount"));

        Expense expense =
                new Expense();

        expense.setTitle(title);

        expense.setAmount(amount);
        expense.setCategory(category);

        expense.setUser(user);

        ExpenseDao dao =
                new ExpenseDao();

        dao.saveExpense(expense);

        resp.sendRedirect("user-dashboard");
    }
}