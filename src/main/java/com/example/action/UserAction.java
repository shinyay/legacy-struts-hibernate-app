package com.example.action;

import com.example.dao.UserDAO;
import com.example.dao.impl.UserDAOImpl;
import com.example.model.User;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/**
 * Struts Action for User AJAX operations
 */
public class UserAction extends Action {

    private UserDAO userDAO = new UserDAOImpl();

    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // Get method parameter from struts-config.xml
        String method = mapping.getParameter();

        if (method != null && method.startsWith("method=")) {
            method = method.substring(7); // Remove "method=" prefix
        }

        if ("save".equals(method)) {
            return saveUser(mapping, form, request, response);
        } else if ("list".equals(method)) {
            return listUsers(mapping, form, request, response);
        }

        return null;
    }

    private ActionForward saveUser(ActionMapping mapping, ActionForm form,
                                   HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Basic validation
            if (username == null || username.trim().length() == 0) {
                out.print("{\"success\":false,\"message\":\"Username is required\"}");
                return null;
            }
            if (email == null || email.trim().length() == 0) {
                out.print("{\"success\":false,\"message\":\"Email is required\"}");
                return null;
            }

            User user = new User(username.trim(), email.trim());
            if (password != null && password.length() > 0) {
                user.setPassword(password);
            }

            userDAO.save(user);

            out.print("{\"success\":true,\"message\":\"User saved successfully\"}");
        } catch (Exception e) {
            String message = e.getMessage();
            if (message == null) {
                message = "Error saving user";
            }
            out.print("{\"success\":false,\"message\":\"" + escapeJson(message) + "\"}");
        } finally {
            out.flush();
            out.close();
        }

        return null;
    }

    private ActionForward listUsers(ActionMapping mapping, ActionForm form,
                                    HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List users = userDAO.findAll();

            StringBuffer json = new StringBuffer();
            json.append("{\"users\":[");

            if (users != null && users.size() > 0) {
                for (int i = 0; i < users.size(); i++) {
                    User user = (User) users.get(i);
                    if (i > 0) json.append(",");
                    json.append("{");
                    json.append("\"id\":").append(user.getId()).append(",");
                    json.append("\"username\":\"").append(escapeJson(user.getUsername())).append("\",");
                    json.append("\"email\":\"").append(escapeJson(user.getEmail())).append("\"");
                    json.append("}");
                }
            }

            json.append("]}");
            out.print(json.toString());
        } catch (Exception e) {
            String message = e.getMessage();
            if (message == null) {
                message = "Error retrieving users";
            }
            out.print("{\"users\":[],\"error\":\"" + escapeJson(message) + "\"}");
        } finally {
            out.flush();
            out.close();
        }

        return null;
    }

    /**
     * Escape special characters for JSON output
     */
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        StringBuffer result = new StringBuffer();
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '\"':
                    result.append("\\\"");
                    break;
                case '\\':
                    result.append("\\\\");
                    break;
                case '/':
                    result.append("\\/");
                    break;
                case '\b':
                    result.append("\\b");
                    break;
                case '\f':
                    result.append("\\f");
                    break;
                case '\n':
                    result.append("\\n");
                    break;
                case '\r':
                    result.append("\\r");
                    break;
                case '\t':
                    result.append("\\t");
                    break;
                default:
                    result.append(c);
            }
        }
        return result.toString();
    }
}
