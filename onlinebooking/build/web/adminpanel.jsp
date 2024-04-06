<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Carousel" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<!DOCTYPE html>
<html>
    <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/Loopple/loopple-public-assets@main/riva-dashboard-tailwind/riva-dashboard.css">
    </head>
    <body class="bg-black">
        <nav class="bg-gray-800">
            <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8 text-white">
                <div class="relative flex h-16 items-center justify-between">
                    <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">

                        <div class="hidden sm:ml-6 sm:block pl-4">
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
        <aside id="logo-sidebar" class="fixed top-0 left-0 z-40 w-64 h-screen pt-20 transition-transform -translate-x-full bg-white border-r border-gray-200 sm:translate-x-0 dark:bg-gray-800 dark:border-gray-700" aria-label="Sidebar">
            <div class="h-full px-3 pb-4 overflow-y-auto bg-white dark:bg-gray-800">
                <ul class="space-y-2 font-medium">
                    <li>
                        <a href="#" class="navbar-link flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group">
                            <span class="ms-3">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="#tickets-booked-content" class="navbar-link flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group">
                            <span class="flex-1 ms-3 whitespace-nowrap">Tickets Booked</span>
                            <span class="inline-flex items-center justify-center px-2 ms-3 text-sm font-medium text-gray-800 bg-gray-100 rounded-full dark:bg-gray-700 dark:text-gray-300">Pro</span>
                        </a>
                    </li>
                    <li>
                        <button type="button" class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="crousels-dropdown" data-collapse-toggle="dropdown">
                            <span class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap">Crousels</span>
                        </button>
                        <ul id="crousels-dropdown" class="hidden py-2 space-y-2">
                            <li>
                                <a href="#add-crousels-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Add Crousels</a>
                            </li>
                            <li>
                                <a href="#show-crousels-content" class="navbar-link  flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Show Crousels</a>
                            </li>
                            <li>
                                <a href="#update-crousels-content" class="navbar-link  flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Update Crousels</a>
                            </li>
                            <li>
                                <a href="#delete-crousels-content" class="navbar-link  flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Delete Crousels</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <button type="button" class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="users-dropdown" data-collapse-toggle="dropdown">
                            <span class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap">Users</span>
                        </button>
                        <ul id="users-dropdown" class="hidden py-2 space-y-2">
                            <li>
                                <a href="#add-users-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Add Users</a>
                            </li>
                            <li>
                                <a href="#show-users-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Show Users</a>
                            </li>
                            <li>
                                <a href="#update-users-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Update Users</a>
                            </li>
                            <li>
                                <a href="#delete-users-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Delete Users</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <button type="button" class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700" aria-controls="movies-dropdown" data-collapse-toggle="dropdown">
                            <span class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap">Movies</span>
                        </button>
                        <ul id="movies-dropdown" class="hidden py-2 space-y-2">
                            <li>
                                <a href="#add-movies-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Add Movies</a>
                            </li>
                            <li>
                                <a href="#show-movies-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Show Movies</a>
                            </li>
                            <li>
                                <a href="#update-movies-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Update Movies</a>
                            </li>
                            <li>
                                <a href="#delete-movies-content" class="navbar-link flex items-center w-full p-2 text-gray-900 transition duration-75 rounded-lg pl-11 group hover:bg-gray-100 dark:text-white dark:hover:bg-gray-700">Delete Movies</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <% if (request.getSession().getAttribute("name") != null) { %>
                        <a href="logout" class="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group">
                            <span class="flex-1 ms-3 whitespace-nowrap">Logout</span>
                            <% }%>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>
        <div class="p-4 sm:ml-64 mt-12">
            <div id="dashboard-content" class="content text-white mx-auto max-w-5xl p-6 ">
                <h1 class="text-4xl font-bold mb-4">Welcome to Your Dashboard, Administrator!</h1>
                <p class="text-xl mb-2">You are currently logged in as <strong>Admin</strong>.</p>
                <p class="text-xl mb-4">This dashboard provides you with an overview of the system's status and allows you to manage various aspects of the application.</p>
                <h2 class="text-3xl font-bold mb-2">Quick Stats</h2>
                <ul class="mb-4">
                    <li class="text-xl">Total Users: <span class="font-bold">1,234</span></li>
                    <li class="text-xl">Active Users: <span class="font-bold">987</span></li>
                    <li class="text-xl">Pending Requests: <span class="font-bold">23</span></li>
                </ul>
                <h2 class="text-3xl font-bold mb-2">Recent Activity</h2>
                <ul class="mb-4 flex justify-between">
                    <li class="text-xl">User "JohnDoe" updated their profile.</li>
                    <li class="text-xl">New feature "Task Management" added.</li>
                    <li class="text-xl">Error fixed in module "Analytics".</li>
                </ul>
                <p class="text-lg">Feel free to navigate through the menu on the left to access different sections of the dashboard.</p>
            </div>
            <div id="tickets-booked-content" class="content text-white">
                <h2 class="text-2xl font-semibold pt-4">Booked Tickets</h2>
                <div class="col-sm-8">                    <table class="table-auto text-center">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="px-4 py-2 text-gray-600">Movie ID</th>
                                <th class="px-4 py-2 text-gray-600">Total Seats Booked</th>
                                <th class="px-4 py-2 text-gray-600">Seat Numbers</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                Connection connection = null;
                                PreparedStatement statement = null;
                                ResultSet resultSet = null;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");
                                    String selectQuery = "SELECT movie_id, seat_number FROM bookings";
                                    statement = connection.prepareStatement(selectQuery);
                                    resultSet = statement.executeQuery();

                                    Map<Integer, StringBuilder> movieSeatNumbers = new HashMap<>();
                                    Map<Integer, Integer> movieSeatCounts = new HashMap<>();

                                    while (resultSet.next()) {
                                        int movieId = resultSet.getInt("movie_id");
                                        String seatNumbersStr = resultSet.getString("seat_number");
                                        String[] seatNumbersArray = seatNumbersStr.split(",");
                                        int seatsBooked = seatNumbersArray.length;

                                        if (!movieSeatNumbers.containsKey(movieId)) {
                                            movieSeatNumbers.put(movieId, new StringBuilder());
                                        }

                                        StringBuilder seatNumbersBuilder = movieSeatNumbers.get(movieId);
                                        for (String seatNumber : seatNumbersArray) {
                                            seatNumbersBuilder.append(seatNumber).append(", ");
                                        }

                                        movieSeatCounts.put(movieId, movieSeatCounts.getOrDefault(movieId, 0) + seatsBooked);
                                    }

                                    for (Map.Entry<Integer, Integer> entry : movieSeatCounts.entrySet()) {
                                        int movieId = entry.getKey();
                                        int totalSeatsBooked = entry.getValue();
                                        String seatNumbers = movieSeatNumbers.get(movieId).toString();
                                        seatNumbers = seatNumbers.isEmpty() ? "N/A" : seatNumbers.substring(0, seatNumbers.length() - 2); // Remove trailing comma and space
                            %>
                            <tr>
                                <td class="px-4 py-2 text-white font-semibold"><%= movieId %></td>
                                <td class="px-4 py-2 text-white font-semibold"><%= totalSeatsBooked %></td>
                                <td class="px-4 py-2 text-white font-semibold"><%= seatNumbers %></td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                } finally {
                                    try {
                                        if (resultSet != null) resultSet.close();
                                        if (statement != null) statement.close();
                                        if (connection != null) connection.close();
                                    } catch (SQLException e) {
                                        out.println("Error closing resources: " + e.getMessage());
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="add-crousels-content" class="content">
                <h2 class="text-white text-4xl text-center font-medium">Add Crousels</h2>
                <form action="CarouselServlet" method="POST" class="mt-4 p-4">
                    <div class="mb-4">
                        <label for="title" class="block text-xl text-white font-bold">Title:</label>
                        <input type="text" id="title" name="title"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>

                    <div class="mb-4">
                        <label for="image_url" class="block text-xl text-white font-bold">Image URL:</label>
                        <input type="url" id="image_url" name="image_url"
                               class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="block text-xl text-white font-bold">Description:</label>
                        <textarea id="description" name="description"
                                  class="form-textarea bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                  required></textarea>
                    </div>

                    <div class="mt-6">
                        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Add Carousel Item</button>
                    </div>
                </form>
            </div>
            <div id="show-crousels-content" class="content">
                <form action="CarouselServlet" method="GET" class="mt-4">
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Show Data</button>
                </form>
                <table class="mt-8 w-full border-collapse border border-gray-200">
                    <thead>
                        <tr>
                            <th class="px-4 py-2 bg-gray-100 border border-gray-200">Slide ID</th>
                            <th class="px-4 py-2 bg-gray-100 border border-gray-200">Title</th>
                            <th class="px-4 py-2 bg-gray-100 border border-gray-200">Image</th>
                            <th class="px-4 py-2 bg-gray-100 border border-gray-200">Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<Carousel> carouselList = (List<Carousel>) request.getAttribute("carouselList");
                        if (carouselList != null) {
                        for (Carousel carousel : carouselList) {

                        %>
                        <tr>
                            <td class="px-4 py-2 border border-gray-200 text-white"><%= carousel.getslide_id() %></td>
                            <td class="px-4 py-2 border border-gray-200 text-white"><%= carousel.getTitle() %></td>
                            <td class="px-4 py-2 border border-gray-200">
                                <img src="<%= carousel.getImageUrl() %>" alt="Carousel Image" width="100" height="10px">
                            </td>
                            <td class="px-4 py-2 border border-gray-200 text-white"><%= carousel.getDescription() %></td>

                        </tr>
                        <%
                        }
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div id="update-crousels-content" class="content">
                <h2 class="text-white text-4xl text-center font-medium">Update Crousels</h2>
                <form action="CarouselServlet" method="PUT" class="mt-4 p-4">
                    <div class="mb-4">
                        <label for="title" class="block text-xl text-white font-bold">Id:</label>
                        <input type="text" id="id" name="id"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>
                    <div class="mb-4">
                        <label for="title" class="block text-xl text-white font-bold">Title:</label>
                        <input type="text" id="title" name="title"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>

                    <div class="mb-4">
                        <label for="image_url" class="block text-xl text-white font-bold">Image URL:</label>
                        <input type="url" id="image_url" name="image_url"
                               class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="block text-xl text-white font-bold">Description:</label>
                        <textarea id="description" name="description"
                                  class="form-textarea bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                  required></textarea>
                    </div>
                    <div class="mt-6">
                        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Update Carousel</button>
                    </div>
                </form>
            </div>
            <div id="delete-crousels-content" class="content">
                <form action="CarouselServlet" method="DELETE" class="mt-4 p-4">
                    <div class="mb-4">
                        <label for="title" class="block text-xl text-white font-bold">Id:</label>
                        <input type="text" id="id" name="id"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>
                    <div class="mt-6">
                        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Delete Carousel</button>
                    </div>
                </form>
            </div>

            <div id="add-users-content" class="content">
                <h2 class="text-2xl font-semibold text-gray-900 text-white">Manage the Users</h2>
                <form class="space-y-6" action="RegisterServlet" method="POST">
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Name
                        </label>
                        <input type="text" name="name" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Email
                        </label>
                        <input type="email" name="email" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" placeholder="name@company.com" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Password
                        </label>
                        <input type="password" name="password" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>

                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Confirm password
                        </label>
                        <input type="password" name="confirmPassword" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>

                    <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Add User
                    </button>
                </form>
            </div>
            <div id="show-users-content" class="content p-4">
                <h2 class="text-white text-2xl font-semibold pt-4">Users Data</h2>
                <div class="col-sm-6">
                    <table class="table-auto text-center">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="px-4 py-2 text-gray-600">User ID</th>
                                <th class="px-4 py-2 text-gray-600">Username</th>
                                <th class="px-4 py-2 text-gray-600">Email</th>
                                <th class="px-4 py-2 text-gray-600">Password</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                try {
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");
                                    String selectQuery = "SELECT * FROM users";
                                    try (PreparedStatement selectPst = con.prepareStatement(selectQuery);
                                         ResultSet rs = selectPst.executeQuery()) {
                                        while (rs.next()) {
                                            int id = rs.getInt("id");
                                            String name = rs.getString("name");
                                            String email = rs.getString("email");
                                            String password = rs.getString("password");
                            %>
                            <tr>
                                <td class="px-4 py-2 text-white font-semibold"><%= id %></td>
                                <td class="px-4 py-2 text-white font-semibold"><%= name %></td>
                                <td class="px-4 py-2 text-white font-semibold"><%= email %></td>
                                <td class="px-4 py-2 text-white font-semibold"><%= password %></td>
                            </tr>
                            <%          
                                        }
                                    }
                                    con.close(); 
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                } 
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="update-users-content" class="content">
                <h2 class="text-2xl font-semibold text-gray-900 text-white">Update User</h2>
                <form class="space-y-6" action="UpdateServlet" method="POST">
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            ID
                        </label>
                        <input type="text" name="id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Name
                        </label>
                        <input type="text" name="name" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Email
                        </label>
                        <input type="email" name="email" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" placeholder="name@company.com" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Password
                        </label>
                        <input type="password" name="password" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>

                    <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Update User
                    </button>
                </form>
            </div>

            <div id="delete-users-content" class="content">
                <form action="" method="DELETE" class="mt-4 p-4">
                    <div class="mb-4">
                        <label for="title" class="block text-xl text-white font-bold">Id:</label>
                        <input type="text" id="id" name="id"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                    </div>
                    <div class="mt-6">
                        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">Delete Carousel</button>
                    </div>
                </form>
            </div>
            <div id="add-movies-content" class="content">
                <h2 class="text-2xl font-semibold text-gray-900 text-white">Add Movie</h2>
                <form class="space-y-6" action="MovieServlet" method="POST">
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Title
                        </label>
                        <input type="text" name="title" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Release Year
                        </label>
                        <input type="number" name="release_year" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Genre
                        </label>
                        <input type="text" name="genre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Duration (minutes)
                        </label>
                        <input type="number" name="duration" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Director
                        </label>
                        <input type="text" name="director" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Producer
                        </label>
                        <input type="text" name="producer" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Cast
                        </label>
                        <textarea name="cast" rows="4" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required></textarea>
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Description
                        </label>
                        <textarea name="description" rows="4" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required></textarea>
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Rating
                        </label>
                        <input type="number" step="0.1" name="rating" min="0" max="10" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div><label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Price
                        </label>
                        <input type="number" step="0.01" name="price" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Time
                        </label>
                        <input type="time" name="time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Image URL
                        </label>
                        <input type="text" name="image" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Category
                        </label>
                        <select name="category" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                            <option value="popular">popular</option>
                            <option value="upcoming">upcoming</option>
                        </select>
                    </div>
                    <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Add Movie
                    </button>
                </form>
            </div>
            <div id="show-movies-content" class="content">
                <div class="col-sm-6">
                    <table class="table-auto">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="px-4 py-2 text-gray-600">Movie ID</th>
                                <th class="px-4 py-2 text-gray-600">Title</th>
                                <th class="px-4 py-2 text-gray-600">Release Year</th>
                                <th class="px-4 py-2 text-gray-600">Genre</th>
                                <th class="px-4 py-2 text-gray-600">Duration</th>
                                <th class="px-4 py-2 text-gray-600">Director</th>
                                <th class="px-4 py-2 text-gray-600">Producer</th>
                                <th class="px-4 py-2 text-gray-600">Cast</th>
                                <th class="px-4 py-2 text-gray-600">Description</th>
                                <th class="px-4 py-2 text-gray-600">Rating</th>
                                <th class="px-4 py-2 text-gray-600">Price</th>
                                <th class="px-4 py-2 text-gray-600">Time</th>
                                <th class="px-4 py-2 text-gray-600">Image</th>
                                <th class="px-4 py-2 text-gray-600">Category</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");
                                    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM movies");
                                    ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td class="px-4 py-2 text-white"><%= rs.getInt("movie_id") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("title") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getInt("release_year") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("genre") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getInt("duration") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("director") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("producer") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("cast") %></td>
                                <td class="px-4 py-2 text-white" style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;"><%= rs.getString("description") %></td>                                <td class="px-4 py-2 text-white"><%= rs.getDouble("rating") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getDouble("price") %></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("time") %></td>
                                <td class="px-4 py-2 text-white"><img src="<%= rs.getString("image") %>" alt="Movie Poster" width="100" height="150"></td>
                                <td class="px-4 py-2 text-white"><%= rs.getString("category") %></td>
                            </tr>
                            <%
                                    }
                                    conn.close();
                                } catch (ClassNotFoundException | SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="update-movies-content" class="content">
                <h2 class="text-2xl font-semibold text-gray-900 text-white">Update Movie</h2>
                <form class="space-y-6" action="MovieServlet" method="POST">
                    <input type="hidden" name="_method" value="PUT">
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Movie ID
                        </label>
                        <input type="text" name="movie_id" id="movie_id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            New Title
                        </label>
                        <input type="text" name="title" id="title" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Release Year
                        </label>
                        <input type="number" name="release_year" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Genre
                        </label>
                        <input type="text" name="genre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Duration (minutes)
                        </label>
                        <input type="number" name="duration" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Director
                        </label>
                        <input type="text" name="director" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Producer
                        </label>
                        <input type="text" name="producer" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Cast
                        </label>
                        <textarea name="cast" rows="4" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required></textarea>
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Description
                        </label>
                        <textarea name="description" rows="4" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required></textarea>
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Rating
                        </label>
                        <input type="number" step="0.1" name="rating" min="0" max="10" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div><label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Price
                        </label>
                        <input type="number" step="0.01" name="price" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Time
                        </label>
                        <input type="time" name="time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Image URL
                        </label>
                        <input type="text" name="image" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Category
                        </label>
                        <select name="category" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                            <option value="popular">popular</option>
                            <option value="upcoming">upcoming</option>
                        </select>
                    </div>
                    <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Update Movie
                    </button>
                </form>
            </div>
            <div id="delete-movies-content" class="content">
                <h2 class="text-2xl font-semibold text-gray-900 text-white">Delete Movie</h2>
                <form class="space-y-6" action="DeleteMovieServlet" method="DELETE">
                    <div>
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                            Movie ID
                        </label>
                        <input type="text" name="movie_id" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                    </div>

                    <button type="submit" class="w-full text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                        Delete Movie
                    </button>
                </form>
            </div>
            <div id="signup-content" class="content">
                Logout
            </div>
        </div>
        <script>
            function toggleDropdown(dropdownId) {
                var dropdown = document.getElementById(dropdownId);
                dropdown.classList.toggle('hidden');
            }

            document.querySelectorAll('[data-collapse-toggle]').forEach(function (button) {
                button.addEventListener('click', function () {
                    var targetDropdownId = this.getAttribute('aria-controls');
                    toggleDropdown(targetDropdownId);
                });
            });
            function showContent(contentId) {
                document.querySelectorAll('.content').forEach(function (content) {
                    content.style.display = 'none';
                });

                var selectedContent = document.getElementById(contentId);
                if (selectedContent) {
                    selectedContent.style.display = 'block';
                }
            }

            document.querySelectorAll('.navbar-link').forEach(function (link) {
                link.addEventListener('click', function (event) {
                    event.preventDefault();

                    var contentId = this.getAttribute('href').substring(1);
                    showContent(contentId);
                });
            });

            showContent('dashboard-content');
        </script>
    </body>
</html>
