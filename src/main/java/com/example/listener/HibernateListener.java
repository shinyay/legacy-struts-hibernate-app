package com.example.listener;

import com.example.util.HibernateUtil;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Application Lifecycle Listener for Hibernate
 * Initializes Hibernate on startup and cleans up on shutdown
 */
public class HibernateListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce) {
        // Initialize Hibernate SessionFactory
        try {
            HibernateUtil.getSessionFactory();
            System.out.println("Hibernate SessionFactory initialized successfully");
        } catch (Exception e) {
            System.err.println("Failed to initialize Hibernate SessionFactory: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        // Shutdown Hibernate SessionFactory
        try {
            HibernateUtil.shutdown();
            System.out.println("Hibernate SessionFactory closed successfully");
        } catch (Exception e) {
            System.err.println("Failed to close Hibernate SessionFactory: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
