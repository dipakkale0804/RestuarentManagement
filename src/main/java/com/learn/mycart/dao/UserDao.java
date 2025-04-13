package com.learn.mycart.dao;

import com.learn.mycart.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

/**
 *
 * @author Dipak Kale
 */
public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {  // Fixed "Password" -> "password"
        User user = null;

        try {
            String query = "from User where userEmail = :e and userPassword = :p";
            Session session = this.factory.openSession();
            Query<User> q = session.createQuery(query, User.class);  // Fixed generic query type
            q.setParameter("e", email);
            q.setParameter("p", password);

            user = q.uniqueResult();  // Fixed incorrect casting

            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
