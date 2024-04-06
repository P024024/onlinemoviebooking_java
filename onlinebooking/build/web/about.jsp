<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About Us</title>
         <script src="https://cdn.tailwindcss.com"></script>
        <link href="css/global.css" rel="stylesheet" type="text/css"/>
    </head>

    <body class="bg-gray-100">
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
                                    <a href="#" id="profileOption" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Profile</a>
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
        <h2 class="text-6xl font-extrabold text-gray-900  text-center p-4">About Us</h2>
        <section class="bg-white dark:bg-gray-900 py-12">
            <div class="container mx-auto px-4 flex flex-col lg:flex-row justify-between items-center">
                <div class="w-full lg:w-1/2 lg:pr-8">
                    <h2 class="text-4xl font-extrabold text-gray-900 dark:text-white mb-4">Welcome to Our Team</h2>
                    <p class="text-gray-600 dark:text-gray-400 leading-relaxed mb-6">
                        At our company, we strive to create innovative solutions for our clients. 
                        We are a team of strategists, designers, and developers who are passionate 
                        about solving problems and delivering exceptional results.
                    </p>
                    <p class="text-gray-600 dark:text-gray-400 leading-relaxed">
                        Our mission is to exceed the expectations of our clients by providing 
                        high-quality services and maintaining strong relationships. We are dedicated 
                        to continuous improvement and staying ahead of the curve in technology and design.
                    </p>
                </div>
                <div class="w-full lg:w-1/2 mt-8 lg:mt-0 grid grid-cols-2 gap-4">
                    <img class="w-full rounded-lg" src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/content/office-long-2.png" alt="Office Content 1">
                    <img class="w-full rounded-lg" src="https://flowbite.s3.amazonaws.com/blocks/marketing-ui/content/office-long-1.png" alt="Office Content 2">
                </div>
            </div>
        </section>

        <!-- Developer Section -->
        <section class="container mx-auto m-12">
            <h2 class="text-3xl font-bold mb-8 text-center">Meet Our Developers</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-8">
                <div class="flex items-center bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                    <img src="sakun_panthi_photo.jpg" alt="Sakun Panthi Photo" class="w-16 h-16 rounded-full mr-4">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Sakun Panthi</h3>
                        <p class="text-gray-600 dark:text-gray-400">Lead Developer</p>
                    </div>
                </div>

                <!-- Developer 2 -->
                <div class="flex items-center bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                    <img src="pawan_ghimire_photo.jpg" alt="Pawan Ghimire Photo" class="w-16 h-16 rounded-full mr-4">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Pawan Ghimire</h3>
                        <p class="text-gray-600 dark:text-gray-400">Senior Developer</p>
                    </div>
                </div>
            </div>
        </section>
        <!--For the footer section -->
        <footer class="bg-white dark:bg-gray-900">
            <div class="mx-auto w-full max-w-screen-xl">
                <div class="grid grid-cols-2 gap-8 px-4 py-6 lg:py-8 md:grid-cols-4">
                    <div>
                        <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Company</h2>
                        <ul class="text-gray-500 dark:text-gray-400 font-medium gap-[1vw] flex flex-col">
                            <a href="" class="hover:underline ">About</a>
                            <a href="" class="hover:underline ">Careers</a>
                            <a href="" class="hover:underline ">Docs</a>
                            <a href="" class="hover:underline ">Blog</a>

                        </ul>
                    </div>
                    <div>
                        <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Help center</h2>
                        <ul class="text-gray-500 dark:text-gray-400 font-medium flex flex-col gap-[1vw]">
                            <a href="" class="hover:underline ">Discord Server</a>
                            <a href="" class="hover:underline ">Twitter</a>
                            <a href="" class="hover:underline ">Facebook</a>
                            <a href="" class="hover:underline ">Contact Us</a>
                        </ul>
                    </div>
                    <div>
                        <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Legal</h2>
                        <ul class="text-gray-500 dark:text-gray-400 font-medium flex flex-col gap-[1vw]">
                            <a href="" class="hover:underline ">Privacy Policy</a>
                            <a href="" class="hover:underline ">Licensing</a>
                            <a href="" class="hover:underline ">Terms &amp; Conditions</a>
                        </ul>
                    </div>
                    <div>
                        <h2 class="mb-6 text-sm font-semibold text-gray-900 uppercase dark:text-white">Download</h2>
                        <ul class="text-gray-500 dark:text-gray-400 font-medium flex flex-col gap-[1vw]">
                            <a href="" class="hover:underline ">iOS</a>
                            <a href="" class="hover:underline ">Android</a>
                            <a href="" class="hover:underline ">Windows</a>
                            <a href="" class="hover:underline ">MacOS</a>
                        </ul>
                    </div>
                </div>
                <div class="px-4 py-6 bg-gray-100 dark:bg-gray-700 md:flex md:items-center md:justify-between">
                    <span class="text-sm text-white dark:text-white sm:text-center">© 2023 <a href="">OnlineBooking</a>. All Rights Reserved.
                    </span>
                    <div class="flex mt-4 sm:justify-center md:mt-0 space-x-5 rtl:space-x-reverse">
                        <a href="#" class="text-white hover:text-white dark:hover:text-white">
                            <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 8 19">
                            <path fill-rule="evenodd" d="M6.135 3H8V0H6.135a4.147 4.147 0 0 0-4.142 4.142V6H0v3h2v9.938h3V9h2.021l.592-3H5V3.591A.6.6 0 0 1 5.592 3h.543Z" clip-rule="evenodd"/>
                            </svg>
                            <span class="sr-only">Facebook page</span>
                        </a>
                        <a href="#" class="text-white hover:text-white dark:hover:text-white">
                            <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 21 16">
                            <path d="M16.942 1.556a16.3 16.3 0 0 0-4.126-1.3 12.04 12.04 0 0 0-.529 1.1 15.175 15.175 0 0 0-4.573 0 11.585 11.585 0 0 0-.535-1.1 16.274 16.274 0 0 0-4.129 1.3A17.392 17.392 0 0 0 .182 13.218a15.785 15.785 0 0 0 4.963 2.521c.41-.564.773-1.16 1.084-1.785a10.63 10.63 0 0 1-1.706-.83c.143-.106.283-.217.418-.33a11.664 11.664 0 0 0 10.118 0c.137.113.277.224.418.33-.544.328-1.116.606-1.71.832a12.52 12.52 0 0 0 1.084 1.785 16.46 16.46 0 0 0 5.064-2.595 17.286 17.286 0 0 0-2.973-11.59ZM6.678 10.813a1.941 1.941 0 0 1-1.8-2.045 1.93 1.93 0 0 1 1.8-2.047 1.919 1.919 0 0 1 1.8 2.047 1.93 1.93 0 0 1-1.8 2.045Zm6.644 0a1.94 1.94 0 0 1-1.8-2.045 1.93 1.93 0 0 1 1.8-2.047 1.918 1.918 0 0 1 1.8 2.047 1.93 1.93 0 0 1-1.8 2.045Z"/>
                            </svg>
                            <span class="sr-only">Discord community</span>
                        </a>
                        <a href="#" class="text-white hover:text-white dark:hover:text-white">
                            <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 17">
                            <path fill-rule="evenodd" d="M20 1.892a8.178 8.178 0 0 1-2.355.635 4.074 4.074 0 0 0 1.8-2.235 8.344 8.344 0 0 1-2.605.98A4.13 4.13 0 0 0 13.85 0a4.068 4.068 0 0 0-4.1 4.038 4 4 0 0 0 .105.919A11.705 11.705 0 0 1 1.4.734a4.006 4.006 0 0 0 1.268 5.392 4.165 4.165 0 0 1-1.859-.5v.05A4.057 4.057 0 0 0 4.1 9.635a4.19 4.19 0 0 1-1.856.07 4.108 4.108 0 0 0 3.831 2.807A8.36 8.36 0 0 1 0 14.184 11.732 11.732 0 0 0 6.291 16 11.502 11.502 0 0 0 17.964 4.5c0-.177 0-.35-.012-.523A8.143 8.143 0 0 0 20 1.892Z" clip-rule="evenodd"/>
                            </svg>
                            <span class="sr-only">Twitter page</span>
                        </a>
                        <a href="https://github.com/P024024/onlinebooking" class="text-white hover:text-white dark:hover:text-white">
                            <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 .333A9.911 9.911 0 0 0 6.866 19.65c.5.092.678-.215.678-.477 0-.237-.01-1.017-.014-1.845-2.757.6-3.338-1.169-3.338-1.169a2.627 2.627 0 0 0-1.1-1.451c-.9-.615.07-.6.07-.6a2.084 2.084 0 0 1 1.518 1.021 2.11 2.11 0 0 0 2.884.823c.044-.503.268-.973.63-1.325-2.2-.25-4.516-1.1-4.516-4.9A3.832 3.832 0 0 1 4.7 7.068a3.56 3.56 0 0 1 .095-2.623s.832-.266 2.726 1.016a9.409 9.409 0 0 1 4.962 0c1.89-1.282 2.717-1.016 2.717-1.016.366.83.402 1.768.1 2.623a3.827 3.827 0 0 1 1.02 2.659c0 3.807-2.319 4.644-4.525 4.889a2.366 2.366 0 0 1 .673 1.834c0 1.326-.012 2.394-.012 2.72 0 .263.18.572.681.475A9.911 9.911 0 0 0 10 .333Z" clip-rule="evenodd"/>
                            </svg>
                            <span class="sr-only">GitHub account</span>
                        </a>
                        <a href="#" class="text-white hover:text-white dark:hover:text-white">
                            <svg class="w-4 h-4" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 0a10 10 0 1 0 10 10A10.009 10.009 0 0 0 10 0Zm6.613 4.614a8.523 8.523 0 0 1 1.93 5.32 20.094 20.094 0 0 0-5.949-.274c-.059-.149-.122-.292-.184-.441a23.879 23.879 0 0 0-.566-1.239 11.41 11.41 0 0 0 4.769-3.366ZM8 1.707a8.821 8.821 0 0 1 2-.238 8.5 8.5 0 0 1 5.664 2.152 9.608 9.608 0 0 1-4.476 3.087A45.758 45.758 0 0 0 8 1.707ZM1.642 8.262a8.57 8.57 0 0 1 4.73-5.981A53.998 53.998 0 0 1 9.54 7.222a32.078 32.078 0 0 1-7.9 1.04h.002Zm2.01 7.46a8.51 8.51 0 0 1-2.2-5.707v-.262a31.64 31.64 0 0 0 8.777-1.219c.243.477.477.964.692 1.449-.114.032-.227.067-.336.1a13.569 13.569 0 0 0-6.942 5.636l.009.003ZM10 18.556a8.508 8.508 0 0 1-5.243-1.8 11.717 11.717 0 0 1 6.7-5.332.509.509 0 0 1 .055-.02 35.65 35.65 0 0 1 1.819 6.476 8.476 8.476 0 0 1-3.331.676Zm4.772-1.462A37.232 37.232 0 0 0 13.113 11a12.513 12.513 0 0 1 5.321.364 8.56 8.56 0 0 1-3.66 5.73h-.002Z" clip-rule="evenodd"/>
                            </svg>
                            <span class="sr-only">Dribbble account</span>
                        </a>
                    </div>
                </div>
            </div>
        </footer>
    </body>

</html>
