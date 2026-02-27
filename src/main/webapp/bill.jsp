<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.icbt.hotel.oceanview.model.User" %>
<%@ page import="com.icbt.hotel.oceanview.model.Reservation" %>
<%@ page import="java.util.Date" %>

<%
  User user = (User) session.getAttribute("admin");
  if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }

  Reservation r = (Reservation) request.getAttribute("reservation");
  Double total = (Double) request.getAttribute("total");
  String error = (String) request.getAttribute("error");

  long nights = 0;
  if (r != null && r.getCheckin() != null && r.getCheckout() != null) {
    Date checkinDate = r.getCheckin();
    Date checkoutDate = r.getCheckout();   // ✅ renamed (NOT "out")
    long diffMs = checkoutDate.getTime() - checkinDate.getTime();
    nights = Math.max(1, diffMs / (1000L * 60 * 60 * 24));
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Generate Bill - Ocean View Resort</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .glass {
      background: rgba(255,255,255,0.12);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.18);
    }
    @media print {
      .no-print { display: none !important; }
      body { background: white !important; }
      .glass { background: white !important; border: none !important; }
    }
  </style>
</head>

<body class="p-4 md:p-8">

<!-- Header -->
<header class="flex items-center justify-between mb-8 no-print">
  <div class="flex items-center">
    <a href="<%= request.getContextPath() %>/dashboard.jsp"
       class="text-white hover:text-blue-200 transition duration-300 mr-4">
      <i class="fas fa-arrow-left text-xl"></i>
    </a>
    <div>
      <h1 class="text-3xl font-bold text-white">Generate Bill</h1>
      <p class="text-blue-100">Calculate and print guest invoice</p>
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

<div class="max-w-4xl mx-auto space-y-6">

  <!-- Search Form -->
  <div class="glass rounded-2xl p-8 no-print">
    <h2 class="text-2xl font-bold text-white mb-5">
      <i class="fas fa-receipt mr-2"></i>Find Reservation
    </h2>

    <form action="<%= request.getContextPath() %>/bill" method="post" class="flex flex-col md:flex-row gap-4">
      <div class="flex-grow">
        <label class="block text-blue-100 text-sm font-medium mb-2">Reservation ID</label>
        <input type="number" name="id" required
               class="w-full bg-white/20 border border-white/30 rounded-xl px-4 py-3 text-white placeholder-blue-200 focus:outline-none focus:border-white"
               placeholder="Enter reservation ID">
      </div>

      <div class="md:self-end">
        <button type="submit"
                class="w-full md:w-auto bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold px-8 py-3 rounded-xl shadow-lg hover:shadow-xl transition">
          <i class="fas fa-calculator mr-2"></i>Calculate
        </button>
      </div>
    </form>

    <% if (error != null) { %>
    <div class="mt-5 p-4 rounded-xl bg-red-500/10 border border-red-500/30 text-red-200">
      <i class="fas fa-triangle-exclamation mr-2"></i><%= error %>
    </div>
    <% } %>
  </div>

  <!-- Bill Output -->
  <% if (r != null && total != null) { %>
  <div class="glass rounded-2xl p-8">
    <div class="flex items-start justify-between">
      <div>
        <h2 class="text-3xl font-bold text-white">INVOICE</h2>
        <p class="text-blue-100 mt-1">Ocean View Resort</p>
        <p class="text-blue-100 text-sm">Luxury by the Sea</p>
      </div>

      <div class="text-right">
        <p class="text-white font-bold text-lg">#INV-<%= r.getId() %></p>
        <p class="text-blue-100 text-sm">Reservation ID: <%= r.getId() %></p>
        <p class="text-blue-100 text-sm">Payment: <%= r.getPayment() != null ? r.getPayment() : "cash" %></p>
      </div>
    </div>

    <hr class="my-6 border-white/20">

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="p-5 rounded-xl bg-white/5 border border-white/10">
        <h3 class="text-white font-bold mb-3">Guest Details</h3>
        <p class="text-blue-100"><b class="text-white">Name:</b> <%= r.getName() %></p>
        <p class="text-blue-100"><b class="text-white">Contact:</b> <%= r.getContact() %></p>
        <p class="text-blue-100"><b class="text-white">Email:</b> <%= r.getEmail() %></p>
        <p class="text-blue-100"><b class="text-white">Address:</b> <%= r.getAddress() %></p>
      </div>

      <div class="p-5 rounded-xl bg-white/5 border border-white/10">
        <h3 class="text-white font-bold mb-3">Stay Details</h3>
        <p class="text-blue-100"><b class="text-white">Room:</b> <%= r.getRoom() %></p>
        <p class="text-blue-100"><b class="text-white">Check-in:</b> <%= r.getCheckin() %></p>
        <p class="text-blue-100"><b class="text-white">Check-out:</b> <%= r.getCheckout() %></p>
        <p class="text-blue-100"><b class="text-white">Nights:</b> <%= nights %></p>
        <p class="text-blue-100"><b class="text-white">Guests:</b> <%= r.getGuests() %></p>
      </div>
    </div>

    <hr class="my-6 border-white/20">

    <div class="p-5 rounded-xl bg-gradient-to-r from-blue-500/20 to-purple-600/20 border border-white/10">
      <div class="flex justify-between text-blue-100">
        <span>Calculated Total</span>
        <span class="text-white font-bold">LKR <%= String.format("%.2f", total) %></span>
      </div>
      <p class="text-blue-100 text-sm mt-2">
        Special Requests: <span class="text-white"><%= (r.getRequests() != null && !r.getRequests().trim().isEmpty()) ? r.getRequests() : "None" %></span>
      </p>
    </div>

    <div class="flex gap-3 mt-6 no-print">
      <button onclick="window.print()"
              class="bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 text-white font-bold px-6 py-3 rounded-xl transition">
        <i class="fas fa-print mr-2"></i>Print Invoice
      </button>

      <a href="<%= request.getContextPath() %>/bill.jsp"
         class="glass border border-white/30 text-white font-bold px-6 py-3 rounded-xl hover:bg-white/10 transition">
        <i class="fas fa-rotate-left mr-2"></i>New Bill
      </a>
    </div>
  </div>
  <% } %>

</div>

</body>
</html>