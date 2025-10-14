package com.example.filter;

import com.example.util.HibernateUtil;
import org.hibernate.SessionFactory;

import javax.servlet.*;
import java.io.IOException;

/**
 * Hibernate Session Management Filter
 * Ensures Hibernate session is properly closed after each request
 */
public class HibernateSessionFilter implements Filter {

    private SessionFactory sessionFactory;

    public void init(FilterConfig filterConfig) throws ServletException {
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            chain.doFilter(request, response);
        } finally {
            // Thread-bound sessions are automatically managed by Hibernate
            // when using current_session_context_class=thread
            // Manual cleanup is not needed and can cause issues
        }
    }

    public void destroy() {
        // Cleanup on application shutdown
    }
}
