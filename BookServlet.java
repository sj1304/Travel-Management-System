import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BookServlet
 */
@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;

        try {
            // Parse form inputs
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = dateFormat.parse(request.getParameter("departureDate"));
            Date endDate = dateFormat.parse(request.getParameter("returnDate"));
            int adults = Integer.parseInt(request.getParameter("adults"));
            int children = Integer.parseInt(request.getParameter("children"));
            int totalPersons = adults + children;

            // Retrieve Package ID from session safely
           Object pidObj = session.getAttribute("packageId");
            if (pidObj == null) {
                response.getWriter().println("Error: Package ID not found in session.");
                return;
            }

            // Convert packageId from String to Integer safely
            int packageId = Integer.parseInt(pidObj.toString());
            System.out.println("booking pid="+packageId);
int uid=0;
            Object temp=session.getAttribute("userid");
if(temp!=null)
{
	uid=Integer.parseInt(temp.toString());
}
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
            System.out.println("Database Connected Successfully!");
           
            String query1 = "SELECT * FROM package WHERE pid=?";
            ps1 = con.prepareStatement(query1);
            ps1.setInt(1, packageId);
            rs1 = ps1.executeQuery();

            int availableLimit = 0;
            int packageDuration = 0;
            if (rs1.next()) {
                availableLimit = rs1.getInt("book_limit");
                packageDuration = rs1.getInt("duration");
                System.out.println("Booking limit: " + availableLimit);
                System.out.println("Package duration: " + packageDuration);
            }

            // Check if start date is today or in the future
            Date today = new Date();
            if (startDate.before(today)) {
                response.getWriter().println("<script>alert('Error: Start date must be a future date.'); window.location='booking.html';</script>");
                return;
            }

            // Check if end date is after start date
            if (endDate.before(startDate)) {
                response.getWriter().println("<script>alert('Error: End date must be after the start date.'); window.location='Booking.html';</script>");
                return;
            }

            // Calculate the actual duration (difference in days)
            long durationInMillis = endDate.getTime() - startDate.getTime();
            int actualDuration = (int) TimeUnit.DAYS.convert(durationInMillis, TimeUnit.MILLISECONDS);

            // Check if duration matches the package duration
            if (actualDuration != packageDuration) {
                response.getWriter().println("<script>alert('Error: The selected duration must be " + packageDuration + " days.'); window.location='Booking.jsp';</script>");
                return;
            }

            // Check if booking is possible
            if (availableLimit >= totalPersons) {
                // Insert booking into the database
                String insertQuery = "INSERT INTO booking (start_date, end_date, adults, children, pid,uid) VALUES (?, ?, ?, ?, ?,?)";
                ps = con.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setDate(1, new java.sql.Date(startDate.getTime()));
                ps.setDate(2, new java.sql.Date(endDate.getTime()));
                ps.setInt(3, adults);
                ps.setInt(4, children);
                ps.setInt(5, packageId);
                ps.setInt(6,uid);
                
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    rs2 = ps.getGeneratedKeys();
                    if (rs2.next()) {
                        int bid = rs2.getInt(1);
                        System.out.println("Booking Successful! bid=" + bid);
                        session.setAttribute("bid", bid);
                        response.sendRedirect("payment.jsp"); // Redirect to payment page
                    } else {
                        response.getWriter().println("Booking ID retrieval failed.");
                    }
                } else {
                    response.getWriter().println("Booking Failed!");
                }
            } else {
                // Send an alert for unavailable seats
                response.getWriter().println("<script>alert('Not enough seats available. Only " + availableLimit + " left.'); window.location='Booking.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs1 != null) rs1.close();
                if (rs2 != null) rs2.close();
                if (ps1 != null) ps1.close();
                if (ps != null) ps.close();
                if (ps2 != null) ps2.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
