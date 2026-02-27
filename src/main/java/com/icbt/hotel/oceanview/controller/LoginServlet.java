package com.icbt.hotel.oceanview.controller;

import com.icbt.hotel.oceanview.model.User;
import com.icbt.hotel.oceanview.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authService.login(username, password);

        System.out.println("LOGIN TRY: " + username);
        System.out.println("LOGIN RESULT user is null? " + (user == null));

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", user); // ✅ must match dashboard.jsp
            session.setMaxInactiveInterval(30 * 60);

            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            // ✅ forward keeps error message (not redirect)
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}