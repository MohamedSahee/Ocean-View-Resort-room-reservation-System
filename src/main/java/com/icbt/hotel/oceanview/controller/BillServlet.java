package com.icbt.hotel.oceanview.controller;

import com.icbt.hotel.oceanview.model.Reservation;
import com.icbt.hotel.oceanview.service.BillingService;
import com.icbt.hotel.oceanview.service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                request.setAttribute("error", "Please enter a Reservation ID.");
                request.getRequestDispatcher("/bill.jsp").forward(request, response);
                return;
            }

            int id = Integer.parseInt(idStr.trim());

            // ✅ FIX: use correct method name
            Reservation r = reservationService.getReservationById(id);

            if (r == null) {
                request.setAttribute("error", "Reservation not found for ID: " + id);
                request.getRequestDispatcher("/bill.jsp").forward(request, response);
                return;
            }

            double total = billingService.calculateBill(r.getRoom(), r.getCheckin(), r.getCheckout());

            request.setAttribute("reservation", r);
            request.setAttribute("total", total);

            request.getRequestDispatcher("/bill.jsp").forward(request, response);

        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Invalid Reservation ID. Please enter a number.");
            request.getRequestDispatcher("/bill.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Something went wrong while generating the bill.");
            request.getRequestDispatcher("/bill.jsp").forward(request, response);
        }
    }
}