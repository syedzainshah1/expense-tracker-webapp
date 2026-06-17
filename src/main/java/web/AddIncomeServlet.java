package web;

import dao.IncomeDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Income;
import model.User;

import java.io.IOException;

@WebServlet("/addIncome")
public class AddIncomeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        HttpSession session =
                req.getSession();

        User user =
                (User) session.getAttribute("user");

        String source =
                req.getParameter("source");

        double amount =
                Double.parseDouble(
                        req.getParameter("amount")
                );

        Income income = new Income();

        income.setSource(source);

        income.setAmount(amount);

        income.setUser(user);

        IncomeDao dao = new IncomeDao();

        dao.saveIncome(income);

        resp.sendRedirect(
                req.getContextPath()
                        + "/dashboard.jsp"
        );
    }
}