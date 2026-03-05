<%--
  Created by IntelliJ IDEA.
  User: msahe
  Date: 1/11/2026
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.icbt.hotel.oceanview.model.User" %>
<%
    User user = (User) session.getAttribute("admin");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Reservation - Ocean View Resort</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Flatpickr for date picker -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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

        .form-input {
            transition: all 0.3s ease;
        }

        .form-input:focus {
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
        }

        .room-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .room-card:hover {
            transform: translateY(-3px);
        }

        .room-card.selected {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3);
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.4);
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .animate-slide-in-right {
            animation: slideInRight 0.5s ease-out forwards;
        }
    </style>
</head>
<body class="p-4 md:p-8">


<%
    String success = request.getParameter("success");
    String errorMsg = (String) request.getAttribute("error");
%>

<% if ("1".equals(success)) { %>
<div class="max-w-6xl mx-auto mb-6 p-4 rounded-xl bg-green-500/20 border border-green-400 text-green-100">
    ✅ Reservation saved successfully!..
</div>
<% } %>

<% if (errorMsg != null) { %>
<div class="max-w-6xl mx-auto mb-6 p-4 rounded-xl bg-red-500/20 border border-red-400 text-red-100">
    ❌ <%= errorMsg %>
</div>
<% } %>

<!-- Header -->
<header class="flex items-center justify-between mb-8">
    <div class="flex items-center">
        <a href="dashboard.jsp" class="text-white hover:text-blue-200 transition duration-300 mr-4">
            <i class="fas fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h1 class="text-3xl font-bold text-white">Add New Reservation</h1>
            <p class="text-blue-100">Create a new booking for Ocean View Resort</p>
        </div>
    </div>

    <div class="flex items-center space-x-4">
        <div class="flex items-center">
            <div class="w-10 h-10 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center mr-3">
                <i class="fas fa-user-circle text-white"></i>
            </div>
            <div>
                <p class="text-white font-medium"><%= user.getUsername() %></p>
                <p class="text-blue-100 text-sm">Administrator</p>
            </div>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="max-w-6xl mx-auto">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Form Section -->
        <div class="lg:col-span-2">
            <div class="glass-effect rounded-2xl p-8 animate-fade-in-up">
                <!-- Progress Steps -->
                <div class="mb-10">
                    <div class="flex items-center justify-between relative">
                        <div class="absolute top-1/2 left-0 right-0 h-1 bg-white/10 -translate-y-1/2"></div>
                        <div class="absolute top-1/2 left-0 h-1 bg-gradient-to-r from-blue-500 to-purple-600 -translate-y-1/2" style="width: 33%;"></div>

                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mb-2">
                                <i class="fas fa-user text-white"></i>
                            </div>
                            <span class="text-white text-sm font-medium">Guest Info</span>
                        </div>

                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center mb-2">
                                <i class="fas fa-bed text-blue-200"></i>
                            </div>
                            <span class="text-blue-200 text-sm">Room Details</span>
                        </div>

                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center mb-2">
                                <i class="fas fa-calendar-check text-blue-200"></i>
                            </div>
                            <span class="text-blue-200 text-sm">Confirmation</span>
                        </div>
                    </div>
                </div>

                <form action="reservation" method="post" id="reservationForm" class="space-y-6">
                    <h2 class="text-2xl font-bold text-white mb-6">Guest Information</h2>

                    <!-- Guest Details -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-hashtag mr-2"></i>Reservation ID
                            </label>
                            <input
                                    type="number"
                                    name="id"
                                    required
                                    class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                    placeholder="Enter reservation ID"
                            >
                        </div>

                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-user mr-2"></i>Guest Name
                            </label>
                            <input
                                    type="text"
                                    name="name"
                                    required
                                    class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                    placeholder="Enter guest full name"
                            >
                        </div>
                    </div>

                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">
                            <i class="fas fa-map-marker-alt mr-2"></i>Address
                        </label>
                        <textarea
                                name="address"
                                rows="3"
                                class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300 resize-none"
                                placeholder="Enter guest address"
                        ></textarea>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-phone mr-2"></i>Contact Number
                            </label>
                            <input
                                    type="text"
                                    name="contact"
                                    required
                                    class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                    placeholder="Enter phone number"
                            >
                        </div>

                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-envelope mr-2"></i>Email Address
                            </label>
                            <input
                                    type="email"
                                    name="email"
                                    class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                    placeholder="Enter email (optional)"
                            >
                        </div>
                    </div>

                    <!-- Room Selection -->
                    <h2 class="text-2xl font-bold text-white mt-8 mb-6">Room Selection</h2>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6" id="roomSelection">
                        <div class="room-card glass-effect border border-white/20 rounded-xl p-5 cursor-pointer" data-room="Single" data-price="120">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 bg-blue-500/20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-bed text-blue-300 text-xl"></i>
                                </div>
                                <span class="text-green-400 font-bold">$120/night</span>
                            </div>
                            <h3 class="text-white font-bold text-lg mb-2">Single Room</h3>
                            <p class="text-blue-100 text-sm mb-4">Perfect for solo travelers with a cozy atmosphere</p>
                            <div class="flex items-center text-blue-200 text-sm">
                                <i class="fas fa-user mr-2"></i>
                                <span>1 Guest</span>
                                <i class="fas fa-wifi ml-4 mr-2"></i>
                                <span>Free WiFi</span>
                            </div>
                            <div class="mt-3 flex items-center">
                                <i class="fas fa-check-circle text-green-400 hidden selected-icon mr-2"></i>
                                <span class="text-xs text-blue-200">Available: 8 rooms</span>
                            </div>
                        </div>

                        <div class="room-card glass-effect border border-white/20 rounded-xl p-5 cursor-pointer" data-room="Double" data-price="200">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 bg-purple-500/20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-bed text-purple-300 text-xl"></i>
                                </div>
                                <span class="text-green-400 font-bold">$200/night</span>
                            </div>
                            <h3 class="text-white font-bold text-lg mb-2">Double Room</h3>
                            <p class="text-blue-100 text-sm mb-4">Spacious room for couples or business travelers</p>
                            <div class="flex items-center text-blue-200 text-sm">
                                <i class="fas fa-user mr-2"></i>
                                <span>2 Guests</span>
                                <i class="fas fa-wifi ml-4 mr-2"></i>
                                <span>Free WiFi</span>
                            </div>
                            <div class="mt-3 flex items-center">
                                <i class="fas fa-check-circle text-green-400 hidden selected-icon mr-2"></i>
                                <span class="text-xs text-blue-200">Available: 5 rooms</span>
                            </div>
                        </div>

                        <div class="room-card glass-effect border border-white/20 rounded-xl p-5 cursor-pointer" data-room="Suite" data-price="350">
                            <div class="flex items-center justify-between mb-4">
                                <div class="w-12 h-12 bg-pink-500/20 rounded-lg flex items-center justify-center">
                                    <i class="fas fa-crown text-pink-300 text-xl"></i>
                                </div>
                                <span class="text-green-400 font-bold">$350/night</span>
                            </div>
                            <h3 class="text-white font-bold text-lg mb-2">Luxury Suite</h3>
                            <p class="text-blue-100 text-sm mb-4">Premium suite with ocean view and amenities</p>
                            <div class="flex items-center text-blue-200 text-sm">
                                <i class="fas fa-user mr-2"></i>
                                <span>4 Guests</span>
                                <i class="fas fa-hot-tub ml-4 mr-2"></i>
                                <span>Jacuzzi</span>
                            </div>
                            <div class="mt-3 flex items-center">
                                <i class="fas fa-check-circle text-green-400 hidden selected-icon mr-2"></i>
                                <span class="text-xs text-blue-200">Available: 3 rooms</span>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden Room Type Input -->
                    <input type="hidden" name="room" id="selectedRoom" value="Single" required>

                    <!-- Dates Selection -->
                    <h2 class="text-2xl font-bold text-white mt-8 mb-6">Stay Details</h2>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-calendar-day mr-2"></i>Check-in Date
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-sign-in-alt text-blue-300"></i>
                                </div>
                                <input
                                        type="date"
                                        name="checkin"
                                        id="checkinDate"
                                        required
                                        class="w-full pl-10 form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                        min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                >
                            </div>
                        </div>

                        <div>
                            <label class="block text-blue-100 text-sm font-medium mb-2">
                                <i class="fas fa-calendar-day mr-2"></i>Check-out Date
                            </label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="fas fa-sign-out-alt text-blue-300"></i>
                                </div>
                                <input
                                        type="date"
                                        name="checkout"
                                        id="checkoutDate"
                                        required
                                        class="w-full pl-10 form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                                >
                            </div>
                        </div>
                    </div>

                    <!-- Number of Guests -->
                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">
                            <i class="fas fa-users mr-2"></i>Number of Guests
                        </label>
                        <select name="guests" class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-white transition duration-300">
                            <option value="1" class="bg-gray-800">1 Guest</option>
                            <option value="2" class="bg-gray-800" selected>2 Guests</option>
                            <option value="3" class="bg-gray-800">3 Guests</option>
                            <option value="4" class="bg-gray-800">4 Guests</option>
                        </select>
                    </div>

                    <!-- Additional Information -->
                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">
                            <i class="fas fa-sticky-note mr-2"></i>Special Requests
                        </label>
                        <textarea
                                name="requests"
                                rows="2"
                                class="w-full form-input bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300 resize-none"
                                placeholder="Any special requirements or requests (e.g., extra bed, dietary restrictions)"
                        ></textarea>
                    </div>

                    <!-- Payment Method -->
                    <div>
                        <label class="block text-blue-100 text-sm font-medium mb-2">
                            <i class="fas fa-credit-card mr-2"></i>Payment Method
                        </label>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                            <label class="flex items-center p-3 glass-effect border border-white/20 rounded-xl cursor-pointer hover:bg-white/10 transition duration-300">
                                <input type="radio" name="payment" value="cash" class="mr-2" checked>
                                <span class="text-white text-sm">Cash</span>
                            </label>
                            <label class="flex items-center p-3 glass-effect border border-white/20 rounded-xl cursor-pointer hover:bg-white/10 transition duration-300">
                                <input type="radio" name="payment" value="card" class="mr-2">
                                <span class="text-white text-sm">Credit Card</span>
                            </label>
                            <label class="flex items-center p-3 glass-effect border border-white/20 rounded-xl cursor-pointer hover:bg-white/10 transition duration-300">
                                <input type="radio" name="payment" value="online" class="mr-2">
                                <span class="text-white text-sm">Online</span>
                            </label>
                            <label class="flex items-center p-3 glass-effect border border-white/20 rounded-xl cursor-pointer hover:bg-white/10 transition duration-300">
                                <input type="radio" name="payment" value="invoice" class="mr-2">
                                <span class="text-white text-sm">Invoice</span>
                            </label>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex flex-col md:flex-row items-center justify-between pt-8 mt-8 border-t border-white/10">
                        <a href="dashboard.jsp" class="flex items-center text-blue-200 hover:text-white transition duration-300 mb-4 md:mb-0">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Back to Dashboard
                        </a>

                        <div class="flex space-x-4">
                            <button type="reset" class="glass-effect border border-white/30 text-white px-6 py-3 rounded-xl hover:bg-white/10 transition duration-300">
                                <i class="fas fa-redo mr-2"></i>Reset Form
                            </button>

                            <button type="submit" class="bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold px-8 py-3 rounded-xl shadow-lg hover:shadow-xl transition duration-300 transform hover:-translate-y-0.5">
                                <i class="fas fa-save mr-2"></i>Add Reservation
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Side Panel - Summary & Tips -->
        <div class="space-y-6">
            <!-- Live Summary Panel -->
            <div class="glass-effect rounded-2xl p-6 sticky top-8 animate-slide-in-right">
                <h3 class="text-xl font-bold text-white mb-6">
                    <i class="fas fa-chart-pie mr-2"></i>Reservation Summary
                </h3>

                <div class="space-y-6">
                    <div class="p-4 bg-white/5 rounded-xl">
                        <h4 class="text-blue-100 text-sm font-medium mb-3">Guest Details</h4>
                        <div id="guestSummary" class="space-y-2">
                            <div class="flex justify-between">
                                <span class="text-blue-200 text-sm">Name:</span>
                                <span id="summaryName" class="text-white text-sm font-medium">Not provided</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-blue-200 text-sm">Contact:</span>
                                <span id="summaryContact" class="text-white text-sm">Not provided</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-blue-200 text-sm">Reservation ID:</span>
                                <span id="summaryId" class="text-white text-sm">-</span>
                            </div>
                        </div>
                    </div>

                    <div class="p-4 bg-white/5 rounded-xl">
                        <h4 class="text-blue-100 text-sm font-medium mb-3">Room Details</h4>
                        <div id="roomSummary" class="space-y-2">
                            <div class="flex justify-between items-center">
                                <span class="text-blue-200 text-sm">Room Type:</span>
                                <span id="summaryRoom" class="text-white font-medium">Single Room</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-blue-200 text-sm">Price per night:</span>
                                <span id="summaryPrice" class="text-green-400 font-bold">$120</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-blue-200 text-sm">Nights:</span>
                                <span id="summaryNights" class="text-white">0</span>
                            </div>
                        </div>
                    </div>

                    <div class="p-4 bg-gradient-to-r from-blue-500/20 to-purple-600/20 rounded-xl">
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-blue-100">Subtotal:</span>
                            <span id="summarySubtotal" class="text-white">$0</span>
                        </div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-blue-100">Tax (10%):</span>
                            <span id="summaryTax" class="text-white">$0</span>
                        </div>
                        <div class="flex justify-between items-center pt-2 border-t border-white/10">
                            <span class="text-white font-bold">Total Amount:</span>
                            <span id="summaryTotal" class="text-2xl font-bold text-green-400">$0</span>
                        </div>
                    </div>

                    <!-- Availability Status -->
                    <div class="p-4 bg-white/5 rounded-xl">
                        <h4 class="text-blue-100 text-sm font-medium mb-3">Room Availability</h4>
                        <div class="space-y-2">
                            <div class="flex justify-between items-center">
                                <span class="text-blue-200 text-sm">Single Rooms:</span>
                                <span class="text-green-400">8 available</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-blue-200 text-sm">Double Rooms:</span>
                                <span class="text-yellow-400">5 available</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-blue-200 text-sm">Suites:</span>
                                <span class="text-orange-400">3 available</span>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Tips -->
                    <div class="p-4 bg-gradient-to-r from-blue-500/10 to-purple-600/10 rounded-xl border border-blue-500/20">
                        <h4 class="text-white text-sm font-medium mb-2">
                            <i class="fas fa-lightbulb mr-2"></i>Quick Tips
                        </h4>
                        <ul class="text-blue-100 text-sm space-y-2">
                            <li class="flex items-start">
                                <i class="fas fa-check text-green-400 mr-2 mt-0.5"></i>
                                <span>Reservation ID should be unique</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-check text-green-400 mr-2 mt-0.5"></i>
                                <span>Check-in time: 2:00 PM, Check-out: 11:00 AM</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-check text-green-400 mr-2 mt-0.5"></i>
                                <span>ID proof required at check-in</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-check text-green-400 mr-2 mt-0.5"></i>
                                <span>Early check-in available on request</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Room selection
        const roomCards = document.querySelectorAll('.room-card');
        const selectedRoomInput = document.getElementById('selectedRoom');
        const roomPrices = {
            'Single': 120,
            'Double': 200,
            'Suite': 350
        };

        roomCards.forEach(card => {
            card.addEventListener('click', function() {
                // Remove selected class and hide check icon from all cards
                roomCards.forEach(c => {
                    c.classList.remove('selected');
                    const icon = c.querySelector('.selected-icon');
                    if (icon) icon.classList.add('hidden');
                });

                // Add selected class to clicked card
                this.classList.add('selected');

                // Show check icon
                const icon = this.querySelector('.selected-icon');
                if (icon) icon.classList.remove('hidden');

                // Update hidden input
                const roomType = this.dataset.room;
                selectedRoomInput.value = roomType;

                // Update summary
                document.getElementById('summaryRoom').textContent = roomType + ' Room';
                document.getElementById('summaryPrice').textContent = '$' + roomPrices[roomType];

                calculateTotal();
            });
        });

        // Set first room as selected by default
        if (roomCards.length > 0) {
            roomCards[0].classList.add('selected');
            const icon = roomCards[0].querySelector('.selected-icon');
            if (icon) icon.classList.remove('hidden');
        }

        // Date pickers with min dates
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('checkinDate').min = today;

        const checkinInput = document.getElementById('checkinDate');
        const checkoutInput = document.getElementById('checkoutDate');

        checkinInput.addEventListener('change', function() {
            const checkinDate = this.value;
            if (checkinDate) {
                const nextDay = new Date(checkinDate);
                nextDay.setDate(nextDay.getDate() + 1);
                const minCheckout = nextDay.toISOString().split('T')[0];
                checkoutInput.min = minCheckout;

                if (checkoutInput.value && checkoutInput.value <= checkinDate) {
                    checkoutInput.value = minCheckout;
                }
            }
            calculateTotal();
            updateSummary();
        });

        checkoutInput.addEventListener('change', calculateTotal);

        // Calculate total function
        function calculateTotal() {
            const checkin = document.getElementById('checkinDate').value;
            const checkout = document.getElementById('checkoutDate').value;
            const roomType = selectedRoomInput.value;

            if (checkin && checkout && roomType) {
                const start = new Date(checkin);
                const end = new Date(checkout);
                const nights = Math.max(0, Math.ceil((end - start) / (1000 * 60 * 60 * 24)));
                const pricePerNight = roomPrices[roomType];
                const subtotal = nights * pricePerNight;
                const tax = subtotal * 0.1; // 10% tax
                const total = subtotal + tax;

                document.getElementById('summaryNights').textContent = nights;
                document.getElementById('summarySubtotal').textContent = '$' + subtotal;
                document.getElementById('summaryTax').textContent = '$' + tax.toFixed(2);
                document.getElementById('summaryTotal').textContent = '$' + total.toFixed(2);
            }
        }

        // Update summary with form data
        function updateSummary() {
            const name = document.getElementsByName('name')[0].value;
            const contact = document.getElementsByName('contact')[0].value;
            const id = document.getElementsByName('id')[0].value;

            document.getElementById('summaryName').textContent = name || 'Not provided';
            document.getElementById('summaryContact').textContent = contact || 'Not provided';
            document.getElementById('summaryId').textContent = id || '-';
        }

        // Listen to form changes
        const formInputs = document.querySelectorAll('#reservationForm input, #reservationForm textarea');
        formInputs.forEach(input => {
            input.addEventListener('input', updateSummary);
        });

        // Form submission
        const form = document.getElementById('reservationForm');
        const submitBtn = form.querySelector('button[type="submit"]');

        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                alert('Please fill in all required fields');
                return;
            }

            // Add loading animation
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Processing...';
            submitBtn.disabled = true;

            // Form will submit normally to the server
            // The loading state will be removed when the page reloads
        });

        // Reset button
        const resetBtn = form.querySelector('button[type="reset"]');
        resetBtn.addEventListener('click', function() {
            setTimeout(() => {
                updateSummary();
                calculateTotal();
                // Reset room selection to default
                roomCards.forEach((card, index) => {
                    if (index === 0) {
                        card.classList.add('selected');
                        const icon = card.querySelector('.selected-icon');
                        if (icon) icon.classList.remove('hidden');
                    } else {
                        card.classList.remove('selected');
                        const icon = card.querySelector('.selected-icon');
                        if (icon) icon.classList.add('hidden');
                    }
                });
                selectedRoomInput.value = 'Single';
            }, 100);
        });

        // Initialize summary
        calculateTotal();

        // Set default dates
        const today_date = new Date();
        const tomorrow = new Date(today_date);
        tomorrow.setDate(tomorrow.getDate() + 1);

        checkinInput.value = today_date.toISOString().split('T')[0];
        checkoutInput.value = tomorrow.toISOString().split('T')[0];
        checkoutInput.min = tomorrow.toISOString().split('T')[0];

        calculateTotal();
    });
</script>
</body>
</html>