<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.icbt.hotel.oceanview.model.User" %>
<%@ page import="com.icbt.hotel.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("admin");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Reservation reservation = (Reservation) request.getAttribute("reservation");
    String error = (String) request.getAttribute("error");

    List<Reservation> list = (List<Reservation>) request.getAttribute("list");
    List<Reservation> recentList = (List<Reservation>) request.getAttribute("recentList");

    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reservations - Ocean View Resort</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }
        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .glass-effect {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
        }
        .form-input:focus {
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }
        .animate-fade-in { animation: fadeIn 0.6s ease-out forwards; }
    </style>
</head>

<body class="p-4 md:p-8">

<!-- Header -->
<header class="flex items-center justify-between mb-8">
    <div class="flex items-center">
        <a href="<%= request.getContextPath() %>/dashboard.jsp"
           class="text-white hover:text-blue-200 transition duration-300 mr-4">
            <i class="fas fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h1 class="text-3xl font-bold text-white">View Reservations</h1>
            <p class="text-blue-100">Search & manage guest reservations</p>
        </div>
    </div>

    <div class="flex items-center">
        <div class="w-10 h-10 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center mr-3">
            <i class="fas fa-user-circle text-white"></i>
        </div>
        <div>
            <p class="text-white font-medium"><%= user.getUsername() %></p>
            <p class="text-blue-100 text-sm">Administrator</p>
        </div>
    </div>
</header>

