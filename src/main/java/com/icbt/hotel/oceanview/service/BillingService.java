package com.icbt.hotel.oceanview.service;

import com.icbt.hotel.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.temporal.ChronoUnit;

public class BillingService {

    public double calculateBill(String roomType, java.sql.Date checkIn, java.sql.Date checkOut) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT price_per_night FROM room_rates WHERE room_type=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, roomType);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double price = rs.getDouble("price_per_night");
                long nights = ChronoUnit.DAYS.between(checkIn.toLocalDate(), checkOut.toLocalDate());
                return nights * price;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}