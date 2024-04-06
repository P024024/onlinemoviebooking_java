<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.stream.Collectors" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%! 
    List<Integer> selectedSeats = new ArrayList<Integer>();
    List<Integer> disabledSeats = new ArrayList<Integer>();
    String selectedSeatsString = ""; 
    String userId = ""; 
    String movieId = ""; 
    String getCurrentDate() {
        Date currentDate = new Date();
        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(currentDate);
    }

    String movieName = "";
    double pricePerSeat = 0.0;

    public void fetchDisabledSeats(String movieId) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            disabledSeats.clear();

            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");

            String query = "SELECT seat_number FROM bookings WHERE movie_id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, movieId);

            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String[] seatNumbers = resultSet.getString("seat_number").split(",");
                for (String seatNumber : seatNumbers) {
                    disabledSeats.add(Integer.parseInt(seatNumber.trim()));
                }
            }

            query = "SELECT title, price FROM movies WHERE movie_id = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, movieId);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                movieName = resultSet.getString("title");
                pricePerSeat = resultSet.getDouble("price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void toggleSeatSelection(int seatNumber) {
        if (!disabledSeats.contains(seatNumber)) {
            if (selectedSeats.contains(seatNumber)) {
                selectedSeats.remove(Integer.valueOf(seatNumber));
            } else {
                selectedSeats.add(seatNumber);
            }
            renderSelectedSeats();
        }
    }

    public String renderSeat(int seatNumber, boolean isSelected, boolean isDisabled) {
        String seatClass = isSelected ? "selected" : "";
        seatClass += isDisabled ? " disabled" : "";
        String seatHtml = "<div key='" + seatNumber + "' class='seat mr-4 " + seatClass + "' ";
        if (!isDisabled) {
            seatHtml += "onclick='toggleSeatSelection(" + seatNumber + ")'";
        }
        seatHtml += ">";
        seatHtml += "<div class='fa-bounce' style='color: " + (isSelected ? "blue" : (isDisabled ? "inherit" : "green")) + "; " +
                "font-size: 20px;'>" + 
                "<i class='fas fa-couch'></i></div>" + 
                "<div class='text-xs text-center'>" + seatNumber + "</div></div>";
        return seatHtml;
    }

    public void renderSelectedSeats() {
        StringBuilder selectedSeatsHtml = new StringBuilder();
        for (Integer seat : selectedSeats) {
            selectedSeatsHtml.append("<div class='text-center text-sm bg-gray-400 flex justify-evenly p-4 rounded-xl'>" +
                                      "<i class='fas fa-couch' style='color: black; font-size: 24px;'></i>" +
                                      "<span class='block'>" + seat + "</span></div>");
        }
        System.out.println(selectedSeatsHtml.toString());
    }

    public String renderRow(int row, int seatCount, int rowOffset) {
        StringBuilder rowHtml = new StringBuilder();
        rowHtml.append("<div key='" + row + "' class='flex justify-center'>");
        for (int i = 0; i < seatCount; i++) {
            int seatNumber = rowOffset + i + 1;
            boolean isSelected = selectedSeats.contains(seatNumber);
            boolean isDisabled = disabledSeats.contains(seatNumber);
            rowHtml.append(renderSeat(seatNumber, isSelected, isDisabled));
        }
        rowHtml.append("</div>");
        return rowHtml.toString();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Booking Page</title>
        <script>
            var selectedSeats = [];
            var disabledSeats = <%= disabledSeats.stream().map(Object::toString).collect(Collectors.toList()) %>;
            function toggleSeatSelection(seatNumber) {
                if (!disabledSeats.includes(seatNumber)) {
                    var index = selectedSeats.indexOf(seatNumber);
                    if (index !== -1) {
                        selectedSeats.splice(index, 1);
                    } else {
                        selectedSeats.push(seatNumber);
                    }
                    renderSelectedSeats();
                }
            }

            function renderSelectedSeats() {
                var selectedSeatsDiv = document.getElementById("selectedSeats");
                var selectedSeatsHtml = "";
                selectedSeats.forEach(function (seat) {
                    selectedSeatsHtml += "<div class='text-center text-sm bg-gray-400 flex justify-evenly p-1 m-2 rounded-xl'>" +
                            "<i class='fas fa-couch' style='color: black; font-size: 24px;'></i>" +
                            "<span class='block'>" + seat + "</span></div>";
                });
                selectedSeatsDiv.innerHTML = selectedSeatsHtml;
            }
            function Confirm() {
                var urlParams = new URLSearchParams(window.location.search);
                var selectedSeatsCount = selectedSeats.length;
                var selectedSeatsString = selectedSeats.join(', ');
                var isLoggedIn = <%= request.getSession().getAttribute("user_id") != null %>;
                var userId = <%= request.getSession().getAttribute("user_id") %>;
                var movieId = urlParams.get('movie_id');

                if (isLoggedIn) {
                    var bookingInfo = `
            <div class="p-4 shadow-xl">
                <div class="text-xl font-bold mb-4">Bill</div>
                <div class="grid grid-cols-2 gap-4">
                    <span class="font-semibold">Movie Name:</span>
                    <span><%= movieName %></span>
                    <span class="font-semibold">Price per set:</span>
                    <span><%= pricePerSeat %></span>
                    <span class="font-semibold">No of Seats Selected:</span>
                    <span>` + selectedSeatsCount + `</span>
                    <span class="font-semibold">Seats Number:</span>
                    <span>` + selectedSeatsString + `</span>
                </div>
            </div>
            <form id="bookingForm" action="MoviebookServlet" method="post">
                <input type="hidden" name="selectedSeats" value="` + selectedSeatsString + `">
                <input type="hidden" name="userId" value="` + userId + `">
                <input type="hidden" name="movieId" value="` + movieId + `">
                <input type="hidden" name="selectedSeatsCount" value="` + selectedSeatsCount + `">
                <input type="hidden" name="currentDate" value="<%= getCurrentDate() %>">
                        <button type="submit"
                            class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Book
                    </button>
            </form>
        `;

                    document.getElementById("bookingInfo").innerHTML = bookingInfo;
                    document.getElementById("confirmButton").style.display = "none";
                    document.getElementById("bookButton").style.display = "inline-block";
                } else {
                    alert("You are not logged in. Please log in to proceed.");
                    window.location.href = "login.jsp";
                }
            }
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="css/global.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <nav class="bg-gray-800">
            <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
                <div class="relative flex h-16 items-center justify-between">
                    <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
                        <div class="flex flex-shrink-0 items-center">
                            <h2 class="text-yellow-600 font-bold cursor-pointer">OnlineBooking</h2>
                        </div>
                        <div class="hidden sm:ml-6 sm:block">
                            <div class="flex space-x-4">
                                <a href="index.jsp" class="menu-link">Home</a>
                                <a href="movie.jsp" class="menu-link">Movies</a>
                                <a href="about.jsp" class="menu-link">About Us</a>
                                <a href="contactus.jsp" class="menu-link">Contact Us</a>
                            </div>
                        </div>
                    </div>
                    <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
                        <button type="button" class="relative rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800">
                            <span class="absolute -inset-1.5"></span>
                            <span class="sr-only">View notifications</span>
                            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
                            </svg>
                        </button>
                        <% if (request.getSession().getAttribute("name") != null) { %>
                        <div id="dropdownMenu" class="relative inline-block text-left ml-4">
                            <button id="dropdownButton" class="text-gray-800" type="button" aria-haspopup="true" aria-expanded="false" aria-controls="dropdown-menu">
                                <div class="flex items-center">
                                    <img class="h-8 w-8 rounded-full focus:ring-2 focus:ring-white focus:ring-offset-2" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="">
                                    <span class="ml-2 text-white font-medium"><%= request.getSession().getAttribute("name") %></span>
                                </div>
                            </button>
                            <div class="origin-top-right absolute right-0 mt-2 w-40 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 hidden" id="dropdown-menu" aria-labelledby="dropdown-menu">
                                <div class="py-1" role="menu" aria-orientation="vertical" aria-labelledby="options-menu">
                                    <a href="ShowServlet" id="profileOption" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Show My Bookings</a>
                                    <a href="#" id="settingsOption" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Settings</a>
                                    <a href="logout" id="logoutOption" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Logout</a>
                                </div>
                            </div>
                        </div>
                        <% } else { %>
                        <div>
                            <a href="login.jsp" class="text-white">Login</a>
                            <span class="text-gray-300 mx-2">|</span>
                            <a href="signup.jsp" class="text-white">Register</a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </nav>
        <% fetchDisabledSeats(request.getParameter("movie_id")); %>
        <div class="container md:grid md:grid-cols-3 px-4 py-8">
            <div class="col-span-2">
                <h1 class="text-2xl font-bold mb-4 text-center">Select Your Seats</h1>
                <div class="grid">
                    <div>
                        <%= renderRow(11, 16, 105) %>
                        <%= renderRow(10, 15, 90) %>
                        <%= renderRow(9, 14, 76) %>
                        <%= renderRow(8, 13, 63) %>
                        <%= renderRow(7, 12, 51) %>
                        <%= renderRow(5, 11, 40) %>
                    </div>
                    <p class='text-center mb-2 font-bold'>Walking Corridor</p>
                    <div>
                        <%= renderRow(5, 10, 30) %>
                        <%= renderRow(4, 9, 21) %>
                        <%= renderRow(2, 8, 13) %>
                        <%= renderRow(2, 7, 6) %>
                        <%= renderRow(1, 6, 0) %>
                    </div>
                    <div class="screen mt-8 flex justify-center items-center bg-gray-500 w-[20%] mx-auto h-[100px] rounded-xl">
                        <h2 class="text-lg font-bold text-center">Cinema Screen</h2>
                    </div>
                </div>
            </div>
            <div class="grid grid-rows-2">
                <div style="max-height: 300px; overflow-y: auto;">
                    <h2 class="text-lg font-bold mb-2">Selected Seats:</h2>
                    <div class="grid grid-cols-3 gap-2 selectedSeats" id="selectedSeats">
                    </div>
                </div>
                <div id="bookingInfo">
                    <button onclick="Confirm()" id="confirmButton" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Confirm</button>
                </div>
            </div>
        </div>
    </body>
</html>

