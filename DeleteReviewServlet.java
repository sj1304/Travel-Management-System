import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("admin_id"); // Get admin_id from session
        String role = (String) session.getAttribute("role");

        if (adminId == null || role == null || !role.equals("admin")) {
            response.sendRedirect("user_login.html"); // Redirect if not logged in
            return;
        }

        int rid = Integer.parseInt(request.getParameter("rid"));

        Connection con = null;
        PreparedStatement pst = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
            String sql = "DELETE FROM review WHERE rid=?";
            pst = con.prepareStatement(sql);
            pst.setInt(1, rid);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                session.setAttribute("message", "Review deleted successfully.");
            } else {
                session.setAttribute("message", "Failed to delete review.");
            }

            response.sendRedirect("admin_review.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_review.jsp?error=Something went wrong.");
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
