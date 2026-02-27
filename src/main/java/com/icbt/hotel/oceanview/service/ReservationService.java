package com.icbt.hotel.oceanview.service;

import com.icbt.hotel.oceanview.dao.ReservationDAO;
import com.icbt.hotel.oceanview.model.Reservation;

import java.util.List;

public class ReservationService {

    private final ReservationDAO dao = new ReservationDAO();

    public boolean addReservation(Reservation r) {
        return dao.addReservation(r);
    }

    // ✅ used by BillServlet + View + Edit
    public Reservation getReservation(int id) {
        return dao.getReservationById(id);
    }

    // ✅ used by ReservationServlet
    public Reservation getReservationById(int id) {
        return dao.getReservationById(id);
    }

    public boolean updateReservation(Reservation r) {
        return dao.updateReservation(r);
    }

    public boolean deleteReservation(int id) {
        return dao.deleteReservation(id);
    }

    public List<Reservation> searchByName(String name) {
        return dao.searchByName(name);
    }

    public List<Reservation> searchByContact(String contact) {
        return dao.searchByContact(contact);
    }

    public List<Reservation> getRecentReservations(int limit) {
        return dao.getRecentReservations(limit);
    }
}