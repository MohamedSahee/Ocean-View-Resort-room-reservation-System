<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session.invalidate();   // destroy session
%>

<!DOCTYPE html>
<html>
<head>
    <title>Logged Out - Online Billing System</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
            margin:0;
            padding:20px;
        }

        .card{
            background:white;
            width:380px;
            padding:40px;
            border-radius:12px;
            text-align:center;
            box-shadow:0 15px 35px rgba(0,0,0,0.2);
        }

        .icon{
            font-size:48px;
            color:#667eea;
            margin-bottom:15px;
        }

        h2{
            margin-top:10px;
            color:#333;
            font-size:24px;
        }

        .message{
            margin:20px 0;
            color:#555;
            line-height:1.6;
        }

        .message b{
            color:#667eea;
        }

        .quote{
            margin:25px 0;
            font-style:italic;
            color:#666;
            padding:15px;
            background:#f7fafc;
            border-radius:8px;
            border-left:4px solid #667eea;
            text-align:left;
        }

        .quote-author{
            display:block;
            margin-top:8px;
            color:#888;
            font-style:normal;
            font-size:14px;
        }

        .btn{
            display:inline-block;
            background:#667eea;
            color:white;
            border:none;
            padding:12px 25px;
            border-radius:6px;
            text-decoration:none;
            font-size:16px;
            font-weight:600;
            margin-top:10px;
            transition: background 0.3s;
        }

        .btn:hover{
            background:#5a67d8;
        }

        .footer{
            margin-top:30px;
            font-size:12px;
            color:#999;
            border-top:1px solid #eee;
            padding-top:20px;
        }

        .stats{
            display:flex;
            justify-content:space-around;
            margin:20px 0;
            padding:15px 0;
            border-top:1px solid #eee;
            border-bottom:1px solid #eee;
        }

        .stat-item{
            text-align:center;
        }

        .stat-value{
            font-size:18px;
            font-weight:bold;
            color:#667eea;
        }

        .stat-label{
            font-size:12px;
            color:#888;
            margin-top:5px;
        }
    </style>
</head>

<body>

<div class="card">

    <div class="icon">✓</div>

    <h2>Successfully Logged Out</h2>

    <div class="message">
        You have been securely logged out from <br><b>Online Billing System</b>
    </div>

    <div class="stats">
        <div class="stat-item">
            <div class="stat-value">100+</div>
            <div class="stat-label">Happy Clients</div>
        </div>
        <div class="stat-item">
            <div class="stat-value">24/7</div>
            <div class="stat-label">Support</div>
        </div>
        <div class="stat-item">
            <div class="stat-value">Secure</div>
            <div class="stat-label">Billing</div>
        </div>
    </div>

    <div class="quote">
        "Thank you for using our billing system. Your session has been safely terminated. For security reasons, please close your browser if you're using a shared computer."
    </div>

    <a href="login.jsp" class="btn">🔐 Login Again</a>

    <div class="footer">
        © 2025 Online Billing System. All rights reserved.<br>
        Secure • Reliable • Efficient
    </div>

</div>

</body>
</html>