import java.io.IOException;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/regi")
public class regi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		//PrintWriter out=response.getWriter();
		
		String name=request.getParameter("t");
		String pass=request.getParameter("password");
		String email=request.getParameter("email");
		String phno=request.getParameter("ph");
		String question = request.getParameter("question");
        String answer = request.getParameter("answer");
		//String question=request.getParameter("answer");
		//String que=request.getParameter("question");
	

		// Store the security question in session
		//HttpSession session = request.getSession();
		//session.setAttribute("securityQuestion", que);
//System.out.println("sec"+que);
		try
		{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb","user","");
		   System.out.println("Database Connected Successfully!");
		PreparedStatement ps=con.prepareStatement("insert into register (name, email,password, phone,answer,question) VALUES (?, ?, ?, ?,?,?)");
		
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setString(3, pass);
		ps.setString(4, phno);
		ps.setString(5, answer);
		ps.setString(6, question);
		int i=ps.executeUpdate();
		if(i>0)
		{
			response.sendRedirect("front.html");
			
			System.out.println("successfully registered");
			 
		}
		
		}catch(Exception e)
		{
			System.out.println(e);
	}
	}
}
	


