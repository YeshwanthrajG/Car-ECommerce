<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("username");
%>
<!doctype html>
<html>
<head>
    <title>Car Expert</title>
    <link rel="icon" href="images/icon.png">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Header / Welcome -->
    <div class="homepage">
        <div class="title-card">
            <h1><center>Welcome to Car Expert</center></h1>
        </div>    
        <div class="navbar">
		    <div class="brand">CarExpert</div>
		    <div class="actions">
		        <a class="ghost" href="http://localhost/CarECommercePHP/loginPHP.php">Login</a>
		        <a class="primary" href="register.jsp">Register</a>
		    </div>
		</div>
		
		<div class="container">
		    <div class="card">
		        <h2>Buy and Sell Cars Easily</h2>
		        <p>Explore listings, add cars to cart, and checkout securely.</p>
		        <div>
		            <a class="primary round-button" href="http://localhost/CarECommercePHP/loginPHP.php">Go to Dashboard</a>
		        </div>
		    </div>
		</div>    
    </div>

    <!-- Car Showcases -->
    <div class="sclass">
        <h3><center>From the art of Luxuriousness in every edge</center></h3>
        <div class="car-show">
            <img src="images/sclass-rolls-royce.jpeg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/sclass-maserati.jpeg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/sclass-benz.jpeg" style="width:400px; height:250px;">
        </div>
    </div>

    <div class="aclass">
        <h3><center>From enjoying the breathe of engines</center></h3>
        <div class="car-show">
            <img src="images/aclass-lamborgini.jpeg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/aclass-bmw.jpg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/aclass-mclaren.jpg" style="width:400px; height:250px;">
        </div>
    </div>

    <div class="bclass">
        <h3><center>Stronger bodies for strongest minds</center></h3>
        <div class="car-show">
            <img src="images/bclass-buggatti.jpg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/bclass-aston-martin.jpg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/bclass-koenisegg.jpg" style="width:400px; height:250px;">
        </div>
    </div>

    <div class="cclass">
        <h3><center>Passion driven from inspirations</center></h3>
        <div class="car-show">
            <img src="images/cclass-ferrari.jpg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/cclass-pagani.jpeg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/cclass-audi.jpeg" style="width:400px; height:250px;">
        </div>
    </div>

    <div class="dclass">
        <h3><center>Setting your height to next level</center></h3>
        <div class="car-show">
            <img src="images/dclass-lexus.jpeg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/dclass-jeep.jpg" style="width:400px; height:250px;">
        </div>
        <div class="car-show">
            <img src="images/dclass-range-rover.jpeg" style="width:400px; height:250px;">
        </div>
    </div>

    <!-- Why Choose Section -->
    <div><h1><center>Why Choose Car Expert</center></h1></div>

    <div class="trust">
        <h3><center>Trusted Experience</center></h3>
        <p><center>
            With over 15 years in the automotive industry, our team of certified professionals brings unparalleled knowledge to help you find the perfect vehicle.
        </center></p>
    </div>

    <div class="trust">
        <h3><center>Market's Lowest Price</center></h3>
        <p><center>
            Best Value Guarantee: We negotiate the best prices with manufacturers so you don't have to. Our transparent pricing ensures you get exceptional value.
        </center></p>
    </div>
    

    <!-- Footer -->
    <footer>
        <center>
            <div>
                <h3>Car Expert</h3>
                <p>Driving your automotive dreams since 2010</p>
                <a href="#" class="hover:text-blue-400">About Us</a> |
                <a href="dashboard.jsp">Inventory</a> |
                <a href="#">Financing</a> |
                <a href="#">Contact</a> |
                <a href="FAQServlet">FAQs</a>
                <p>© 2025 Car Expert. All rights reserved.</p>
            </div>
        </center>
    </footer>

</body>
</html>
