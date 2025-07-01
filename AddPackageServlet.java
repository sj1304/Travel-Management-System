import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/AddPackageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddPackageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

            // Retrieve Package Details
            String packName = request.getParameter("pack_name");
            Part packageImagePart = request.getPart("images");
            String cost = request.getParameter("cost");
            String descrip = request.getParameter("descrip");
            String tour_id = request.getParameter("tid");
            String left = request.getParameter("no_left");
            String guideName = request.getParameter("guide_name");
            String guideContact = request.getParameter("guide_contact");
            String guideEmail = request.getParameter("guide_email");
            String guideDesc = request.getParameter("guide_desc");
            String limit = request.getParameter("book_limit");

            // Save image to server and get only file name
            String packageImageFileName = saveFile(packageImagePart, "images");

            // Insert Package into Database
            String packageQuery = "INSERT INTO package (pack_name, images, cost, descrip, tid, no_left, guide_name, guide_contact, guide_email, guide_desc, book_limit) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(packageQuery, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, packName);
            ps.setString(2, packageImageFileName); // insert only the file name
            ps.setDouble(3, Double.parseDouble(cost));
            ps.setString(4, descrip);
            ps.setInt(5, Integer.parseInt(tour_id));
            ps.setInt(6, Integer.parseInt(left));
            ps.setString(7, guideName);
            ps.setString(8, guideContact);
            ps.setString(9, guideEmail);
            ps.setString(10, guideDesc);
            ps.setInt(11, Integer.parseInt(limit));
            ps.executeUpdate();

            // Get Generated Package ID
            int packageId = 0;
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                packageId = rs.getInt(1);
            }

            con.close();

            // Redirect to AddDestinationServlet with the generated package ID
            response.sendRedirect("addDestination.jsp?pid=" + packageId);

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

        // Generate unique file name
        String fileName =filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;

        // Save file to disk
        filePart.write(filePath);

        // Return only the file name for database
        return fileName;
    }
}
