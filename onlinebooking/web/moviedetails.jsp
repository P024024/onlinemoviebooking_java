<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Details</title>
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
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", "");
                String movieIdParam = request.getParameter("id");
                int movieId = Integer.parseInt(movieIdParam);

                String query = "SELECT * FROM movies WHERE movie_id = ?";
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, movieId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("title");
                    int releaseYear = rs.getInt("release_year");
                    String genre = rs.getString("genre");
                    int duration = rs.getInt("duration");
                    String director = rs.getString("director");
                    String producer = rs.getString("producer");
                    String cast = rs.getString("cast");
                    String description = rs.getString("description");
                    double rating = rs.getDouble("rating");
                    double price = rs.getDouble("price");
                    String image = rs.getString("image");

        %>

        <div class="relative">
            <img src="<%=image%>" class="h-[420px] w-full" />
            <img src="<%=image%>" class="h-[300px] w-[250px] rounded-2xl absolute top-60 left-20" />
            <div class="flex flex-col md:flex-row mx-auto rounded-xl w-[90%]">
                <div class="flex flex-col absolute top-60 left-[350px]">
                    <div class="p-4 ">
                        <p class="text-orange-500 text-xl font-bold"><%=releaseYear%></p>
                        <h2 class="text-orange-500 text-3xl font-semibold"><%=title%></h2>
                        <p class="text-orange-500"><%=genre%> <%=duration%>mins</p>
                        <div class="flex text-orange-500 gap-[1vw]">
                            <div class="flex flex-col">
                                <div class="text-xl font-semibold">CRITICS</div>
                                <div class="flex items-center">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 16 16"
                                        fill="currentColor"
                                        class="w-10 h-10"
                                        stroke="white"
                                        >
                                    <path
                                        fill-rule="evenodd"
                                        d="M2.742 2.755A2.25 2.25 0 0 1 4.424 2h7.152a2.25 2.25 0 0 1 1.682.755l1.174 1.32c.366.412.568.944.568 1.495v.68a2.25 2.25 0 0 1-2.25 2.25h-9.5A2.25 2.25 0 0 1 1 6.25v-.68c0-.55.202-1.083.568-1.495l1.174-1.32Zm1.682.745a.75.75 0 0 0-.561.252L2.753 5h2.212a1 1 0 0 1 .832.445l.406.61a1 1 0 0 0 .832.445h1.93a1 1 0 0 0 .832-.445l.406-.61A1 1 0 0 1 11.035 5h2.211l-1.109-1.248a.75.75 0 0 0-.56-.252H4.423Z"
                                        clip-rule="evenodd"
                                        />
                                    <path d="M1 10.75a.75.75 0 0 1 .75-.75h3.215a1 1 0 0 1 .832.445l.406.61a1 1 0 0 0 .832.445h1.93a1 1 0 0 0 .832-.445l.406-.61a1 1 0 0 1 .832-.445h3.215a.75.75 0 0 1 .75.75v1A2.25 2.25 0 0 1 12.75 14h-9.5A2.25 2.25 0 0 1 1 11.75v-1Z" />
                                    </svg>
                                    <div>86%</div>
                                </div>
                            </div>
                            <div class="flex flex-col">
                                <div class="text-xl font-semibold">AUDIENCES</div>
                                <div class="flex items-center">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 16 16"
                                        fill="currentColor"
                                        class="w-10 h-10"
                                        stroke="white"
                                        >
                                    <path
                                        fill-rule="evenodd"
                                        d="M2.742 2.755A2.25 2.25 0 0 1 4.424 2h7.152a2.25 2.25 0 0 1 1.682.755l1.174 1.32c.366.412.568.944.568 1.495v.68a2.25 2.25 0 0 1-2.25 2.25h-9.5A2.25 2.25 0 0 1 1 6.25v-.68c0-.55.202-1.083.568-1.495l1.174-1.32Zm1.682.745a.75.75 0 0 0-.561.252L2.753 5h2.212a1 1 0 0 1 .832.445l.406.61a1 1 0 0 0 .832.445h1.93a1 1 0 0 0 .832-.445l.406-.61A1 1 0 0 1 11.035 5h2.211l-1.109-1.248a.75.75 0 0 0-.56-.252H4.423Z"
                                        clip-rule="evenodd"
                                        />
                                    <path d="M1 10.75a.75.75 0 0 1 .75-.75h3.215a1 1 0 0 1 .832.445l.406.61a1 1 0 0 0 .832.445h1.93a1 1 0 0 0 .832-.445l.406-.61a1 1 0 0 1 .832-.445h3.215a.75.75 0 0 1 .75.75v1A2.25 2.25 0 0 1 12.75 14h-9.5A2.25 2.25 0 0 1 1 11.75v-1Z" />
                                    </svg>
                                    <div>86%</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mx-auto bg-white rounded-lg shadow-lg p-8">
            <div class="flex w-[65%] justify-end mx-[30%] border-b-2">
                <div class="flex-1 p-4 border-r-2">
                    <div class="mb-2">
                        <p class="text-gray-700">
                            <%=description%>
                        </p>
                    </div>
                    <div class="flex justify-between items-center mb-4">
                        <button class="bg-transparent hover:bg-black hover:text-white  font-semibold py-3  border-2 text-black px-4 rounded-3xl inline-flex items-center">
                            <span>Watch Later </span>
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M17.25 8.25 21 12m0 0-3.75 3.75M21 12H3"
                                />
                            </svg>
                        </button>
                        <button class="bg-orange-400 hover:bg-orange-500 text-white font-semibold py-3  px-4 rounded-3xl inline-flex items-center">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                />
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M15.91 11.672a.375.375 0 0 1 0 .656l-5.603 3.113a.375.375 0 0 1-.557-.328V8.887c0-.286.307-.466.557-.327l5.603 3.112Z"
                                />
                            </svg>

                            <span>Watch Trailer</span>
                        </button>
                    </div>
                </div>
                <div class="flex">
                    <div class="flex flex-col p-2">
                        <h3 class="text-lg text-orange-500 font-semibold mb-2">Movie Details</h3>
                        <p class="text-gray-700">Director: <%=director%></p>
                        <p class="text-gray-700">Producer: <%=producer%></p>
                        <p class="text-gray-700">Cast: <%=cast%></p>
                    </div>
                </div>
            </div>
            <div class="flex flex-col md:flex-row w-[92%] mx-auto mt-10">
                <div class="flex-1 mr-4">
                    <div class="mb-8">
                        <h2 class="text-2xl text-orange-500 font-semibold mb-4"><%=title%></h2>
                        <p class="text-gray-700 mb-4"><%=description%></p>
                        <img src="<%=image%>" class="h-[300px] w-full rounded-2xl" />
                    </div>
                </div>
                <div class="flex-1 ml-4">
                    <h2 class="text-xl text-orange-500 font-semibold mb-4">Photos & Videos</h2>
                    <div class="flex flex-wrap -mx-2">
                        <!-- Photos section -->
                    </div>
                </div>
            </div>
        </div>

        <%
                } else {
                    out.println("Movie not found");
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>
