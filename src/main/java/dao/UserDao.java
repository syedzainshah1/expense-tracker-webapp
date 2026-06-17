package dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.*;
import java.util.List;
import model.User;

public class UserDao {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("UserPU");

    public void saveUser(User user) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(user);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<User> getAllUser() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u", User.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // Integrated Login Method (Adapted to use your local 'emf')
    public User login(String email, String password) {

        EntityManager em = emf.createEntityManager();

        try {
            User user = em.createQuery(
                            "FROM User WHERE email=:e AND password=:p",
                            User.class
                    )
                    .setParameter("e", email)
                    .setParameter("p", password)
                    .getSingleResult();

            em.close();
            return user;

        } catch (Exception e) {
            em.close();
            return null;
        }
    }
}