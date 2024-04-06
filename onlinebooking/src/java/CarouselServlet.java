import com.example.models.Carousel;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CarouselServlet")
public class CarouselServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3308/mysql";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String imageUrl = request.getParameter("image_url");
        String description = request.getParameter("description");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String query = "INSERT INTO carousel (title, image_url, description) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, title);
            pstmt.setString(2, imageUrl);
            pstmt.setString(3, description);
            pstmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/adminpanel.jsp");

        } catch (ClassNotFoundException | SQLException e) {

        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Carousel> carouselList = new ArrayList<>();


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String query = "SELECT * FROM carousel";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            System.out.println(rs);

            while (rs.next()) {
                String slide_id = rs.getString("slide_id");
                String title = rs.getString("title");
                String imageUrl = rs.getString("image_url");
                String description = rs.getString("description");

                Carousel carousel = new Carousel(slide_id,title, imageUrl, description);
                carouselList.add(carousel);
            }

            request.setAttribute("carouselList", carouselList);
            request.getRequestDispatcher("/adminpanel.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
