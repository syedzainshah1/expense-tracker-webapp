package dao;

import jakarta.persistence.*;
import model.Expense;
import model.User;

import java.util.List;

public class ExpenseDao {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("UserPU");

    // SAVE EXPENSE
    public void saveExpense(Expense expense) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(expense);
            tx.commit();
        } finally {
            em.close();
        }
    }

    // DELETE EXPENSE - Moved outside of other methods
    public void deleteExpense(int id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Expense expense = em.find(Expense.class, id);
            if (expense != null) {
                em.remove(expense);
            }
            tx.commit();
        } finally {
            em.close();
        }
    }

    // GET USER EXPENSES
    public List<Expense> getExpensesByUser(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Expense> query = em.createQuery(
                    "SELECT e FROM Expense e WHERE e.user = :user",
                    Expense.class
            );
            query.setParameter("user", user);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}