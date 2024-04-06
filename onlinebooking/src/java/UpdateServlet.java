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

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/mysql", "root", ""); 
             PreparedStatement pst = conn.prepareStatement("UPDATE users SET name=?, email=?, password=? WHERE id=?")) {

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setInt(4, id);

            int rowsAffected = pst.executeUpdate();

            response.getWriter().write(rowsAffected > 0 ? "Data has been updated successfully" : "Failed to update data");
        } catch (SQLException ex) {
            throw new ServletException("Database operation failed", ex);
        }
    }
}
