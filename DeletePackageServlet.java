import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeletePackageServlet")
public class DeletePackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Get Package ID from request
            String packageIdStr = request.getParameter("package_id");
Integer packageId=Integer.parseInt(packageIdStr);
            if (packageIdStr == null || packageIdStr.isEmpty()) {
                out.println("<h3 class='text-danger'>Error: Package ID is missing!</h3>");
                return;
            }

           // int packageId = Integer.parseInt(packageIdStr);

            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            // Step 1: Delete all destinations linked to this package
            String deleteDestQuery = "DELETE FROM destination WHERE pid = ?";
            PreparedStatement psDeleteDest = con.prepareStatement(deleteDestQuery);
            psDeleteDest.setInt(1, packageId);
            psDeleteDest.executeUpdate();
            psDeleteDest.close();

            // Step 2: Delete the package
            String deletePackageQuery = "DELETE FROM package WHERE pid = ?";
            PreparedStatement psDeletePackage = con.prepareStatement(deletePackageQuery);
            psDeletePackage.setInt(1, packageId);
            int rowsAffected = psDeletePackage.executeUpdate();
            psDeletePackage.close();
            con.close();

            if (rowsAffected > 0) {
                response.sendRedirect("Admin.html?status=success");
            } else {
                out.println("<h3 class='text-danger'>Error: Package not found or couldn't be deleted!</h3>");
            }

        } catch (Exception e) {
            out.println("<h3 class='text-danger'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
