/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.learn.mycart.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import com.learn.mycart.entities.Category;
import java.util.List;
import org.hibernate.query.Query; // Fixed missing import for Query

/**
 *
 * @author Dipak Kale
 */
public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save the category to the database
    public int saveCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        int catId = (int) session.save(cat);
        tx.commit();
        session.close();  // Fixed missing semicolon

        return catId;
    }

    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query<Category> query = s.createQuery("from Category", Category.class); // Fixed incorrect entity name case
        List<Category> list = query.list();
        s.close(); // Added session close to prevent memory leaks
        return list;
    }
    
    public Category getCategoryById(int cid)
    {
        Category cat=null;
        try {
            
           Session session = this.factory.openSession();
           cat = session.get(Category.class, cid);
           session.close();
           
            
        } catch (Exception e) {
            
            e.printStackTrace();
            
        }
        return cat;
        
    }
    
}
