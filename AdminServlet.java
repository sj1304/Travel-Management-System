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

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            // Count users
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM register");
            ResultSet rs1 = ps1.executeQuery();
            rs1.next();
            int userCount = rs1.getInt(1);

            // Count bookings
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM booking");
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            int bookingCount = rs2.getInt(1);

            // Get tour packages
            PreparedStatement ps3 = con.prepareStatement("SELECT pid, pack_name, cost FROM package");
            ResultSet rs3 = ps3.executeQuery();

            // Dashboard Cards
            out.println("<div class='row'>");
            out.println("<div class='col-md-4'><div class='card p-3 text-center'><h4>Users</h4><h2>" + userCount + "</h2></div></div>");
            out.println("<div class='col-md-4'><div class='card p-3 text-center'><h4>Bookings</h4><h2>" + bookingCount + "</h2></div></div>");
            out.println("</div>");

            // User Details Table
            out.println("<h3 class='mt-4'>User Details</h3>");
            out.println("<table class='table table-bordered'><tr><th>User ID</th><th>Name</th><th>Email</th><th>Action</th></tr>");

            PreparedStatement ps4 = con.prepareStatement("SELECT uid, name, email FROM register");
            ResultSet rs4 = ps4.executeQuery();
            while (rs4.next()) {
                out.println("<tr>");
                out.println("<td>" + rs4.getInt("uid") + "</td>");
                out.println("<td>" + rs4.getString("name") + "</td>");
                out.println("<td>" + rs4.getString("email") + "</td>");
                out.println("<td><form action='DeleteUserServlet' method='post'>");
                out.println("<input type='hidden' name='uid' value='" + rs4.getInt("uid") + "'>");
                out.println("<button type='submit' class='btn btn-danger btn-sm'>Delete</button>");
                out.println("</form></td>");
                out.println("</tr>");
            }
            out.println("</table>");

            // Package Details Table
            out.println("<h3 class='mt-4'>Tour Packages</h3>");
            out.println("<table class='table table-bordered'><tr><th>Package ID</th><th>Package Name</th><th>Price</th><th>Action</th><th>Action</th></tr>");

            while (rs3.next()) {
                out.println("<tr>");
                out.println("<td>" + rs3.getInt("pid") + "</td>");
                out.println("<td>" + rs3.getString("pack_name") + "</td>");
                out.println("<td>Rs" + rs3.getInt("cost") + "</td>");
                out.println("<td><form action='DeletePackageServlet' method='post'>");
                out.println("<input type='hidden' name='package_id' value='" + rs3.getInt("pid") + "'>");
                out.println("<button type='submit' class='btn btn-danger btn-sm'>Delete</button>");
                out.println("</form></td>");
                //update
                out.println("<td><form action='UpdatePackage.jsp' method='get'>");
                out.println("<input type='hidden' name='package_id' value='" + rs3.getInt("pid") + "'>");
                out.println("<input type='hidden' name='pack_name' value='" + rs3.getString("pack_name") + "'>");
                out.println("<input type='hidden' name='cost' value='" + rs3.getInt("cost") + "'>");
                out.println("<button type='submit' class='btn btn-danger btn-sm''>Update</button>");
                out.println("</form></td>");
//till here
                out.println("</tr>");
            }
            out.println("</table>");
            
         // Review Details Table
            out.println("<h3 class='mt-4'>User Reviews</h3>");
            out.println("<table class='table table-bordered'><tr><th>Review ID</th><th>User ID</th><th>Review</th><th>Action</th></tr>");

            PreparedStatement ps5 = con.prepareStatement("SELECT rid,rating,feedback FROM review"); // Adjust table & column names
            ResultSet rs5 = ps5.executeQuery();

            while (rs5.next()) {
                out.println("<tr>");
                out.println("<td>" + rs5.getInt("rid") + "</td>");
                out.println("<td>" + rs5.getInt("rating") + "</td>");
                out.println("<td>" + rs5.getString("feedback") + "</td>");
                out.println("<td><form action='DeleteReviewServlet' method='post'>");
                out.println("<input type='hidden' name='rid' value='" + rs5.getInt("rid") + "'>");
                out.println("<button type='submit' class='btn btn-danger btn-sm'>Delete</button>");
                out.println("</form></td>");
                out.println("</tr>");
            }
            out.println("</table>");

            //response.sendRedirect("DeletePackageServlet?pid=" +rs3.getInt("pid"));
         // Add Destination Form
            out.println("<h3 class='mt-4'>Add New Package & Destination</h3>");
            out.println("<form action='AddPackageServlet' method='post' enctype='multipart/form-data'>");

            // Package Details
            out.println("<h4>Package Details</h4>");
            out.println("<input type='text' name='pack_name' placeholder='Package Name' required class='form-control mb-2'>");
            out.println("<input type='file' name='images' required class='form-control mb-2'>");
            out.println("<input type='number' name='cost' placeholder='Price' required class='form-control mb-2'>");
            out.println("<textarea name='descrip' placeholder='Package Description' required class='form-control mb-2'></textarea>");
            out.println("<input type='number' name='tid' placeholder='tour id' required class='form-control mb-2'>");
            out.println("<input type='number' name='no_left' placeholder='number left'required class='form-control mb-2'>");
            // Guide Details
            out.println("<h4>Guide Details</h4>");
            out.println("<input type='text' name='guide_name' placeholder='Guide Name' required class='form-control mb-2'>");
            out.println("<input type='text' name='guide_contact' placeholder='Guide Contact' required class='form-control mb-2'>");
            out.println("<input type='email' name='guide_email' placeholder='Guide Email' required class='form-control mb-2'>");
            out.println("<textarea name='guide_desc' placeholder='Guide Description' required class='form-control mb-2'></textarea>");
            out.println("<input type='number' name='book_limit' placeholder='book_limit' required class='form-control mb-2'>");

           
            
            out.println("<button type='submit' class='btn btn-success'>Add Package</button>");
            out.println("</form>");

             
            con.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    }
}
