import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdatePackageServlet")
public class UpdatePackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int packageId = Integer.parseInt(request.getParameter("package_id"));
        int cost = Integer.parseInt(request.getParameter("cost"));
        String costDistribution = request.getParameter("cost_distribution");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            String sql = "UPDATE package SET cost=?  WHERE pid=?";
            String q="update destination set cost_distribution=? where pid=?";
            PreparedStatement ps = con.prepareStatement(sql);
            PreparedStatement ps1 = con.prepareStatement(q);
            ps.setInt(1, cost);
            ps.setInt(2, packageId);
            ps1.setString(1, costDistribution);
            ps1.setInt(2, packageId);
            int updated = ps.executeUpdate();
            int updated_dest = ps1.executeUpdate();
            con.close();

            if (updated > 0) {
                response.sendRedirect("Admin.html?updateSuccess=true"); // Redirect back to admin panel
            } else {
                response.sendRedirect("Admin.html?updateError=true"); // Redirect with error
            }
            if (updated_dest > 0) {
                response.sendRedirect("Admin.html?updateSuccess=true"); // Redirect back to admin panel
            } else {
                response.sendRedirect("Admin.html?update_destError=true"); // Redirect with error
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