<div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-3 gap-8">

    <!-- LEFT SIDE -->
    <div class="lg:col-span-2 space-y-6">

        <!-- Flash message -->
        <% if ("deleted".equals(msg)) { %>
        <div class="glass-effect rounded-xl p-4 border border-green-500/30 bg-green-500/10 text-green-200">
            ✅ Reservation deleted successfully.
        </div>
        <% } else if ("updated".equals(msg)) { %>
        <div class="glass-effect rounded-xl p-4 border border-blue-500/30 bg-blue-500/10 text-blue-200">
            ✅ Reservation updated successfully.
        </div>
        <% } else if ("fail".equals(msg)) { %>
        <div class="glass-effect rounded-xl p-4 border border-red-500/30 bg-red-500/10 text-red-200">
            ❌ Action failed. Please try again.
        </div>
        <% } %>

        <!-- Search Section -->
        <div class="glass-effect rounded-2xl p-8 animate-fade-in">
            <h2 class="text-2xl font-bold text-white mb-6">
                <i class="fas fa-search mr-3"></i>Search Reservation
            </h2>

            <form action="<%= request.getContextPath() %>/reservation" method="get">
                <input type="hidden" name="action" value="search"/>

                <p class="text-blue-100 text-sm mb-4">
                    Fill <b>only one</b> field: ID OR Name OR Contact.
                </p>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">Reservation ID</label>
                        <input type="number" name="id"
                               class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                               placeholder="e.g. 101"/>
                    </div>

                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">Guest Name</label>
                        <input type="text" name="name"
                               class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                               placeholder="e.g. Ahmed"/>
                    </div>

                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">Contact No</label>
                        <input type="text" name="contact"
                               class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                               placeholder="e.g. 0771234567"/>
                    </div>
                </div>

                <div class="mt-5 flex gap-3">
                    <button type="submit"
                            class="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold px-8 py-3 rounded-xl shadow-lg hover:shadow-xl transition duration-300">
                        <i class="fas fa-search mr-2"></i>Search
                    </button>

                    <a href="<%= request.getContextPath() %>/reservation?action=recent"
                       class="glass-effect border border-white/30 text-white px-6 py-3 rounded-xl hover:bg-white/10 transition duration-300">
                        <i class="fas fa-rotate-left mr-2"></i>Reset
                    </a>
                </div>
            </form>

            <% if (error != null) { %>
            <div class="mt-6 glass-effect border border-red-500/30 bg-red-500/10 rounded-xl p-5 text-red-200">
                <i class="fas fa-triangle-exclamation mr-2"></i><%= error %>
            </div>
            <% } %>
        </div>

        <!-- Search Results List -->
        <% if (list != null && !list.isEmpty()) { %>
        <div class="glass-effect rounded-2xl p-8">
            <h2 class="text-2xl font-bold text-white mb-6">
                <i class="fas fa-list mr-3"></i>Search Results
            </h2>

            <% for (Reservation r : list) { %>
            <div class="p-5 mb-4 rounded-xl bg-white/5 border border-white/10 flex flex-col md:flex-row md:items-center justify-between">
                <div>
                    <p class="text-white font-bold text-lg">#<%= r.getId() %> - <%= r.getName() %></p>
                    <p class="text-blue-100 text-sm"><i class="fas fa-phone mr-2"></i><%= r.getContact() %></p>
                    <p class="text-blue-100 text-sm"><i class="fas fa-bed mr-2"></i><%= r.getRoom() %></p>
                </div>

                <div class="mt-4 md:mt-0 flex gap-4">
                    <a class="text-blue-200 hover:text-white"
                       href="<%= request.getContextPath() %>/reservation?action=search&id=<%= r.getId() %>">
                        <i class="fas fa-eye mr-1"></i>View
                    </a>

                    <!-- ✅ FIXED -->
                    <a class="text-green-200 hover:text-white"
                       href="<%= request.getContextPath() %>/editReservation?id=<%= r.getId() %>">
                        <i class="fas fa-edit mr-1"></i>Edit
                    </a>

                    <a class="text-red-200 hover:text-white"
                       href="<%= request.getContextPath() %>/reservation?action=delete&id=<%= r.getId() %>"
                       onclick="return confirm('Delete reservation #<%= r.getId() %>?');">
                        <i class="fas fa-trash mr-1"></i>Delete
                    </a>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>

        <!-- Recent Reservations -->
        <div class="glass-effect rounded-2xl p-8">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-white">
                    <i class="fas fa-clock mr-3"></i>Recent Reservations
                </h2>
                <a href="<%= request.getContextPath() %>/reservation?action=recent"
                   class="text-blue-200 hover:text-white text-sm transition duration-300">
                    Refresh
                </a>
            </div>

            <% if (recentList != null && !recentList.isEmpty()) { %>
            <div class="space-y-4">
                <% for (Reservation r : recentList) { %>
                <div class="p-5 rounded-xl bg-white/5 border border-white/10 flex flex-col md:flex-row md:items-center justify-between">
                    <div>
                        <p class="text-white font-bold"><%= r.getName() %></p>
                        <p class="text-blue-100 text-sm">ID: #<%= r.getId() %> • <%= r.getRoom() %></p>
                        <p class="text-blue-100 text-sm"><i class="fas fa-calendar mr-2"></i>
                            <%= r.getCheckin() %> → <%= r.getCheckout() %>
                        </p>
                    </div>

                    <div class="mt-4 md:mt-0 flex gap-4">
                        <a class="text-blue-200 hover:text-white"
                           href="<%= request.getContextPath() %>/reservation?action=search&id=<%= r.getId() %>">
                            <i class="fas fa-eye mr-1"></i>View
                        </a>

                        <!-- ✅ FIXED -->
                        <a class="text-green-200 hover:text-white"
                           href="<%= request.getContextPath() %>/editReservation?id=<%= r.getId() %>">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </a>

                        <a class="text-red-200 hover:text-white"
                           href="<%= request.getContextPath() %>/reservation?action=delete&id=<%= r.getId() %>"
                           onclick="return confirm('Delete reservation #<%= r.getId() %>?');">
                            <i class="fas fa-trash mr-1"></i>Delete
                        </a>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <p class="text-blue-100">No recent reservations found.</p>
            <% } %>
        </div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="space-y-6">

        <!-- Reservation Details -->
        <% if (reservation != null) { %>
        <div class="glass-effect rounded-2xl p-6 animate-fade-in">
            <h3 class="text-xl font-bold text-white mb-6">Reservation Details</h3>

            <div class="space-y-4">
                <div class="p-4 bg-white/5 rounded-xl">
                    <p class="text-blue-100 text-xs">Reservation ID</p>
                    <p class="text-white font-bold text-lg">#<%= reservation.getId() %></p>
                </div>

                <div class="p-4 bg-white/5 rounded-xl">
                    <p class="text-blue-100 text-xs">Guest Name</p>
                    <p class="text-white font-medium"><%= reservation.getName() %></p>
                </div>

                <div class="p-4 bg-white/5 rounded-xl">
                    <p class="text-blue-100 text-xs">Contact</p>
                    <p class="text-white font-medium"><%= reservation.getContact() %></p>
                </div>

                <div class="p-4 bg-white/5 rounded-xl">
                    <p class="text-blue-100 text-xs">Room</p>
                    <p class="text-white font-medium"><%= reservation.getRoom() %></p>
                </div>

                <div class="p-4 bg-white/5 rounded-xl">
                    <p class="text-blue-100 text-xs">Check-in / Check-out</p>
                    <p class="text-white font-medium"><%= reservation.getCheckin() %> → <%= reservation.getCheckout() %></p>
                </div>

                <div class="grid grid-cols-2 gap-3 pt-2">
                    <!-- ✅ FIXED -->
                    <a class="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white py-3 rounded-xl text-center transition duration-300"
                       href="<%= request.getContextPath() %>/editReservation?id=<%= reservation.getId() %>">
                        <i class="fas fa-edit mr-2"></i>Edit
                    </a>

                    <button class="bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 text-white py-3 rounded-xl transition duration-300"
                            onclick="window.print()">
                        <i class="fas fa-print mr-2"></i>Print
                    </button>

                    <!-- ✅ FIXED: bill servlet -->
                    <a class="bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white py-3 rounded-xl text-center transition duration-300"
                       href="bill.jsp">
                        <i class="fas fa-file-invoice mr-2"></i>Bill
                    </a>

                    <a class="bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-white py-3 rounded-xl text-center transition duration-300"
                       href="<%= request.getContextPath() %>/reservation?action=delete&id=<%= reservation.getId() %>"
                       onclick="return confirm('Delete this reservation?');">
                        <i class="fas fa-trash mr-2"></i>Delete
                    </a>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Quick Actions -->
        <div class="glass-effect rounded-2xl p-6">
            <h3 class="text-xl font-bold text-white mb-6">Quick Actions</h3>

            <div class="space-y-4">
                <a href="<%= request.getContextPath() %>/addReservation.jsp"
                   class="flex items-center p-4 bg-white/10 border border-white/10 rounded-xl hover:bg-white/20 transition">
                    <i class="fas fa-plus text-white mr-4"></i>
                    <div>
                        <p class="text-white font-medium">New Reservation</p>
                        <p class="text-blue-100 text-sm">Create booking</p>
                    </div>
                </a>

                <a href="bill.jsp" class="flex items-center p-3 text-blue-100 hover:text-white hover:bg-white/10 rounded-lg transition duration-300">
                    <i class="fas fa-file-invoice-dollar text-white mr-4"></i>
                    <div>
                        <p class="text-white font-medium">Generate Bill</p>
                        <p class="text-blue-100 text-sm">Print invoice</p>
                    </div>
                </a>

                <a href="<%= request.getContextPath() %>/help.jsp"
                   class="flex items-center p-4 bg-white/10 border border-white/10 rounded-xl hover:bg-white/20 transition">
                    <i class="fas fa-question-circle text-white mr-4"></i>
                    <div>
                        <p class="text-white font-medium">Help Center</p>
                        <p class="text-blue-100 text-sm">Support</p>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>