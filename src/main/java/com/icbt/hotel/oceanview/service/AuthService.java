package com.icbt.hotel.oceanview.service;

import com.icbt.hotel.oceanview.dao.UserDAO;
import com.icbt.hotel.oceanview.model.User;

public class AuthService {

    private final UserDAO userDAO = new UserDAO();

    public User login(String username, String password) {
        return userDAO.validateUser(username, password);
    }
}