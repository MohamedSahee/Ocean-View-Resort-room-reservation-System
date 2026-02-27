<%--
  Created by IntelliJ IDEA.
  User: msahe
  Date: 1/11/2026
  Time: 11:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.icbt.hotel.oceanview.model.User" %>
<%@ page import="java.util.Date" %>
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
    <title>Help & Support - Ocean View Resort</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
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

        .help-card {
            transition: all 0.3s ease;
        }

        .help-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .faq-item {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .faq-item:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .faq-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
        }

        .faq-item.active .faq-answer {
            max-height: 200px;
        }

        .faq-item.active .faq-question i {
            transform: rotate(90deg);
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
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in {
            animation: fadeIn 0.6s ease-out forwards;
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

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.7;
            }
        }

        .animate-pulse-slow {
            animation: pulse 2s infinite;
        }

        /* Status indicators */
        .status-online {
            background-color: rgba(34, 197, 94, 0.2);
            color: #22c55e;
            border: 1px solid rgba(34, 197, 94, 0.3);
        }

        .status-maintenance {
            background-color: rgba(234, 179, 8, 0.2);
            color: #eab308;
            border: 1px solid rgba(234, 179, 8, 0.3);
        }
    </style>
</head>
<body class="p-4 md:p-8">
<!-- Header -->
<header class="flex items-center justify-between mb-8">
    <div class="flex items-center">
        <a href="dashboard.jsp" class="text-white hover:text-blue-200 transition duration-300 mr-4">
            <i class="fas fa-arrow-left text-xl"></i>
        </a>
        <div>
            <h1 class="text-3xl font-bold text-white">Help & Support Center</h1>
            <p class="text-blue-100">Documentation and assistance for Ocean View Resort system</p>
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
    <!-- Welcome Banner -->
    <div class="glass-effect rounded-2xl p-8 mb-8 animate-fade-in">
        <div class="flex items-center justify-between">
            <div>
                <h2 class="text-2xl font-bold text-white mb-2">
                    <i class="fas fa-hands-helping mr-3"></i>Welcome to the Help Center
                </h2>
                <p class="text-blue-100 text-lg">Find answers to common questions and learn how to use the Ocean View Resort Management System effectively.</p>
            </div>
            <div class="hidden md:block">
                <div class="w-24 h-24 bg-gradient-to-r from-blue-500/20 to-purple-600/20 rounded-full flex items-center justify-center">
                    <i class="fas fa-question-circle text-white text-4xl"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Guide Section -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="glass-effect rounded-2xl p-6 help-card animate-fade-in" style="animation-delay: 0.1s">
            <div class="w-14 h-14 bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl flex items-center justify-center mb-4">
                <i class="fas fa-sign-in-alt text-white text-xl"></i>
            </div>
            <h3 class="text-white font-bold text-lg mb-2">1. Login</h3>
            <p class="text-blue-100 text-sm mb-4">Access the system using your admin credentials</p>
            <div class="text-blue-200 text-xs">
                <i class="fas fa-check-circle text-green-400 mr-1"></i> Secure authentication
            </div>
        </div>

        <div class="glass-effect rounded-2xl p-6 help-card animate-fade-in" style="animation-delay: 0.2s">
            <div class="w-14 h-14 bg-gradient-to-r from-purple-500 to-purple-600 rounded-xl flex items-center justify-center mb-4">
                <i class="fas fa-calendar-plus text-white text-xl"></i>
            </div>
            <h3 class="text-white font-bold text-lg mb-2">2. Add Reservation</h3>
            <p class="text-blue-100 text-sm mb-4">Register new guests and create bookings</p>
            <div class="text-blue-200 text-xs">
                <i class="fas fa-check-circle text-green-400 mr-1"></i> Real-time availability
            </div>
        </div>

        <div class="glass-effect rounded-2xl p-6 help-card animate-fade-in" style="animation-delay: 0.3s">
            <div class="w-14 h-14 bg-gradient-to-r from-green-500 to-green-600 rounded-xl flex items-center justify-center mb-4">
                <i class="fas fa-search text-white text-xl"></i>
            </div>
            <h3 class="text-white font-bold text-lg mb-2">3. View Reservations</h3>
            <p class="text-blue-100 text-sm mb-4">Search and manage existing bookings</p>
            <div class="text-blue-200 text-xs">
                <i class="fas fa-check-circle text-green-400 mr-1"></i> Advanced search
            </div>
        </div>

        <div class="glass-effect rounded-2xl p-6 help-card animate-fade-in" style="animation-delay: 0.4s">
            <div class="w-14 h-14 bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-xl flex items-center justify-center mb-4">
                <i class="fas fa-file-invoice-dollar text-white text-xl"></i>
            </div>
            <h3 class="text-white font-bold text-lg mb-2">4. Calculate Bill</h3>
            <p class="text-blue-100 text-sm mb-4">Generate invoices and process payments</p>
            <div class="text-blue-200 text-xs">
                <i class="fas fa-check-circle text-green-400 mr-1"></i> PDF/Print options
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Main Help Content -->
        <div class="lg:col-span-2 space-y-6">
            <!-- Basic Instructions -->
            <div class="glass-effect rounded-2xl p-8 animate-fade-in" style="animation-delay: 0.2s">
                <h2 class="text-2xl font-bold text-white mb-6">
                    <i class="fas fa-clipboard-list mr-3"></i>System Overview
                </h2>

                <div class="space-y-6">
                    <div class="flex items-start p-4 bg-white/5 rounded-xl">
                        <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fas fa-key text-blue-300"></i>
                        </div>
                        <div>
                            <h3 class="text-white font-bold mb-2">Login Authentication</h3>
                            <p class="text-blue-100 text-sm">Access the system using your admin credentials. Always logout after finishing your work to maintain security. Session will automatically expire after 30 minutes of inactivity.</p>
                        </div>
                    </div>

                    <div class="flex items-start p-4 bg-white/5 rounded-xl">
                        <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fas fa-user-plus text-purple-300"></i>
                        </div>
                        <div>
                            <h3 class="text-white font-bold mb-2">Adding Reservations</h3>
                            <p class="text-blue-100 text-sm">Use "Add Reservation" to register new guests. Fill in all required fields: Reservation ID, Guest Name, Contact Number, Room Type, Check-in and Check-out dates. The system will automatically calculate the stay duration.</p>
                        </div>
                    </div>

                    <div class="flex items-start p-4 bg-white/5 rounded-xl">
                        <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fas fa-eye text-green-300"></i>
                        </div>
                        <div>
                            <h3 class="text-white font-bold mb-2">Viewing Reservations</h3>
                            <p class="text-blue-100 text-sm">Use "View Reservation" to see booking details. You can search by Reservation ID, Guest Name, or Contact Number. The system displays complete guest information and booking status.</p>
                        </div>
                    </div>

                    <div class="flex items-start p-4 bg-white/5 rounded-xl">
                        <div class="w-10 h-10 bg-yellow-500/20 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
                            <i class="fas fa-calculator text-yellow-300"></i>
                        </div>
                        <div>
                            <h3 class="text-white font-bold mb-2">Billing Process</h3>
                            <p class="text-blue-100 text-sm">Use "Calculate Bill" to compute total stay cost. The system automatically calculates nights, applies room rates, adds taxes (10%) and service charges (5%). You can print, download PDF, or email the invoice.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- FAQ Section -->
            <div class="glass-effect rounded-2xl p-8 animate-fade-in" style="animation-delay: 0.3s">
                <h2 class="text-2xl font-bold text-white mb-6">
                    <i class="fas fa-question-circle mr-3"></i>Frequently Asked Questions
                </h2>

                <div class="space-y-4">
                    <!-- FAQ Item 1 -->
                    <div class="faq-item glass-effect border border-white/10 rounded-xl p-4">
                        <div class="faq-question flex justify-between items-center">
                            <h3 class="text-white font-medium">How do I reset my password?</h3>
                            <i class="fas fa-chevron-right text-blue-300 transition-transform duration-300"></i>
                        </div>
                        <div class="faq-answer mt-2">
                            <p class="text-blue-100 text-sm">Contact your system administrator to reset your password. For security reasons, password resets cannot be done through the interface. New temporary passwords will be provided securely.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 2 -->
                    <div class="faq-item glass-effect border border-white/10 rounded-xl p-4">
                        <div class="faq-question flex justify-between items-center">
                            <h3 class="text-white font-medium">Can I modify a reservation after creation?</h3>
                            <i class="fas fa-chevron-right text-blue-300 transition-transform duration-300"></i>
                        </div>
                        <div class="faq-answer mt-2">
                            <p class="text-blue-100 text-sm">Yes, you can modify existing reservations from the View Reservation page. Search for the reservation and click the Edit button. You can update guest details, dates, and room type.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 3 -->
                    <div class="faq-item glass-effect border border-white/10 rounded-xl p-4">
                        <div class="faq-question flex justify-between items-center">
                            <h3 class="text-white font-medium">How do I handle early check-out?</h3>
                            <i class="fas fa-chevron-right text-blue-300 transition-transform duration-300"></i>
                        </div>
                        <div class="faq-answer mt-2">
                            <p class="text-blue-100 text-sm">For early check-out, go to the reservation details and use the Check-out button. The system will recalculate the bill for actual nights stayed and process the final payment.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="faq-item glass-effect border border-white/10 rounded-xl p-4">
                        <div class="faq-question flex justify-between items-center">
                            <h3 class="text-white font-medium">What payment methods are accepted?</h3>
                            <i class="fas fa-chevron-right text-blue-300 transition-transform duration-300"></i>
                        </div>
                        <div class="faq-answer mt-2">
                            <p class="text-blue-100 text-sm">The system supports cash, credit card, online payments, and invoice billing. Payment method can be selected during bill calculation. All transactions are logged for audit purposes.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 5 -->
                    <div class="faq-item glass-effect border border-white/10 rounded-xl p-4">
                        <div class="faq-question flex justify-between items-center">
                            <h3 class="text-white font-medium">How do I generate reports?</h3>
                            <i class="fas fa-chevron-right text-blue-300 transition-transform duration-300"></i>
                        </div>
                        <div class="faq-answer mt-2">
                            <p class="text-blue-100 text-sm">Reports are generated automatically. You can view daily summaries, revenue reports, and occupancy statistics on the dashboard and billing pages. PDF export is available for all reports.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Video Tutorials Placeholder -->
            <div class="glass-effect rounded-2xl p-8 animate-fade-in" style="animation-delay: 0.4s">
                <h2 class="text-2xl font-bold text-white mb-6">
                    <i class="fas fa-play-circle mr-3"></i>Video Tutorials
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="glass-effect border border-white/10 rounded-xl p-4 hover:bg-white/5 transition duration-300 cursor-pointer">
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-red-500/20 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-play text-red-300"></i>
                            </div>
                            <div>
                                <h3 class="text-white font-medium">Getting Started</h3>
                                <p class="text-blue-100 text-xs">5:30 min</p>
                            </div>
                        </div>
                    </div>

                    <div class="glass-effect border border-white/10 rounded-xl p-4 hover:bg-white/5 transition duration-300 cursor-pointer">
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-red-500/20 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-play text-red-300"></i>
                            </div>
                            <div>
                                <h3 class="text-white font-medium">Managing Reservations</h3>
                                <p class="text-blue-100 text-xs">8:45 min</p>
                            </div>
                        </div>
                    </div>

                    <div class="glass-effect border border-white/10 rounded-xl p-4 hover:bg-white/5 transition duration-300 cursor-pointer">
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-red-500/20 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-play text-red-300"></i>
                            </div>
                            <div>
                                <h3 class="text-white font-medium">Billing & Invoices</h3>
                                <p class="text-blue-100 text-xs">6:20 min</p>
                            </div>
                        </div>
                    </div>

                    <div class="glass-effect border border-white/10 rounded-xl p-4 hover:bg-white/5 transition duration-300 cursor-pointer">
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-red-500/20 rounded-lg flex items-center justify-center mr-3">
                                <i class="fas fa-play text-red-300"></i>
                            </div>
                            <div>
                                <h3 class="text-white font-medium">Reports & Analytics</h3>
                                <p class="text-blue-100 text-xs">4:15 min</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Side Panel -->
        <div class="space-y-6">
            <!-- Contact Support -->
            <div class="glass-effect rounded-2xl p-6 animate-slide-in-right">
                <h3 class="text-xl font-bold text-white mb-6">
                    <i class="fas fa-headset mr-2"></i>Contact Support
                </h3>

                <div class="space-y-4">
                    <div class="flex items-center p-3 bg-white/5 rounded-lg">
                        <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-phone text-blue-300"></i>
                        </div>
                        <div>
                            <p class="text-blue-200 text-xs">Phone Support</p>
                            <p class="text-white font-medium">+1 (555) 123-4567</p>
                        </div>
                    </div>

                    <div class="flex items-center p-3 bg-white/5 rounded-lg">
                        <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-envelope text-purple-300"></i>
                        </div>
                        <div>
                            <p class="text-blue-200 text-xs">Email Support</p>
                            <p class="text-white font-medium">support@oceanview.com</p>
                        </div>
                    </div>

                    <div class="flex items-center p-3 bg-white/5 rounded-lg">
                        <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-clock text-green-300"></i>
                        </div>
                        <div>
                            <p class="text-blue-200 text-xs">Working Hours</p>
                            <p class="text-white font-medium">24/7 Support</p>
                        </div>
                    </div>

                    <div class="flex items-center p-3 bg-white/5 rounded-lg">
                        <div class="w-10 h-10 bg-yellow-500/20 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-globe text-yellow-300"></i>
                        </div>
                        <div>
                            <p class="text-blue-200 text-xs">Emergency</p>
                            <p class="text-white font-medium">+1 (555) 999-8888</p>
                        </div>
                    </div>
                </div>

                <button class="w-full mt-6 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold py-3 rounded-xl transition duration-300">
                    <i class="fas fa-ticket-alt mr-2"></i>Create Support Ticket
                </button>
            </div>

            <!-- System Status -->
            <div class="glass-effect rounded-2xl p-6">
                <h3 class="text-xl font-bold text-white mb-6">
                    <i class="fas fa-server mr-2"></i>System Status
                </h3>

                <div class="space-y-3">
                    <div class="flex justify-between items-center p-3 bg-white/5 rounded-lg">
                        <span class="text-blue-100">Reservation System</span>
                        <span class="status-online px-3 py-1 rounded-full text-xs">Online</span>
                    </div>

                    <div class="flex justify-between items-center p-3 bg-white/5 rounded-lg">
                        <span class="text-blue-100">Database</span>
                        <span class="status-online px-3 py-1 rounded-full text-xs">Online</span>
                    </div>

                    <div class="flex justify-between items-center p-3 bg-white/5 rounded-lg">
                        <span class="text-blue-100">Billing Service</span>
                        <span class="status-online px-3 py-1 rounded-full text-xs">Online</span>
                    </div>

                    <div class="flex justify-between items-center p-3 bg-white/5 rounded-lg">
                        <span class="text-blue-100">Email Service</span>
                        <span class="status-maintenance px-3 py-1 rounded-full text-xs">Maintenance</span>
                    </div>
                </div>

                <div class="mt-4 p-3 bg-white/5 rounded-lg">
                    <p class="text-blue-100 text-xs">Last updated: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()) %></p>
                </div>
            </div>

            <!-- Download Resources -->
            <div class="glass-effect rounded-2xl p-6">
                <h3 class="text-xl font-bold text-white mb-6">
                    <i class="fas fa-download mr-2"></i>Resources
                </h3>

                <div class="space-y-3">
                    <a href="#" class="flex items-center p-3 bg-white/5 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-file-pdf text-red-400 mr-3"></i>
                        <span class="text-white">User Manual (PDF)</span>
                    </a>

                    <a href="#" class="flex items-center p-3 bg-white/5 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-file-excel text-green-400 mr-3"></i>
                        <span class="text-white">Quick Reference Guide</span>
                    </a>

                    <a href="#" class="flex items-center p-3 bg-white/5 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-video text-purple-400 mr-3"></i>
                        <span class="text-white">Training Videos</span>
                    </a>

                    <a href="#" class="flex items-center p-3 bg-white/5 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-keyboard text-yellow-400 mr-3"></i>
                        <span class="text-white">Keyboard Shortcuts</span>
                    </a>
                </div>
            </div>

            <!-- Feedback -->
            <div class="glass-effect rounded-2xl p-6 bg-gradient-to-r from-blue-500/10 to-purple-600/10">
                <h4 class="text-white font-bold mb-2">Was this help page useful?</h4>
                <p class="text-blue-100 text-sm mb-4">Your feedback helps us improve our documentation.</p>

                <div class="flex space-x-2">
                    <button class="flex-1 glass-effect border border-white/20 text-white py-2 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-smile text-green-400 mr-1"></i> Yes
                    </button>
                    <button class="flex-1 glass-effect border border-white/20 text-white py-2 rounded-lg hover:bg-white/10 transition duration-300">
                        <i class="fas fa-frown text-red-400 mr-1"></i> No
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Note -->
    <div class="text-center mt-8 text-blue-200 text-sm">
        <p>Need more help? Contact our support team or refer to the complete documentation.</p>
        <p class="mt-2">Ocean View Resort Management System v2.1.0 &copy; 2026</p>
    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // FAQ accordion functionality
        const faqItems = document.querySelectorAll('.faq-item');

        faqItems.forEach(item => {
            item.addEventListener('click', function() {
                this.classList.toggle('active');

                // Close other items
                faqItems.forEach(otherItem => {
                    if (otherItem !== this) {
                        otherItem.classList.remove('active');
                    }
                });
            });
        });

        // Video tutorial click handlers
        const videoTutorials = document.querySelectorAll('.glass-effect.border.border-white\\/10.cursor-pointer');
        videoTutorials.forEach(video => {
            video.addEventListener('click', function() {
                const title = this.querySelector('h3').textContent;
                alert('Video tutorial: "' + title + '" will open here.\n\nIn production, this would play a tutorial video.');
            });
        });

        // Support ticket button
        const ticketBtn = document.querySelector('button:contains("Create Support Ticket")');
        if (ticketBtn) {
            ticketBtn.addEventListener('click', function() {
                alert('Support ticket system will open here.\n\nIn production, this would:\n1. Open ticket creation form\n2. Log the support request\n3. Send confirmation email');
            });
        }

        // Resource download links
        const resourceLinks = document.querySelectorAll('.hover\\:bg-white\\/10');
        resourceLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const resource = this.querySelector('span').textContent;
                alert('Downloading: ' + resource + '\n\nIn production, this would download the actual file.');
            });
        });

        // Feedback buttons
        const feedbackBtns = document.querySelectorAll('.flex.space-x-2 button');
        feedbackBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const feedback = this.textContent.trim();
                alert('Thank you for your feedback: ' + feedback + '\n\nWe appreciate your input!');

                // Disable both buttons after feedback
                feedbackBtns.forEach(b => b.disabled = true);
            });
        });

        // Contact support click handlers
        const contactItems = document.querySelectorAll('.bg-white\\/5.rounded-lg');
        contactItems.forEach(item => {
            if (item.querySelector('.text-white.font-medium')) {
                item.addEventListener('click', function() {
                    const contactType = this.querySelector('.text-blue-200').textContent;
                    const contactValue = this.querySelector('.text-white.font-medium').textContent;

                    if (contactType.includes('Phone') || contactType.includes('Emergency')) {
                        alert('Calling: ' + contactValue + '\n\nIn production, this would initiate a call or show dialer.');
                    } else if (contactType.includes('Email')) {
                        alert('Opening email client to: ' + contactValue);
                    }
                });
            }
        });
    });
</script>
</body>
</html>