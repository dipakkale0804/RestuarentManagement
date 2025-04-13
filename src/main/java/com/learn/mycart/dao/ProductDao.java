package com.learn.mycart.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.query.Query;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(product);

            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Get all products
    public List<Product> getAllProducts() {
        List<Product> list = null;
        try (Session s = this.factory.openSession()) { // Fix: Using try-with-resources to auto-close session
            Query<Product> query = s.createQuery("from Product", Product.class);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all products of given category
    public List<Product> getAllProductsById(int cid) {
        List<Product> list = null;
        try (Session s = this.factory.openSession()) { // Fix: Using try-with-resources to auto-close session
            Query<Product> query = s.createQuery("from Product as p where p.category.categoryId =: id", Product.class);
            query.setParameter("id", cid);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
