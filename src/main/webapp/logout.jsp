<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session.invalidate();   // destroy session
%>

<!DOCTYPE html>
<html>
<head>
    <title>Session Ended</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background: linear-gradient(to right,#e3edf7,#f7fbff);
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .card{
            background:white;
            width:380px;
            padding:40px;
            border-radius:12px;
            text-align:center;
            box-shadow:0 5px 20px rgba(0,0,0,0.15);
        }

        .icon{
            font-size:40px;
            color:#3b6edc;
        }

        h2{
            margin-top:10px;
        }

        .quote{
            margin:20px 0;
            font-style:italic;
            color:#555;
        }

        .btn{
            background:#3b6edc;
            color:white;
            border:none;
            padding:12px 20px;
            border-radius:6px;
            text-decoration:none;
            font-size:16px;
        }

        .btn:hover{
            background:#2f5bb5;
        }

        .footer{
            margin-top:20px;
            font-size:12px;
            color:#888;
        }
    </style>
</head>

<body>

<div class="card">

    <div class="icon">🔒</div>

    <h2>Session Ended</h2>

    <p>You have successfully logged out from <br><b>Ocean View Hotel System</b></p>

    <div class="quote">
        "The journey of a thousand miles begins with a single step."
        <br>– Lao Tzu
    </div>

    <a href="login.jsp" class="btn">🔑 Log In Again</a>

    <div class="footer">
        © 2025 Ocean View Resort. All rights reserved.
    </div>

</div>

</body>
</html>