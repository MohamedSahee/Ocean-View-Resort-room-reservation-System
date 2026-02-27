<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.icbt.hotel.oceanview.model.User" %>
<%@ page import="com.icbt.hotel.oceanview.model.Reservation" %>

<%
    User user = (User) session.getAttribute("admin");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
    String error = (String) request.getAttribute("error");

    if (r == null) {
        // If someone opens jsp directly without servlet
        response.sendRedirect(request.getContextPath() + "/reservation");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Reservation - Ocean View</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .glass { background: rgba(255,255,255,.1); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,.2); }
    </style>
</head>
<body class="p-4 md:p-8">

<div class="max-w-4xl mx-auto">
    <div class="flex items-center justify-between mb-6">
        <div class="flex items-center">
            <a href="<%= request.getContextPath() %>/reservation" class="text-white hover:text-blue-200 mr-4">
                <i class="fas fa-arrow-left text-xl"></i>
            </a>
            <div>
                <h1 class="text-3xl font-bold text-white">Edit Reservation</h1>
                <p class="text-blue-100">Update reservation details</p>
            </div>
        </div>

        <div class="text-right">
            <p class="text-white font-medium"><%= user.getUsername() %></p>
            <p class="text-blue-100 text-sm">Administrator</p>
        </div>
    </div>

    <% if (error != null) { %>
    <div class="glass rounded-xl p-4 mb-5 border border-red-500/30 bg-red-500/10 text-red-200">
        <i class="fas fa-triangle-exclamation mr-2"></i><%= error %>
    </div>
    <% } %>

    <div class="glass rounded-2xl p-8">
        <form action="<%= request.getContextPath() %>/editReservation" method="post" class="space-y-5">

            <!-- ID readonly -->
            <div>
                <label class="block text-blue-100 text-sm mb-2">Reservation ID</label>
                <input type="number" name="id" value="<%= r.getId() %>" readonly
                       class="w-full bg-white/10 border border-white/20 rounded-xl px-4 py-3 text-white"/>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-blue-100 text-sm mb-2">Guest Name</label>
                    <input type="text" name="name" value="<%= r.getName() %>" required
                           class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none"/>
                </div>

                <div>
                    <label class="block text-blue-100 text-sm mb-2">Contact</label>
                    <input type="text" name="contact" value="<%= r.getContact() %>" required
                           class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none"/>
                </div>
            </div>

            <div>
                <label class="block text-blue-100 text-sm mb-2">Address</label>
                <textarea name="address" rows="3"
                          class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none"><%= r.getAddress() %></textarea>
            </div>

            <div>
                <label class="block text-blue-100 text-sm mb-2">Email</label>
                <input type="email" name="email" value="<%= r.getEmail() != null ? r.getEmail() : "" %>"
                       class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none"/>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-blue-100 text-sm mb-2">Room</label>
                    <select name="room" class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white">
                        <option class="bg-gray-800" value="Single" <%= "Single".equals(r.getRoom()) ? "selected" : "" %>>Single</option>
                        <option class="bg-gray-800" value="Double" <%= "Double".equals(r.getRoom()) ? "selected" : "" %>>Double</option>
                        <option class="bg-gray-800" value="Suite"  <%= "Suite".equals(r.getRoom()) ? "selected" : "" %>>Suite</option>
                    </select>
                </div>

                <div>
                    <label class="block text-blue-100 text-sm mb-2">Guests</label>
                    <select name="guests" class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white">
                        <option class="bg-gray-800" value="1" <%= r.getGuests()==1 ? "selected" : "" %>>1</option>
                        <option class="bg-gray-800" value="2" <%= r.getGuests()==2 ? "selected" : "" %>>2</option>
                        <option class="bg-gray-800" value="3" <%= r.getGuests()==3 ? "selected" : "" %>>3</option>
                        <option class="bg-gray-800" value="4" <%= r.getGuests()==4 ? "selected" : "" %>>4</option>
                    </select>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div>
                    <label class="block text-blue-100 text-sm mb-2">Check-in</label>
                    <input type="date" name="checkin" value="<%= r.getCheckin() %>" required
                           class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white"/>
                </div>

                <div>
                    <label class="block text-blue-100 text-sm mb-2">Check-out</label>
                    <input type="date" name="checkout" value="<%= r.getCheckout() %>" required
                           class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white"/>
                </div>
            </div>

            <div>
                <label class="block text-blue-100 text-sm mb-2">Requests</label>
                <textarea name="requests" rows="2"
                          class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none"><%= r.getRequests() != null ? r.getRequests() : "" %></textarea>
            </div>

            <div>
                <label class="block text-blue-100 text-sm mb-2">Payment</label>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                    <label class="glass rounded-xl p-3 text-white">
                        <input type="radio" name="payment" value="cash" <%= "cash".equals(r.getPayment()) ? "checked" : "" %> /> Cash
                    </label>
                    <label class="glass rounded-xl p-3 text-white">
                        <input type="radio" name="payment" value="card" <%= "card".equals(r.getPayment()) ? "checked" : "" %> /> Card
                    </label>
                    <label class="glass rounded-xl p-3 text-white">
                        <input type="radio" name="payment" value="online" <%= "online".equals(r.getPayment()) ? "checked" : "" %> /> Online
                    </label>
                    <label class="glass rounded-xl p-3 text-white">
                        <input type="radio" name="payment" value="invoice" <%= "invoice".equals(r.getPayment()) ? "checked" : "" %> /> Invoice
                    </label>
                </div>
            </div>

            <div class="flex justify-end gap-3 pt-4">
                <a href="<%= request.getContextPath() %>/reservation"
                   class="glass px-6 py-3 rounded-xl text-white hover:bg-white/10">
                    Cancel
                </a>
                <button type="submit"
                        class="bg-gradient-to-r from-blue-500 to-purple-600 text-white font-bold px-8 py-3 rounded-xl hover:from-blue-600 hover:to-purple-700">
                    <i class="fas fa-save mr-2"></i>Save Changes
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>