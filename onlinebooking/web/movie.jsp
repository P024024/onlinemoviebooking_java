<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="css/global.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.8.4/swiper-bundle.min.css" rel="stylesheet">

        <title>Movie Page</title>
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
                            <div class="origin-top-right absolute right-0 mt-2 w-40 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 hidden z-[10]" id="dropdown-menu" aria-labelledby="dropdown-menu">
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
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");
                String carouselQuery = "SELECT * FROM carousel"; 
                stmt = conn.prepareStatement(carouselQuery);
                rs = stmt.executeQuery();
        %>
        <div class="m-8" >
            <div class="flex items-center justify-center">
                <div class="w-full">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <%
                                while (rs.next()) {
                                    String carouselImage = rs.getString("image_url");
                            %>
                            <div class="swiper-slide">
                                <img src="<%=carouselImage%>" alt="carousel image" class="w-full h-[500px] rounded-3xl">
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
        <%
            String popularQuery = "SELECT * FROM movies WHERE category=? LIMIT 6"; 
            stmt = conn.prepareStatement(popularQuery);
            stmt.setString(1, "popular");
            rs = stmt.executeQuery();
        %>
        <div class="m-8">
            <p class="text-2xl font-medium mb-4">Popular Movies</p>
            <div class="flex overflow-x-auto">
                <%
                    while (rs.next()) {
                        int id = rs.getInt("movie_id");
                        String title = rs.getString("title");
                        String desc = rs.getString("description");
                        double rating = rs.getDouble("rating");
                        double price = rs.getDouble("price");
                        String image = rs.getString("image");
                %>
                <div class="flex-none w-96 mr-4">
                    <div class="w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
                        <a href="#">
                            <img class="p-4 h-56 rounded-3xl" src="<%=image%>" alt="product image" />
                        </a>
                        <div class="px-5 pb-5">
                            <a href="#">
                                <h5 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white">
                                    <%= title %>
                                </h5>
                            </a>
                            <p class="text-white text-left py-3 overflow-hidden line-clamp-3">
                                <%= desc %>
                            </p>
                            <a href="moviedetails.jsp?id=<%=id%>" class="text-orange-500 text-md font-medium">
                                See More
                            </a>
                            <div class="flex items-center mt-2.5 mb-5">
                                <div class="flex items-center space-x-1 rtl:space-x-reverse">
                                    <svg class="w-4 h-4 text-yellow-300" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                                    <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                                    </svg>
                                </div>
                                <span class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ms-3">
                                    <%= rating %>
                                </span>
                            </div>
                            <div class="flex items-center justify-between">
                                <span class="text-3xl font-bold text-gray-900 dark:text-white">
                                    $ <%= price%>
                                </span>
                                <a href="book.jsp?movie_id=<%=id%>" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                    Book Now
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            String upcomingQuery = "SELECT * FROM movies WHERE category=? LIMIT 6"; 
            stmt = conn.prepareStatement(upcomingQuery);
            stmt.setString(1, "upcoming");
            rs = stmt.executeQuery();
        %>
        <div class="m-8">
            <p class="text-2xl font-medium mb-4">Upcoming Movies</p>
            <div class="flex overflow-x-auto">
                <%
            while (rs.next()) {
                int id = rs.getInt("movie_id");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                double rating = rs.getDouble("rating");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                %>

                <div class="flex-none w-96 mr-4">
                    <div class="w-full max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
                        <a href="#">
                            <img class="p-4 h-56 rounded-3xl w-full" src="<%=image%>" alt="product image" />
                        </a>
                        <div class="px-5 pb-5">
                            <a href="#">
                                <h5 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white">
                                    <%= title %>
                                </h5>
                            </a>
                            <p class="text-white text-left py-2 overflow-hidden line-clamp-3">
                                <%= desc %>
                            </p>
                            <a href="moviedetails.jsp?id=<%=id%>" class="text-orange-500 text-md font-medium">
                                See More
                            </a>

                            <div class="flex items-center mt-2.5 mb-5">
                                <div class="flex items-center space-x-1 rtl:space-x-reverse">
                                    <svg class="w-4 h-4 text-yellow-300" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                                    <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z" />
                                    </svg>
                                </div>
                                <span class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800 ms-3">
                                    <%= rating %>
                                </span>
                            </div>
                            <div class="flex items-center justify-between">
                                <span class="text-3xl font-bold text-gray-900 dark:text-white">
                                    $ <%= price%>
                                </span>
                                <a href="book.jsp?movie_id=<%=id%>" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                    Book Now
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>

        <script>
            var swiper = new Swiper('.swiper-container', {
                autoplay: {
                    delay: 5000,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
            });
        </script>
<script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('dropdownButton').addEventListener('click', function () {
                    var dropdownMenu = document.getElementById('dropdown-menu');
                    if (dropdownMenu.classList.contains('hidden')) {
                        dropdownMenu.classList.remove('hidden');
                        this.setAttribute('aria-expanded', 'true');
                    } else {
                        dropdownMenu.classList.add('hidden');
                        this.setAttribute('aria-expanded', 'false');
                    }
                });
            });
        </script>
    </body>
</html>
