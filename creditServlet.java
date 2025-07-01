import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/creditServlet")
public class creditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PrintWriter out = response.getWriter();

        try {
            response.setContentType("text/html");

            // Retrieve form parameters
            String cardHolder = request.getParameter("card_holder");
            String cardNumber = request.getParameter("card_number");
            String expireDate = request.getParameter("expire_date");
            int cvc = Integer.parseInt(request.getParameter("CVC"));

            // Retrieve package cost from session
            Object packCost = session.getAttribute("cost");
            if (packCost == null) {
                out.println("<script>alert('Error: Package cost not found.'); window.location='payment.jsp';</script>");
                return;
            }
            double cost = Double.parseDouble(packCost.toString());

            // Retrieve booking ID from session
            Object bookIdObj = session.getAttribute("bid");
            if (bookIdObj == null) {
                out.println("<script>alert('Error: Booking ID not found.'); window.location='payment.jsp';</script>");
                return;
            }
            int bid = Integer.parseInt(bookIdObj.toString());

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            // Check available packages
            String query = "SELECT * FROM package WHERE pid IN (SELECT pid FROM booking WHERE bid=?)";
            ps = con.prepareStatement(query);
            ps.setInt(1, bid);
            rs = ps.executeQuery();

            boolean packageAvailable = false;
            int pidnew = -1;

            while (rs.next()) {
                if (rs.getInt("no_left") > 0) {
                    packageAvailable = true;
                    pidnew = rs.getInt("pid");
                    break;
                }
            }

            // If no packages are available, alert the user
            if (!packageAvailable) {
                out.println("<script>alert('No packages left! Please select another package.'); window.location='payment.jsp';</script>");
                return;
            }

            // Update available package count (no_left)
            query = "UPDATE package SET no_left = no_left - 1 WHERE pid = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, pidnew);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Package availability updated successfully.");
            }

            // Check credit card details and balance
            query = "SELECT balance FROM credit WHERE card_holder = ? AND card_no = ? AND expire_date = ? AND cvc = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, cardHolder);
            ps.setString(2, cardNumber);
            ps.setString(3, expireDate);
            ps.setInt(4, cvc);

            rs = ps.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");

                // Check if the balance is sufficient
                if (balance >= cost) {
                    // Deduct the amount from the balance
                    double newBalance = balance - cost;
                    query = "UPDATE credit SET balance = ? WHERE card_holder = ?";
                    ps = con.prepareStatement(query);
                    ps.setDouble(1, newBalance);
                    ps.setString(2, cardHolder);
                    int updatedRows = ps.executeUpdate();

                    if (updatedRows > 0) {
                        System.out.println("Balance updated successfully.");
                    }

                    // Update booking status to "Paid"
                    query = "UPDATE booking SET status = 'Paid' WHERE bid = ?";
                    ps = con.prepareStatement(query);
                    ps.setInt(1, bid);
                    int updatedBooking = ps.executeUpdate();

                    if (updatedBooking > 0) {
                        System.out.println("Booking status updated to 'Paid'.");
                    }

                    // Redirect to success page
                 //   out.println("<script>alert('Payment Successful!'); window.location='success.jsp';</script>");
                    response.sendRedirect("success.jsp");
                } else {
                    // Alert for low balance
                    out.println("<script>alert('Insufficient Balance! Please use another card.'); window.location='payment.jsp';</script>");
                }
            } else {
                // Alert for invalid card details
                out.println("<script>alert('Invalid Card Details! Please try again.'); window.location='payment.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='payment.jsp';</script>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
