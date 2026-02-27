package com.icbt.hotel.oceanview.model;

import java.sql.Date;

public class Reservation {

    private int id;
    private String name;
    private String address;
    private String contact;
    private String email;
    private String room;
    private Date checkin;
    private Date checkout;
    private String requests;

    // ✅ new fields (must match DB + form)
    private int guests;
    private String payment;

    public Reservation() {
    }

    // -------- getters & setters --------
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRoom() { return room; }
    public void setRoom(String room) { this.room = room; }

    public Date getCheckin() { return checkin; }
    public void setCheckin(Date checkin) { this.checkin = checkin; }

    public Date getCheckout() { return checkout; }
    public void setCheckout(Date checkout) { this.checkout = checkout; }

    public String getRequests() { return requests; }
    public void setRequests(String requests) { this.requests = requests; }

    // ✅ required by ReservationDAO / ReservationServlet
    public int getGuests() { return guests; }
    public void setGuests(int guests) { this.guests = guests; }

    public String getPayment() { return payment; }
    public void setPayment(String payment) { this.payment = payment; }
}