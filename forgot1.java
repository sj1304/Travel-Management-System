import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/forgot1")
public class forgot1 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String answer = request.getParameter("answer");
        String newPassword = request.getParameter("newPassword");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
            System.out.println("Database Connected Successfully!");
            PreparedStatement ps = con.prepareStatement("SELECT answer FROM register WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                if (rs.getString("answer").equalsIgnoreCase(answer)) {
                    PreparedStatement updatePs = con.prepareStatement("UPDATE register SET password = ? WHERE email = ?");
                    updatePs.setString(1, newPassword);
                    updatePs.setString(2, email);
                    updatePs.executeUpdate();
                    out.print("Password reset successfully!");
                } else {
                    out.print("Incorrect answer!");
                }
            } else {
                out.print("User not found!");
            }
        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    }
}

