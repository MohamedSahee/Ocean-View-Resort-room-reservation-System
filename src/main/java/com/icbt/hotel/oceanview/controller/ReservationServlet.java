package com.icbt.hotel.oceanview.controller;

import com.icbt.hotel.oceanview.model.Reservation;
import com.icbt.hotel.oceanview.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ✅ Always load recent reservations for the page
        request.setAttribute("recentList", service.getRecentReservations(10));

        if (action == null) {
            // open page normally
            request.getRequestDispatcher("/viewReservation.jsp").forward(request, response);
            return;
        }

        if ("search".equals(action)) {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String contact = request.getParameter("contact");

            // Search priority: ID -> name -> contact
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    Reservation r = service.getReservationById(id);
                    if (r != null) request.setAttribute("reservation", r);
                    else request.setAttribute("error", "No reservation found for ID: " + id);
                } catch (Exception e) {
                    request.setAttribute("error", "Invalid reservation ID.");
                }
            } else if (name != null && !name.trim().isEmpty()) {
                List<Reservation> list = service.searchByName(name);
                if (list.isEmpty()) request.setAttribute("error", "No reservations found for name: " + name);
                request.setAttribute("list", list);
            } else if (contact != null && !contact.trim().isEmpty()) {
                List<Reservation> list = service.searchByContact(contact);
                if (list.isEmpty()) request.setAttribute("error", "No reservations found for contact: " + contact);
                request.setAttribute("list", list);
            } else {
                request.setAttribute("error", "Please enter ID OR Name OR Contact to search.");
            }

            request.getRequestDispatcher("/viewReservation.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = service.deleteReservation(id);
                response.sendRedirect(request.getContextPath() + "/reservation?msg=" + (ok ? "deleted" : "fail"));
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/reservation?msg=fail");
            }
            return;
        }

        // default
        request.getRequestDispatcher("/viewReservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Reservation r = new Reservation();

            r.setId(Integer.parseInt(request.getParameter("id")));
            r.setName(request.getParameter("name"));
            r.setAddress(request.getParameter("address"));
            r.setContact(request.getParameter("contact"));
            r.setEmail(request.getParameter("email"));

            r.setRoom(request.getParameter("room"));

            r.setCheckin(Date.valueOf(request.getParameter("checkin")));
            r.setCheckout(Date.valueOf(request.getParameter("checkout")));

            String guestsStr = request.getParameter("guests");
            r.setGuests(guestsStr != null && !guestsStr.trim().isEmpty() ? Integer.parseInt(guestsStr.trim()) : 1);

            r.setRequests(request.getParameter("requests"));

            String payment = request.getParameter("payment");
            r.setPayment(payment != null && !payment.trim().isEmpty() ? payment : "cash");

            boolean ok = service.addReservation(r);

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/addReservation.jsp?success=1");
            } else {
                request.setAttribute("error", "Reservation not saved. Reservation ID may already exist.");
                request.getRequestDispatcher("/addReservation.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check all fields.");
            request.getRequestDispatcher("/addReservation.jsp").forward(request, response);
        }
    }
}