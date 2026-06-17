package web;

import dao.ExpenseDao;
import dao.IncomeDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Expense;
import model.Income;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession();

        User user =
                (User) session.getAttribute("user");

        if(user == null){

            resp.sendRedirect(
                    req.getContextPath()
                            + "/index.jsp");

            return;
        }

        ExpenseDao expenseDao =
                new ExpenseDao();

        IncomeDao incomeDao =
                new IncomeDao();

        List<Expense> expenses =
                expenseDao.getExpensesByUser(user);

        List<Income> incomes =
                incomeDao.getIncomeByUser(user);

        double totalExpense = 0;

        for(Expense e : expenses){

            totalExpense += e.getAmount();
        }

        double totalIncome = 0;

        for(Income i : incomes){

            totalIncome += i.getAmount();
        }

        double balance =
                totalIncome - totalExpense;

        req.setAttribute("expenses", expenses);

        req.setAttribute("expense", totalExpense);

        req.setAttribute("income", totalIncome);

        req.setAttribute("balance", balance);

        req.getRequestDispatcher(
                        "/dashboard.jsp")
                .forward(req, resp);
    }
}