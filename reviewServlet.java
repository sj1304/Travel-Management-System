import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.*;
@MultipartConfig( // Required for file upload
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/reviewServlet")
public class reviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
 try {
 PreparedStatement ps;
 Connection con;
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

        // Check available packages
        String query = "insert into review(profile,rating,feedback) values(?,?,?)";
        ps = con.prepareStatement(query);
        ps.setString(1,request.getParameter("profile"));
        ps.setInt(2, Integer.parseInt(request.getParameter("rating")));
        ps.setString(3, request.getParameter("feedback"));
        int rows = ps.executeUpdate();
        if(rows!=0)
        {
        	System.out.println("reviews given!");
        	response.sendRedirect("review.jsp");
        }
        
    }catch(Exception e) {}
 
    }
}
