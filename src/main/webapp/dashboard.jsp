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
  <title>Admin Dashboard - Ocean View Resort</title>
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

    .stat-card {
      transition: all 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    .dashboard-card {
      transition: all 0.3s ease;
    }

    .dashboard-card:hover {
      transform: translateY(-3px);
    }

    /* Sidebar styling */
    .sidebar {
      width: 260px;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
    }

    .main-content {
      margin-left: 260px;
    }

    @media (max-width: 768px) {
      .sidebar {
        width: 100%;
        height: auto;
        position: relative;
      }

      .main-content {
        margin-left: 0;
      }
    }

    /* Custom animations */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .animate-fade-in {
      animation: fadeIn 0.6s ease-out forwards;
    }

    .notification-badge {
      position: absolute;
      top: -5px;
      right: -5px;
      background-color: #ef4444;
      color: white;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      font-weight: bold;
    }
  </style>
</head>
<body>
<!-- Sidebar -->
<aside class="sidebar glass-effect p-6 overflow-y-auto">
  <!-- Logo -->
  <div class="flex items-center mb-10">
    <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center shadow-lg">
      <i class="fas fa-crown text-white text-xl"></i>
    </div>
    <div class="ml-4">
      <h1 class="text-xl font-bold text-white">Ocean View Resort</h1>
      <p class="text-blue-100 text-sm">Admin Panel</p>
    </div>
  </div>

  <!-- User Profile -->
  <div class="glass-effect rounded-xl p-4 mb-8 border border-white/10">
    <div class="flex items-center">
      <div class="w-14 h-14 bg-gradient-to-r from-blue-300 to-purple-400 rounded-full flex items-center justify-center shadow-md">
        <i class="fas fa-user-circle text-white text-2xl"></i>
      </div>
      <div class="ml-4">
        <h2 class="text-lg font-bold text-white"><%= user.getUsername() %></h2>
        <p class="text-blue-100 text-sm">Administrator</p>
      </div>
      <span class="ml-auto relative">
                    <i class="fas fa-bell text-blue-200 text-xl cursor-pointer"></i>
                    <span class="notification-badge">3</span>
                </span>
    </div>
  </div>

  <!-- Navigation -->
  <nav>
    <ul class="space-y-2">
      <li>
        <a href="#" class="flex items-center p-3 text-white bg-white/20 rounded-lg hover:bg-white/30 transition duration-300">
          <i class="fas fa-tachometer-alt mr-3"></i>
          Dashboard
        </a>
      </li>
      <li>
        <a href="addReservation.jsp" class="flex items-center p-3 text-blue-100 hover:text-white hover:bg-white/10 rounded-lg transition duration-300">
          <i class="fas fa-calendar-plus mr-3"></i>
          Add Reservation
        </a>
      </li>
      <li>
        <a href="viewReservation.jsp" class="flex items-center p-3 text-blue-100 hover:text-white hover:bg-white/10 rounded-lg transition duration-300">
          <i class="fas fa-list-alt mr-3"></i>
          View Reservations
        </a>
      </li>
      <li>
        <a href="bill.jsp" class="flex items-center p-3 text-blue-100 hover:text-white hover:bg-white/10 rounded-lg transition duration-300">
          <i class="fas fa-file-invoice-dollar mr-3"></i>
          Generate Bill
        </a>
      </li>
      <li>
        <a href="help.jsp" class="flex items-center p-3 text-blue-100 hover:text-white hover:bg-white/10 rounded-lg transition duration-300">
          <i class="fas fa-question-circle mr-3"></i>
          Help & Support
        </a>
      </li>
      <li>
        <a href="logout.jsp" class="flex items-center p-3 text-red-200 hover:text-red-100 hover:bg-red-500/20 rounded-lg transition duration-300 mt-8">
          <i class="fas fa-sign-out-alt mr-3"></i>
          Logout
        </a>
      </li>
    </ul>
  </nav>

  <!-- Sidebar Footer -->
  <div class="mt-auto pt-8 border-t border-white/10">
    <p class="text-blue-100 text-sm text-center">
      &copy; 2024 Ocean View Resort<br>
      <span class="text-xs">v2.1.0 • Admin Panel</span>
    </p>
  </div>
</aside>

<!-- Main Content -->
<main class="main-content p-8">
  <!-- Header -->
  <div class="flex justify-between items-center mb-8 animate-fade-in">
    <div>
      <h1 class="text-3xl font-bold text-white">Admin Dashboard</h1>
      <p class="text-blue-100">Welcome back, <span class="font-semibold text-white"><%= user.getUsername() %></span>! Here's what's happening today.</p>
    </div>
    <div class="flex items-center space-x-4">
      <div class="relative">
        <input type="text" placeholder="Search..." class="glass-effect border border-white/30 text-white placeholder-blue-200 rounded-lg pl-10 pr-4 py-2 focus:outline-none focus:border-white w-64">
        <i class="fas fa-search absolute left-3 top-3 text-blue-300"></i>
      </div>
      <div class="relative">
        <button class="glass-effect border border-white/30 text-white p-3 rounded-lg hover:bg-white/10 transition duration-300">
          <i class="fas fa-cog"></i>
        </button>
      </div>
    </div>
  </div>

  <!-- Stats Cards -->
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
    <div class="glass-effect rounded-2xl p-6 stat-card border border-white/10">
      <div class="flex items-center">
        <div class="w-14 h-14 bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl flex items-center justify-center mr-4">
          <i class="fas fa-bed text-white text-2xl"></i>
        </div>
        <div>
          <h3 class="text-blue-100 text-sm font-medium">Total Reservations</h3>
          <p class="text-2xl font-bold text-white">42</p>
        </div>
      </div>
      <div class="mt-4 pt-4 border-t border-white/10">
        <span class="text-green-400 text-sm"><i class="fas fa-arrow-up mr-1"></i> 12% from last month</span>
      </div>
    </div>

    <div class="glass-effect rounded-2xl p-6 stat-card border border-white/10">
      <div class="flex items-center">
        <div class="w-14 h-14 bg-gradient-to-r from-purple-500 to-pink-500 rounded-xl flex items-center justify-center mr-4">
          <i class="fas fa-users text-white text-2xl"></i>
        </div>
        <div>
          <h3 class="text-blue-100 text-sm font-medium">Active Guests</h3>
          <p class="text-2xl font-bold text-white">18</p>
        </div>
      </div>
      <div class="mt-4 pt-4 border-t border-white/10">
        <span class="text-green-400 text-sm"><i class="fas fa-arrow-up mr-1"></i> 5 currently checked-in</span>
      </div>
    </div>

    <div class="glass-effect rounded-2xl p-6 stat-card border border-white/10">
      <div class="flex items-center">
        <div class="w-14 h-14 bg-gradient-to-r from-green-500 to-teal-500 rounded-xl flex items-center justify-center mr-4">
          <i class="fas fa-dollar-sign text-white text-2xl"></i>
        </div>
        <div>
          <h3 class="text-blue-100 text-sm font-medium">Revenue</h3>
          <p class="text-2xl font-bold text-white">$12,450</p>
        </div>
      </div>
      <div class="mt-4 pt-4 border-t border-white/10">
        <span class="text-green-400 text-sm"><i class="fas fa-arrow-up mr-1"></i> 24% from last month</span>
      </div>
    </div>

    <div class="glass-effect rounded-2xl p-6 stat-card border border-white/10">
      <div class="flex items-center">
        <div class="w-14 h-14 bg-gradient-to-r from-yellow-500 to-orange-500 rounded-xl flex items-center justify-center mr-4">
          <i class="fas fa-star text-white text-2xl"></i>
        </div>
        <div>
          <h3 class="text-blue-100 text-sm font-medium">Occupancy Rate</h3>
          <p class="text-2xl font-bold text-white">78%</p>
        </div>
      </div>
      <div class="mt-4 pt-4 border-t border-white/10">
        <span class="text-red-400 text-sm"><i class="fas fa-arrow-down mr-1"></i> 3% from last week</span>
      </div>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="glass-effect rounded-2xl p-6 mb-8 border border-white/10">
    <h2 class="text-xl font-bold text-white mb-6">Quick Actions</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
      <a href="addReservation.jsp" class="dashboard-card bg-gradient-to-r from-blue-500/20 to-blue-600/20 border border-blue-500/30 rounded-xl p-5 text-center hover:from-blue-500/30 hover:to-blue-600/30 transition duration-300">
        <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-3">
          <i class="fas fa-plus text-white text-xl"></i>
        </div>
        <h3 class="text-white font-medium">New Reservation</h3>
        <p class="text-blue-100 text-sm mt-1">Add a new booking</p>
      </a>

      <a href="viewReservation.jsp" class="dashboard-card bg-gradient-to-r from-purple-500/20 to-purple-600/20 border border-purple-500/30 rounded-xl p-5 text-center hover:from-purple-500/30 hover:to-purple-600/30 transition duration-300">
        <div class="w-12 h-12 bg-purple-500 rounded-full flex items-center justify-center mx-auto mb-3">
          <i class="fas fa-eye text-white text-xl"></i>
        </div>
        <h3 class="text-white font-medium">View Bookings</h3>
        <p class="text-blue-100 text-sm mt-1">All reservations</p>
      </a>

      <a href="bill.jsp" class="dashboard-card bg-gradient-to-r from-green-500/20 to-green-600/20 border border-green-500/30 rounded-xl p-5 text-center hover:from-green-500/30 hover:to-green-600/30 transition duration-300">
        <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-3">
          <i class="fas fa-file-invoice text-white text-xl"></i>
        </div>
        <h3 class="text-white font-medium">Generate Bill</h3>
        <p class="text-blue-100 text-sm mt-1">Print invoices</p>
      </a>

      <a href="help.jsp" class="dashboard-card bg-gradient-to-r from-yellow-500/20 to-yellow-600/20 border border-yellow-500/30 rounded-xl p-5 text-center hover:from-yellow-500/30 hover:to-yellow-600/30 transition duration-300">
        <div class="w-12 h-12 bg-yellow-500 rounded-full flex items-center justify-center mx-auto mb-3">
          <i class="fas fa-question text-white text-xl"></i>
        </div>
        <h3 class="text-white font-medium">Help Center</h3>
        <p class="text-blue-100 text-sm mt-1">Support & guides</p>
      </a>
    </div>
  </div>

  <!-- Recent Activity -->
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
    <div class="glass-effect rounded-2xl p-6 border border-white/10">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-bold text-white">Recent Reservations</h2>
        <a href="viewReservation.jsp" class="text-blue-200 hover:text-white text-sm transition duration-300">View All</a>
      </div>
      <div class="space-y-4">
        <div class="flex items-center justify-between p-3 bg-white/5 rounded-lg">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-user text-blue-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">John Smith</h4>
              <p class="text-blue-100 text-sm">Deluxe Suite • 3 nights</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-white font-medium">$1,250</p>
            <span class="text-green-400 text-xs font-medium bg-green-400/20 px-2 py-1 rounded-full">Confirmed</span>
          </div>
        </div>

        <div class="flex items-center justify-between p-3 bg-white/5 rounded-lg">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-user text-purple-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Emma Wilson</h4>
              <p class="text-blue-100 text-sm">Ocean View • 5 nights</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-white font-medium">$2,100</p>
            <span class="text-yellow-400 text-xs font-medium bg-yellow-400/20 px-2 py-1 rounded-full">Pending</span>
          </div>
        </div>

        <div class="flex items-center justify-between p-3 bg-white/5 rounded-lg">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-user text-green-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Robert Brown</h4>
              <p class="text-blue-100 text-sm">Family Room • 7 nights</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-white font-medium">$3,150</p>
            <span class="text-green-400 text-xs font-medium bg-green-400/20 px-2 py-1 rounded-full">Checked-in</span>
          </div>
        </div>
      </div>
    </div>

    <div class="glass-effect rounded-2xl p-6 border border-white/10">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-bold text-white">System Status</h2>
        <span class="text-green-400 text-sm font-medium bg-green-400/20 px-3 py-1 rounded-full">All Systems Operational</span>
      </div>
      <div class="space-y-4">
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-database text-blue-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Database</h4>
              <p class="text-blue-100 text-sm">Reservation records</p>
            </div>
          </div>
          <span class="text-green-400 text-sm font-medium">Online</span>
        </div>

        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-server text-purple-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Application Server</h4>
              <p class="text-blue-100 text-sm">Hotel management system</p>
            </div>
          </div>
          <span class="text-green-400 text-sm font-medium">Online</span>
        </div>

        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-print text-green-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Billing System</h4>
              <p class="text-blue-100 text-sm">Invoice generation</p>
            </div>
          </div>
          <span class="text-green-400 text-sm font-medium">Online</span>
        </div>

        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <div class="w-10 h-10 bg-yellow-500/20 rounded-lg flex items-center justify-center mr-3">
              <i class="fas fa-shield-alt text-yellow-300"></i>
            </div>
            <div>
              <h4 class="text-white font-medium">Security</h4>
              <p class="text-blue-100 text-sm">User authentication</p>
            </div>
          </div>
          <span class="text-green-400 text-sm font-medium">Online</span>
        </div>
      </div>
    </div>
  </div>
</main>

<!-- JavaScript for interactivity -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Notification click handler
    const notificationBtn = document.querySelector('.fa-bell').parentElement;
    notificationBtn.addEventListener('click', function() {
      alert('You have 3 new notifications:\n1. New reservation from John Smith\n2. Room 203 check-out reminder\n3. System backup completed');
    });

    // Search functionality
    const searchInput = document.querySelector('input[type="text"]');
    searchInput.addEventListener('keypress', function(e) {
      if(e.key === 'Enter') {
        alert('Searching for: ' + this.value);
      }
    });

    // Settings button
    const settingsBtn = document.querySelector('.fa-cog').parentElement;
    settingsBtn.addEventListener('click', function() {
      alert('Settings panel will open here in the full implementation.');
    });

    // Animate stats cards on load
    const statCards = document.querySelectorAll('.stat-card');
    statCards.forEach((card, index) => {
      card.style.animationDelay = `${index * 0.1}s`;
      card.classList.add('animate-fade-in');
    });
  });
</script>
</body>
</html>