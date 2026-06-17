package web;

import dao.ExpenseDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Expense;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/exportCsv")
public class ExportCsvServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        HttpSession session =
                req.getSession();

        User user =
                (User) session.getAttribute("user");

        ExpenseDao dao =
                new ExpenseDao();

        List<Expense> expenses =
                dao.getExpensesByUser(user);

        resp.setContentType("text/csv");

        resp.setHeader(
                "Content-Disposition",
                "attachment; filename=expenses.csv"
        );

        PrintWriter writer =
                resp.getWriter();

        writer.println("Title,Category,Amount");

        for(Expense e : expenses){

            writer.println(
                    e.getTitle()
                            + ","
                            + e.getCategory()
                            + ","
                            + e.getAmount()
            );
        }

        writer.close();
    }
}