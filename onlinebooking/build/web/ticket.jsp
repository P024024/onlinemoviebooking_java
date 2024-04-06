<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Movie Ticket Invoice</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    </head>
    <body class="bg-gray-100">
        <div class="container mx-auto py-8">
            <h1 class="text-3xl font-bold mb-4">Movie Ticket Invoice</h1>
            <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
                <%
                    String selectedSeatsString = request.getParameter("selectedSeats");
                    int selectedSeatsCount = Integer.parseInt(request.getParameter("selectedSeatsCount"));
                    String userId = request.getParameter("userId");
                    String movieId = request.getParameter("movieId");


                    String url = "jdbc:mysql://localhost:3308/mysql";
                    String username = "root";
                    String password = "";

                    String movieName = "";
                    double pricePerSeat = 0.0;
                    Date releaseDate = null;
                    String userName = "";
                    int numberofSeats=0;
                    double totalPrice = 0.0;
                    double vatRate = 0.1; 
                    double discountRate = 0.05; 
                    double vatAmount = 0.0;
                    double discountAmount = 0.0;
                    double finalAmount = 0.0;

                    try {
                        Connection connection = DriverManager.getConnection(url, username, password);
                        Statement statement = connection.createStatement();

                        ResultSet movieResultSet = statement.executeQuery("SELECT title, price FROM movies WHERE movie_id = " + movieId);
                        if (movieResultSet.next()) {
                            movieName = movieResultSet.getString("title");
                            pricePerSeat = movieResultSet.getDouble("price");
                        }

                        ResultSet userResultSet = statement.executeQuery("SELECT name FROM users WHERE id = " + userId);
                        if (userResultSet.next()) {
                            userName = userResultSet.getString("name");
                        }
                    
                        totalPrice = pricePerSeat * selectedSeatsCount;

                        vatAmount = totalPrice * vatRate;
                        discountAmount = totalPrice * discountRate;
                        finalAmount = totalPrice + vatAmount - discountAmount;

                        statement.close();
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <!-- Invoice content -->
                <div class="text-lg font-bold mb-4">Invoice #0472</div>
                <div>Online Booking</div>
                <div>Tramba-22,Rajkot,India</div>
                <div>March 23, 2024</div>
                <div class="mt-8 font-bold">BILL TO</div>
                <div><%= userName %></div>
                <table class="table-auto w-full mt-8">
                    <thead>
                        <tr>
                            <th class="px-4 py-2">ITEM</th>
                            <th class="px-4 py-2">PRICE</th>
                            <th class="px-4 py-2">QTY</th>
                            <th class="px-4 py-2">OFF</th>
                            <th class="px-4 py-2">TOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border px-4 py-2"><%= movieName %></td>
                            <td class="border px-4 py-2">$<%= pricePerSeat %></td>
                            <td class="border px-4 py-2"><%= selectedSeatsCount %></td>
                            <td class="border px-4 py-2">0%</td>
                            <td class="border px-4 py-2">$<%= totalPrice %></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td class="border px-4 py-2 font-bold">Seats Number</td>
                            <td class="border px-4 py-2" colspan="4"><%= selectedSeatsString %></td>
                        </tr>
                        <tr>
                            <td class="border px-4 py-2 font-bold">SUBTOTAL</td>
                            <td class="border px-4 py-2" colspan="4">$<%= totalPrice %></td>
                        </tr>
                        <tr>
                            <td class="border px-4 py-2 font-bold">TAX RATE</td>
                            <td class="border px-4 py-2" colspan="4">10%</td>
                        </tr>
                        <tr>
                            <td class="border px-4 py-2 font-bold">DISCOUNT</td>
                            <td class="border px-4 py-2" colspan="4">$<%= discountAmount %></td>
                        </tr>
                        <tr>
                            <td class="border px-4 py-2 font-bold">TOTAL</td>
                            <td class="border px-4 py-2" colspan="4">$<%= finalAmount %></td>
                        </tr>
                    </tfoot>
                </table>

                <button id="downloadBtn" class="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                    Download PDF
                </button>
            </div>
        </div>
        <script>
            document.getElementById('downloadBtn').addEventListener('click', function () {
                console.log('Download button clicked');
                var doc = new window.jspdf.jsPDF();
                doc.setFontSize(16);
                doc.setFont('helvetica', 'bold');
                doc.text('Movie Ticket Invoice', 10, 15);

                doc.setFontSize(12);
                doc.setFont('helvetica', 'normal');
                doc.text('Invoice #0472', 10, 30);
                doc.text('Date: March 23, 2024', 10, 45);
                doc.text('Customer: <%= userName %>', 10, 60);
                doc.text('Address: Tramba-22, Rajkot, India', 10, 75);

                doc.setFont('helvetica', 'bold');
                doc.text('-------------------------------------------------------------------------------------------------', 10, 90);
                doc.text('ITEM', 10, 105);
                doc.text('PRICE', 60, 105);
                doc.text('QTY', 100, 105);
                doc.text('DISCOUNT', 140, 105);
                doc.text('TOTAL', 180, 105);
                doc.text('--------------------------------------------------------------------------------------------------', 10, 110);

                doc.setFont('helvetica', 'normal');
                doc.text('<%= movieName %>', 10, 125);
                doc.text('$<%= pricePerSeat %>', 60, 125);
                doc.text('<%= selectedSeatsCount %>',100, 125);
                doc.text('0%', 140, 125);
                doc.text('$<%= totalPrice %>', 180, 125);

                doc.setFont('helvetica', 'bold');
                doc.text('---------------------------------------------------------------------------------------------------', 10, 140);
                doc.text('SUBTOTAL', 10, 155);
                doc.text('$<%= totalPrice %>', 180, 155);
                doc.text('TAX RATE (10%)', 10, 170);
                doc.text('$<%= vatAmount %>', 180, 170);
                doc.text('DISCOUNT', 10, 185);
                doc.text('$<%= discountAmount %>', 180, 185);
                doc.text('TOTAL', 10, 200);
                doc.text('$<%= finalAmount %>', 180, 200);
                doc.text('-----------------------------------------------------------------------------------------------------', 10, 205);
                doc.save('invoice.pdf');
                console.log('PDF saved');
            });
        </script>

    </body>
</html>

