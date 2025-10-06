<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sell a Car</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        .form-container h3 {
            margin-bottom: 25px;
            color: #333333;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 8px 10px;
            margin-bottom: 15px;
            border: 1px solid #cccccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
    <div class="form-container">
        <h3>Sell a Car</h3>
        <form action="SellServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" required>

            <label for="brand">Brand:</label>
            <input type="text" name="brand" id="brand" required>

            <label for="price">Price:</label>
            <input type="text" name="price" id="price" required>

            <label for="class">Class:</label>
            <input type="text" name="class" id="class" required>

            <label for="description">Description:</label>
            <input type="text" name="description" id="description">

            <label for="stock">Stock:</label>
            <input type="number" name="stock" id="stock" required>

            <label for="image_url">Image URL:</label>
            <input type="text" name="image_url" id="image_url">

            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
