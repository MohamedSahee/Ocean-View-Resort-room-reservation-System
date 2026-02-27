package com.icbt.hotel.oceanview.dao;

import com.icbt.hotel.oceanview.model.Reservation;
import com.icbt.hotel.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations " +
                "(id, name, address, contact, email, room, checkin, checkout, requests, guests, payment) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getId());
            ps.setString(2, r.getName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContact());
            ps.setString(5, r.getEmail());
            ps.setString(6, r.getRoom());
            ps.setDate(7, r.getCheckin());
            ps.setDate(8, r.getCheckout());
            ps.setString(9, r.getRequests());
            ps.setInt(10, r.getGuests());
            ps.setString(11, r.getPayment());

            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException dup) {
            // ID duplicate
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM reservations WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapReservation(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateReservation(Reservation r) {
        String sql = "UPDATE reservations SET " +
                "name=?, address=?, contact=?, email=?, room=?, checkin=?, checkout=?, requests=?, guests=?, payment=? " +
                "WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getContact());
            ps.setString(4, r.getEmail());
            ps.setString(5, r.getRoom());
            ps.setDate(6, r.getCheckin());
            ps.setDate(7, r.getCheckout());
            ps.setString(8, r.getRequests());
            ps.setInt(9, r.getGuests());
            ps.setString(10, r.getPayment());
            ps.setInt(11, r.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReservation(int id) {
        String sql = "DELETE FROM reservations WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> searchByName(String name) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE name LIKE ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + name.trim() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapReservation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Reservation> searchByContact(String contact) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE contact LIKE ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + contact.trim() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapReservation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ recent list (works even if created_at does NOT exist)
    public List<Reservation> getRecentReservations(int limit) {
        List<Reservation> list = new ArrayList<>();

        String sql;
        try (Connection con = DBConnection.getConnection()) {

            boolean hasCreatedAt = hasColumn(con, "reservations", "created_at");
            sql = hasCreatedAt
                    ? "SELECT * FROM reservations ORDER BY created_at DESC LIMIT ?"
                    : "SELECT * FROM reservations ORDER BY id DESC LIMIT ?";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) list.add(mapReservation(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    private boolean hasColumn(Connection con, String table, String column) {
        try {
            DatabaseMetaData md = con.getMetaData();
            try (ResultSet rs = md.getColumns(null, null, table, column)) {
                return rs.next();
            }
        } catch (Exception e) {
            return false;
        }
    }

    private Reservation mapReservation(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setId(rs.getInt("id"));
        r.setName(rs.getString("name"));
        r.setAddress(rs.getString("address"));
        r.setContact(rs.getString("contact"));
        r.setEmail(rs.getString("email"));
        r.setRoom(rs.getString("room"));
        r.setCheckin(rs.getDate("checkin"));
        r.setCheckout(rs.getDate("checkout"));
        r.setRequests(rs.getString("requests"));
        r.setGuests(rs.getInt("guests"));
        r.setPayment(rs.getString("payment"));
        return r;
    }
}