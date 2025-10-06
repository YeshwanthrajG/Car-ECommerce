<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Car Expert</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #74ebd5 0%, #9face6 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-box {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        .register-box h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group input {
            width: 95%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-msg {
            font-size: 13px;
            height: 16px;
            margin-top: 2px;
            text-align: left;
        }

        .form-msg.error {
            color: #e74c3c;
        }

        .form-msg.success {
            color: #27ae60;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            width: 102%;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 6px;
            font-size: 14px;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
        }

        p {
            font-size: 14px;
            color: #555;
        }

        p a {
            color: #4CAF50;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }
    </style>

    <script>
        function validateUsername() {
            var username = document.getElementById("username").value.trim();
            var msg = document.getElementById("usernameMsg");
            if (username.length < 3) {
                msg.className = "form-msg error";
                msg.innerText = "At least 3 characters.";
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    try {
                        var res = JSON.parse(xhr.responseText);
                        if (res.exists) {
                            msg.className = "form-msg error";
                            msg.innerText = "Username already taken.";
                        } else {
                            msg.className = "form-msg success";
                            msg.innerText = "Username available!";
                        }
                    } catch(e) {
                        msg.className = "form-msg error";
                        msg.innerText = "Server error.";
                    }
                }
            };
            xhr.open("GET", "UsernameCheckServlet?username=" + encodeURIComponent(username), true);
            xhr.send();
        }

        function validatePassword() {
            var pwd = document.getElementById("password").value;
            var msg = document.getElementById("passwordMsg");
            if (pwd.length < 6) {
                msg.className = "form-msg error";
                msg.innerText = "At least 6 characters.";
            } else {
                msg.className = "form-msg success";
                msg.innerText = "Looks good.";
            }
        }

        function validateEmail() {
            var email = document.getElementById("email").value.trim();
            var msg = document.getElementById("emailMsg");
            if (!email) {
                msg.className = "form-msg";
                msg.innerText = "";
                return;
            }
            var re = /^[\w.-]+@([\w-]+\.)+[\w-]{2,}$/i;
            if (!re.test(email)) {
                msg.className = "form-msg error";
                msg.innerText = "Invalid email.";
            } else {
                msg.className = "form-msg success";
                msg.innerText = "Valid email!";
            }
        }

        function submitForm(e) {
            e.preventDefault(); 

            var username = document.getElementById("username").value.trim();
            var password = document.getElementById("password").value.trim();
            var email = document.getElementById("email").value.trim();

            if (username.length < 3 || password.length < 6) {
                alert("Please fill all fields correctly.");
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "RegisterServlet", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    try {
                        var res = JSON.parse(xhr.responseText);
                        console.log("AJAX Response:", res); 

                        let msgBox = document.querySelector(".message");
                        if (!msgBox) {
                            msgBox = document.createElement("p");
                            msgBox.className = "message";
                            document.querySelector(".register-box").insertBefore(msgBox, document.querySelector("form"));
                        }

                        if (res.status === "success") {
                            msgBox.className = "message success";
                            msgBox.innerHTML = res.message + " <a href='login.jsp'>Login here</a>";
                            document.querySelector("form").reset();
                            document.getElementById("usernameMsg").innerText = "";
                            document.getElementById("passwordMsg").innerText = "";
                            document.getElementById("emailMsg").innerText = "";
                        } else {
                            msgBox.className = "message error";
                            msgBox.innerText = res.message;
                        }

                    } catch (e) {
                        console.error("Error parsing JSON:", e);
                        alert("Server error. Try again later.");
                    }
                }
            };

            xhr.send("username=" + encodeURIComponent(username) +
                     "&password=" + encodeURIComponent(password) +
                     "&email=" + encodeURIComponent(email));
        }
    </script>
</head>
<body>

    <div class="register-box">
        <h2>Register</h2>

        <form onsubmit="submitForm(event)" autocomplete="off">
            <div class="form-group">
                <input type="text" id="username" name="username" placeholder="Username" required onblur="validateUsername()" />
                <div class="form-msg" id="usernameMsg"></div>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" placeholder="Password" required onblur="validatePassword()" />
                <div class="form-msg" id="passwordMsg"></div>
            </div>
            <div class="form-group">
                <input type="email" id="email" name="email" placeholder="Email (optional)" onblur="validateEmail()" />
                <div class="form-msg" id="emailMsg"></div>
            </div>
            <input type="submit" value="Register" class="btn" />
        </form>

        <br/>
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

</body>
</html>
