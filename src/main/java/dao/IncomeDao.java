package dao;

import jakarta.persistence.*;
import model.Income;
import model.User;

import java.util.List;

public class IncomeDao {

    // Keep it static or non-static, but stay consistent.
    // Tip: Usually, you only want ONE EntityManagerFactory for the whole app life.
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("UserPU");

    // SAVE INCOME
    public void saveIncome(Income income) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(income);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // DELETE INCOME
    public void deleteIncome(int id) {
        EntityManager em = emf.createEntityManager(); // Fixed: Changed from JpaUtil
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Income income = em.find(Income.class, id);
            if (income != null) {
                em.remove(income);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // GET USER INCOME
    public List<Income> getIncomeByUser(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Income> query = em.createQuery(
                    "SELECT i FROM Income i WHERE i.user = :user",
                    Income.class
            );
            query.setParameter("user", user);
            return query.getResultList();
        } finally {
            em.close(); // Fixed: Added finally block to ensure closure
        }
    }
}