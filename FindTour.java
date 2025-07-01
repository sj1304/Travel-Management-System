
import java.beans.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/FindTour")
public class FindTour extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userid") == null) {
            response.sendRedirect("user_login.html"); // Redirect to login if session expired
            return;
        }
        ResultSet rs=null;
        String tourtype1=request.getParameter("tourType");
        
        int userId = (int) session.getAttribute("userid");
       
        String selectedTour =(String) session.getAttribute("temp");
        System.out.println("tourid="+session.getAttribute("temp"));
       // String uname = (String) session.getAttribute("username");
       // int tourid = (String) session.getAttribute("tid1");
        
        Connection con;
        System.out.println("Session Username: " + session.getAttribute("username"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
            if(con!=null)
            {
            	System.out.println("111111Database Connected Successfully!");
            }
            else {
            	System.out.println("not done");  
            }// Check if the user already has a tour type stored
            /*st=con.createStatement();
           rs=st.executeQuery("update tid from register where tid=(select tid from tour where type='"+selectedTour+"') where uid="+userId);
            */
            String query="update register set tid=(select tid from tour where type=?) where uid=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, tourtype1);
            pst.setInt(2, userId);
            
            int rowsUpdate=pst.executeUpdate();
            
             System.out.println(rowsUpdate);
             
            /* String fetchPidQuery = "SELECT pid FROM package WHERE tid = (SELECT tid FROM register WHERE uid=?) LIMIT 1";
             PreparedStatement fetchPidStmt = con.prepareStatement(fetchPidQuery);
             fetchPidStmt.setInt(1, userId);
              rs = fetchPidStmt.executeQuery();

             if (rs.next()) {
                 String packageId = rs.getString("pid");
                 session.setAttribute("packid", packageId);  // ✅ Store package ID in session
                 System.out.println("✔ Stored packageId in session: in tourrr " + packageId);
             } else {
                 System.out.println("❌ No package ID found for user in database. in tourr");
             }*/
             
             // ✅ Get selected package ID from request
             String selectedPid = request.getParameter("selectedPid");
             
             if (selectedPid != null && !selectedPid.isEmpty()) {
                 session.setAttribute("packid", selectedPid);  // ✅ Store user's selected package ID in session
                 System.out.println("✔ User selected packageId: " + selectedPid);
             } else {
                 System.out.println("❌ No package ID received from request.");
             }

             response.sendRedirect("package.jsp"); // Redirect to package.jsp
         
            con.close();
            //request.getDispatcher("pack_national.jsp");
            response.sendRedirect("package.jsp");
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}