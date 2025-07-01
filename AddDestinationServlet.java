import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;

@WebServlet("/AddDestinationServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddDestinationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            // Retrieve Destination Details
            String pid = request.getParameter("pid");
            String dname = request.getParameter("dname");
            String highlight = request.getParameter("highlight");
            String days = request.getParameter("days");
            String dayPlan = request.getParameter("day_plan");
            String path = request.getParameter("path");
           // Part destinationImagePart = request.getPart("destination_image");
            String costDistribution = request.getParameter("cost_distribution");
            String hotel = request.getParameter("hotel");

            // Save Destination Image
           // String destinationImagePath = saveFile(destinationImagePart, "destination_images");

            // Insert Destination into Database
            String destinationQuery = "INSERT INTO destination (dname, highlight, days, day_plan, path, pid, cost_distribution, hotel) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(destinationQuery);
            ps.setString(1, dname);
            ps.setString(2, highlight);
            ps.setString(3, days);
            ps.setString(4, dayPlan);
            ps.setString(5,path);
           // ps.setString(5, destinationImagePath);
            ps.setInt(6, Integer.parseInt(pid));
            ps.setString(7, costDistribution);
            ps.setString(8, hotel);
            ps.executeUpdate();

            out.println("<h3 class='text-success'>Destination Added Successfully!</h3>");
            con.close();
        } catch (Exception e) {
            out.println("<h3 class='text-danger'>Error: " + e.getMessage() + "</h3>");
        }
    }

    private String saveFile(Part filePart, String folderName) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        String uploadPath = "C:\\server_uploads\\" + folderName;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        return fileName;
    }
}
