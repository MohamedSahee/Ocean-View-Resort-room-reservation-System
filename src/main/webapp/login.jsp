<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .wave {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            overflow: hidden;
            line-height: 0;
        }

        .wave svg {
            position: relative;
            display: block;
            width: calc(100% + 1.3px);
            height: 150px;
        }

        .wave .shape-fill {
            fill: rgba(255, 255, 255, 0.1);
        }

        /* Custom focus styles */
        input:focus {
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }
    </style>
</head>
<body class="flex items-center justify-center p-4">
<!-- Wave background decoration -->
<div class="wave">
    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
        <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" class="shape-fill"></path>
    </svg>
</div>

<!-- Main Container -->
<div class="w-full max-w-md mx-auto">
    <!-- Logo & Header -->
    <div class="text-center mb-8">
        <div class="flex justify-center mb-4">
            <div class="w-16 h-16 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center shadow-lg">
                <i class="fas fa-umbrella-beach text-white text-2xl"></i>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-white mb-2">Ocean View Resort</h1>
        <p class="text-blue-100 text-lg">Luxury by the Sea</p>
    </div>

    <!-- Login Card -->
    <div class="glass-effect rounded-2xl shadow-2xl p-8">
        <h2 class="text-2xl font-bold text-white text-center mb-2">Welcome Back</h2>
        <p class="text-blue-100 text-center mb-8">Sign in to your account</p>

        <!-- Error Message -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded">
            <div class="flex">
                <div class="flex-shrink-0">
                    <i class="fas fa-exclamation-circle text-red-500"></i>
                </div>
                <div class="ml-3">
                    <p class="text-red-800 text-sm"><%= error %></p>
                </div>
            </div>
        </div>
        <%
            }
        %>

        <!-- Login Form -->
        <form action="<%= request.getContextPath() %>/login" method="post">
            <!-- Username Field -->
            <div class="mb-6">
                <label class="block text-blue-100 text-sm font-medium mb-2" for="username">
                    <i class="fas fa-user mr-2"></i>Username
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-blue-300"></i>
                    </div>
                    <input
                            type="text"
                            id="username"
                            name="username"
                            required
                            class="w-full pl-10 pr-4 py-3 bg-white/20 border border-white/30 rounded-lg text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                            placeholder="Enter your username"
                    >
                </div>
            </div>

            <!-- Password Field -->
            <div class="mb-6">
                <label class="block text-blue-100 text-sm font-medium mb-2" for="password">
                    <i class="fas fa-lock mr-2"></i>Password
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-key text-blue-300"></i>
                    </div>
                    <input
                            type="password"
                            id="password"
                            name="password"
                            required
                            class="w-full pl-10 pr-12 py-3 bg-white/20 border border-white/30 rounded-lg text-white placeholder-blue-200 focus:outline-none focus:border-white transition duration-300"
                            placeholder="Enter your password"
                    >
                    <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 pr-3 flex items-center">
                        <i class="fas fa-eye text-blue-300 hover:text-white transition duration-300"></i>
                    </button>
                </div>
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center">
                    <input
                            id="remember"
                            name="remember"
                            type="checkbox"
                            class="h-4 w-4 text-blue-500 focus:ring-blue-400 border-white/30 rounded bg-white/20"
                    >
                    <label for="remember" class="ml-2 block text-sm text-blue-100">
                        Remember me
                    </label>
                </div>
                <div>
                    <a href="#" class="text-sm text-blue-200 hover:text-white transition duration-300">
                        Forgot password?
                    </a>
                </div>
            </div>

            <!-- Submit Button -->
            <button
                    type="submit"
                    class="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold py-3 px-4 rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition duration-300"
            >
                <i class="fas fa-sign-in-alt mr-2"></i>Sign In
            </button>

            <!-- Divider -->
            <div class="flex items-center my-8">
                <div class="flex-grow border-t border-white/20"></div>
                <span class="flex-shrink mx-4 text-blue-100 text-sm">or continue with</span>
                <div class="flex-grow border-t border-white/20"></div>
            </div>

            <!-- Social Login -->
            <div class="grid grid-cols-2 gap-4 mb-8">
                <button type="button" class="flex items-center justify-center bg-white/10 hover:bg-white/20 border border-white/20 text-white py-3 rounded-lg transition duration-300">
                    <i class="fab fa-google mr-2"></i> Google
                </button>
                <button type="button" class="flex items-center justify-center bg-white/10 hover:bg-white/20 border border-white/20 text-white py-3 rounded-lg transition duration-300">
                    <i class="fab fa-facebook mr-2"></i> Facebook
                </button>
            </div>

            <!-- Registration Link -->
            <p class="text-center text-blue-100 text-sm">
                Don't have an account?
                <a href="#" class="text-white font-medium hover:underline transition duration-300">
                    Create one now
                </a>
            </p>
        </form>
    </div>

    <!-- Footer -->
    <p class="text-center text-blue-100 text-sm mt-8">
        &copy; 2026 Ocean View Resort. All rights reserved.
    </p>
</div>

<!-- JavaScript for Password Toggle -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Toggle password visibility
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');

        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);

            // Toggle icon
            const icon = this.querySelector('i');
            if (type === 'text') {
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Form submission animation
        const form = document.querySelector('form');
        const submitBtn = form.querySelector('button[type="submit"]');

        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                return;
            }

            // Add loading animation
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Signing In...';
            submitBtn.disabled = true;
        });

        // Add focus effect to inputs
        const inputs = form.querySelectorAll('input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('ring-2', 'ring-blue-400');
            });

            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('ring-2', 'ring-blue-400');
            });
        });
    });
</script>
</body>
</html>