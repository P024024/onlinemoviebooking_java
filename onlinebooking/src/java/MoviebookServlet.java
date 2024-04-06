
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MoviebookServlet")
public class MoviebookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedSeats = request.getParameter("selectedSeats");
        String selectedSeatsCount = request.getParameter("selectedSeatsCount");
        String userId = request.getParameter("userId");
        String movieId = request.getParameter("movieId");
        String currentDate = request.getParameter("currentDate");

        String jdbcUrl = "jdbc:mysql://localhost:3308/mysql";
        String dbUsername = "root";
        String dbPassword = "";

        String sql = "INSERT INTO bookings (user_id, movie_id, seat_number, booking_date) VALUES (?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, userId);
            preparedStatement.setString(2, movieId);
            preparedStatement.setString(3, selectedSeats);
            preparedStatement.setString(4, currentDate);

            int rowsInserted = preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();

            if (rowsInserted > 0) {
                String redirectURL = "ticket.jsp?userId=" + userId + "&movieId=" + movieId + "&selectedSeats=" + selectedSeats + "&selectedSeatsCount=" + selectedSeatsCount;
                String script = "<script>window.open('" + redirectURL + "', '_blank');</script>";
                response.getWriter().println(script);
            } else {
                response.getWriter().println("Failed to make a booking.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred while processing your request.");
        }
    }
}
