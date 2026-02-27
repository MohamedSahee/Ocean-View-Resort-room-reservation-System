package com.icbt.hotel.oceanview.controller;

import com.icbt.hotel.oceanview.model.Reservation;
import com.icbt.hotel.oceanview.model.User;
import com.icbt.hotel.oceanview.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/editReservation")
public class EditReservationServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Session check
        User user = (User) request.getSession().getAttribute("admin");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Reservation r = service.getReservationById(id);

            if (r == null) {
                response.sendRedirect(request.getContextPath() + "/reservation?msg=fail");
                return;
            }

            request.setAttribute("reservation", r);
            request.getRequestDispatcher("/editReservation.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/reservation?msg=fail");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("admin");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

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
            r.setGuests(guestsStr != null && !guestsStr.trim().isEmpty()
                    ? Integer.parseInt(guestsStr.trim())
                    : 1);

            r.setRequests(request.getParameter("requests"));

            String payment = request.getParameter("payment");
            r.setPayment(payment != null && !payment.trim().isEmpty() ? payment : "cash");

            boolean ok = service.updateReservation(r);

            response.sendRedirect(request.getContextPath() + "/reservation?msg=" + (ok ? "updated" : "fail"));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Update failed. Please check inputs.");
            request.getRequestDispatcher("/editReservation.jsp").forward(request, response);
        }
    }
}