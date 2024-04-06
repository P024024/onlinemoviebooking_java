import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/MovieServlet")
public class MovieServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3308/mysql";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("_method");
        if ("PUT".equals(method)) {
            updateMovie(request, response);
        } else {
            addMovie(request, response);
        }
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        int releaseYear = Integer.parseInt(request.getParameter("release_year"));
        String genre = request.getParameter("genre");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String director = request.getParameter("director");
        String producer = request.getParameter("producer");
        String cast = request.getParameter("cast");
        String description = request.getParameter("description");
        double rating = Double.parseDouble(request.getParameter("rating"));
        double price = Double.parseDouble(request.getParameter("price"));
        String time = request.getParameter("time");
        String imageUrl = request.getParameter("image");
        String category = request.getParameter("category");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO movies (title, release_year, genre, duration, director, producer, cast, description, rating, price, time, image, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, title);
                pstmt.setInt(2, releaseYear);
                pstmt.setString(3, genre);
                pstmt.setInt(4, duration);
                pstmt.setString(5, director);
                pstmt.setString(6, producer);
                pstmt.setString(7, cast);
                pstmt.setString(8, description);
                pstmt.setDouble(9, rating);
                pstmt.setDouble(10, price);
                pstmt.setString(11, time);
                pstmt.setString(12, imageUrl);
                pstmt.setString(13, category);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.getWriter().println("Movie added successfully.");
                } else {
                    response.getWriter().println("Failed to add movie.");
                }
                pstmt.close();
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
            response.getWriter().println("Error: " + ex.getMessage());
        }
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movie_id"));
        String title = request.getParameter("title");
        int releaseYear = Integer.parseInt(request.getParameter("release_year"));
        String genre = request.getParameter("genre");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String director = request.getParameter("director");
        String producer = request.getParameter("producer");
        String cast = request.getParameter("cast");
        String description = request.getParameter("description");
        double rating = Double.parseDouble(request.getParameter("rating"));
        double price = Double.parseDouble(request.getParameter("price"));
        String time = request.getParameter("time");
        String imageUrl = request.getParameter("image");
        String category = request.getParameter("category");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE movies SET title=?, release_year=?, genre=?, duration=?, director=?, producer=?, cast=?, description=?, rating=?, price=?, time=?, image=?, category=? WHERE movie_id=?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, title);
                pstmt.setInt(2, releaseYear);
                pstmt.setString(3, genre);
                pstmt.setInt(4, duration);
                pstmt.setString(5, director);
                pstmt.setString(6, producer);
                pstmt.setString(7, cast);
                pstmt.setString(8, description);
                pstmt.setDouble(9, rating);
                pstmt.setDouble(10, price);
                pstmt.setString(11, time);
                pstmt.setString(12, imageUrl);
                pstmt.setString(13, category);
                pstmt.setInt(14, movieId);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.getWriter().println("Movie updated successfully.");
                } else {
                    response.getWriter().println("Failed to update movie.");
                }
                pstmt.close();
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
            response.getWriter().println("Error: " + ex.getMessage());
        }
    }
}
